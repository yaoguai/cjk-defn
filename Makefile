SHELL = /bin/sh
PIP3 = pip3
PYTHON3 = python3

.PHONY: all clean dist install uninstall

all:

dist:
	$(PYTHON3) setup.py sdist

install:
	$(PIP3) install .

uninstall:
	$(PIP3) uninstall -y cjk-defn

clean:
	rm -f -- *.pyc
	rm -f -- *.pyo
	rm -f MANIFEST
	rm -rf __pycache__
	rm -rf build
	rm -rf dist
