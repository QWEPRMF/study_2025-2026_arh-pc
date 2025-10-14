SHELL := /bin/bash
COURSE =

.PHONY: all clean

all: help

help:
	 @echo 'Usage:'
	 @echo '  make <target>'
	 @echo
	 @echo 'Targets:'
	 @grep -E '^[a-zA-Z_0-9.-]+:.*?##.*$$' $(MAKEFILE_LIST) | grep -v '###' | sort | cut -d: -f1- | awk 'BEGIN {FS = ":.*?##"}; {print $$1}'
	 @grep -E '^###.*' $(MAKEFILE_LIST) | cut -d' ' -f2- | awk 'BEGIN {FS = "###"}; {printf "%s\n", $$1, $$2}'
	 @grep -E '^[a-zA-Z_0-9.-]+:.*?###.*$$' $(MAKEFILE_LIST) | sort | cut -d: -f2- | awk 'BEGIN {FS = ":.*?###"}; {printf "  \033[36m%s\033[0m\n", $$1}'
	 @echo

list:   ## List of courses
	 @. ./template/config/script/list-courses

prepare:        ## Generate directories structure
	 mkdir -p build
	 echo "Project prepared"
	 touch prepare

submodule:      ## Update submodules
	 git submodule update --init --recursive
	 git submodule foreach 'git fetch origin; git checkout $$(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$$(git rev-parse --abbrev-ref HEAD)'
