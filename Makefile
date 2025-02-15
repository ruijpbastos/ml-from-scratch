#Signifies our desired python version
# Makefile macros (or variables) are defined a little bit differently than traditional bash, keep in mind that in the Makefile there's top-level Makefile-only syntax, and everything else is bash script syntax.
VENV_NAME=venv
VENV_CREATE =python3 -m venv ${VENV_NAME}
VENV_ACTIVATE=. $(VENV_NAME)/bin/activate
PYTHON=${VENV_NAME}/bin/python3

# .PHONY defines parts of the makefile that are not dependant on any specific file
# This is most often used to store functions
.PHONY = help init test run clean lint

# Defines the default target that `make` will to try to make, or in the case of a phony target, execute the specified commands
# This target is executed whenever we just type `make`
.DEFAULT: help

# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "------------------------HELP---------------------------"
	@echo "make init     - To setup the project"
	@echo "make venv     - To create the virtual environment"
	@echo "make req      - To update python requirements"
	@echo "make test     - To test the project"
	@echo "make run      - To run the code"
	@echo "make clean    - To clean the project"
	@echo "make lint     - To lint the code"
	@echo "-------------------------------------------------------"

init: venv
	${PYTHON} -m pip install --upgrade pip
	${PYTHON} -m pip install -U -r requirements.txt

venv:
	test -d $(VENV_NAME) || ${VENV_CREATE} # tests if venv exists, else create it
	$(VENV_ACTIVATE)

req: venv
	${PYTHON} -m pip freeze > requirements.txt

test: venv
	${PYTHON} -m pytest

run: venv
	${PYTHON} main.py

clean:
	rm -rf ${VENV_NAME}

lint: venv
	${PYTHON} -m black main.py

