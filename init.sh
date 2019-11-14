#!/bin/bash -e

echo "This amazing script will help you create a new python project.
"

while ! test "$PROJECT_USER"; do
    echo "Enter your name:"
    read -p "> " PROJECT_USER
done

while ! test "$PROJECT_NAME"; do
    echo "Enter the name of your project:"
    read -p "> " PROJECT_NAME
done

echo "Enter a short description of your project:"
read -p "> " PROJECT_DESC

echo "If you want to create an executable script, enter its name; otherwise (lib) leave this empty:"
read -p "> " PROJECT_EXE

while ! test "$PROJECT_GIT"; do
    echo "Enter the git url of your project:"
    read -p "> " PROJECT_GIT
done

while ! test "$PROJECT_PATH"; do
    echo "Enter the absolute path of your project:"
    read -p "> " PROJECT_PATH
    if test -d "$PROJECT_PATH"; then
        echo "$PROJECT_PATH" already exists
        PROJECT_PATH=
    fi
done


mkdir "$PROJECT_PATH"
cp -a . "$PROJECT_PATH"
mv "$PROJECT_PATH"/{.,}README.md
rm -rf "$PROJECT_PATH"/{.git,init.sh}
git init "$PROJECT_PATH"

sed -i "s|%PROJECT_NAME%|$PROJECT_NAME|g" "$PROJECT_PATH"/Makefile
sed -i "s|%PROJECT_USER%|$PROJECT_USER|g" "$PROJECT_PATH"/Makefile

sed -i "s|%PROJECT_NAME%|$PROJECT_NAME|g" "$PROJECT_PATH"/README.md
sed -i "s|%PROJECT_DESC%|$PROJECT_DESC|g" "$PROJECT_PATH"/README.md
sed -i "s|%PROJECT_GIT%|$PROJECT_GIT|g" "$PROJECT_PATH"/README.md

sed -i "s|%PROJECT_NAME%|$PROJECT_NAME|g" "$PROJECT_PATH"/setup.py
sed -i "s|%PROJECT_USER%|$PROJECT_USER|g" "$PROJECT_PATH"/setup.py
sed -i "s|%PROJECT_DESC%|$PROJECT_DESC|g" "$PROJECT_PATH"/setup.py
sed -i "s|%PROJECT_GIT%|$PROJECT_GIT|g" "$PROJECT_PATH"/setup.py
sed -i "s|%PROJECT_EXE%|$PROJECT_EXE|g" "$PROJECT_PATH"/setup.py

mv "$PROJECT_PATH"/src/PROJECT_NAME "$PROJECT_PATH/src/$PROJECT_NAME"
sed -i "s|%PROJECT_NAME%|$PROJECT_NAME|g" "$PROJECT_PATH/src/$PROJECT_NAME/__init__.py"
sed -i "s|%PROJECT_NAME%|$PROJECT_NAME|g" "$PROJECT_PATH/src/$PROJECT_NAME/__main__.py"

if ! test "$PROJECT_EXE"; then
    sed -i -E "s/    (entry_points=.*)/    # \1/" "$PROJECT_PATH"/setup.py
    rm "$PROJECT_PATH/src/$PROJECT_NAME/__main__.py"
fi

(
    cd $PROJECT_PATH
    git add -A .
    git commit -m "Initial commit"
)


echo "
Your project has been generated in $PROJECT_PATH!"

if test "$PROJECT_EXE"; then
    echo "
An example of 'main' has been created in '$PROJECT_PATH/src/$PROJECT_NAME/hello_world.py'
It is called from '$PROJECT_PATH/src/$PROJECT_NAME/__main__.py', so if you have so renaming to do, it's there.
"
else
    echo "
An example function for your lib has been created in '$PROJECT_PATH/src/$PROJECT_NAME/hello_world.py'.
You should also take look into '$PROJECT_PATH/src/$PROJECT_NAME/__init__.py' on how to export function to the end user.
"
fi

echo "Don't forget to add your dependencies in setup.py, in the 'install_requires' array."
