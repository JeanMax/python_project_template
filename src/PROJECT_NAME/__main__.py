"""
Entrypoint module, in case you use `python -m %PROJECT_NAME%`.


Why does this file exist, and why __main__? For more info, read:

- https://www.python.org/dev/peps/pep-0338/
- https://docs.python.org/2/using/cmdline.html#cmdoption-m
- https://docs.python.org/3/using/cmdline.html#cmdoption-m

  Also see (1) from http://click.pocoo.org/5/setuptools/#setuptools-integration
"""

from %PROJECT_NAME%.hello_world import main

if __name__ == "__main__":
    main()
