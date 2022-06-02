.ONESHELL:
SHELL := /bin/bash
SRC = $(wildcard ./*.ipynb)

all: ClickUpShiftScore docs

ClickUpShiftScore: $(SRC)
	nbdev_build_lib
	touch ClickUpShiftScore

sync:
	nbdev_update_lib

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

gitm: 
	git add --all
	git commit -m "$(commitmessage)"
	git push -u origin master

test:
	nbdev_test_nbs

release: pypi conda_release
	nbdev_bump_version

conda_release:
	fastrelease_conda_package

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rd /s /q dist