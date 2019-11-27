# Python Project Template

This repo is meant to be use as a template for your other python projects. Just clone it, run ```init.sh```, fill in the informations needed, and you should be good to go!


## Code organisation

Your python code should be placed in the folder ```src/<PROJECT_NAME>```
* If your project is a library, an example file ```hello_world.py``` has been created with a dummy function. That function is included in ```src/<PROJECT_NAME>/__init__.py``` as an example on how to export a function to the end user of your library.
* If your project is a script, the same ```hello_world.py``` file will serve as an example of 'main'. It is called from ```src/<PROJECT_NAME>/__main__.py```, so if you have renaming to do, it's there.


## Pip Package: setup.py

[What is setup.py?](https://stackoverflow.com/questions/1471994/what-is-setup-py/23998536#23998536) on Stack Overflow <br />
Basically, it will allow you to package your new awesome project using either ```pip install .``` or ```python setup.py install```. <br />
Then, you will be able to use your package in a standard way: ```import <PROJECT_NAME>``` <br />
<br />
Don't forget to add your dependencies in ```setup.py```, in the 'install_requires' array.


## Installation: Makefile

To ease the process of installing/linting/testing your project, a Makefile is available.
* If you don't specify any target, the default install process will be launched (ie: the dev install, with an editable python package).
You'd run it like this:
```
make
```
It is the same as:
```
make dev
```
An 'editable' installation means that the package installed will actually be a link to your project folder, so every modification that you'd make to your codebase will be automatically available in the installed package.

* To test your project, run:
```
make test
```
It will launch the tests found in the ```tests``` folder. An example test is generated in there, and it should be pretty straight forward for you to add any other test that you'd need.

* To lint your project, run:
```
make lint
```
which will trigger pylint (that linter is always bitching about something), or if you want flake8 (way less false positive):
```
make flake
```
