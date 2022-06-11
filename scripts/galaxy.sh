#!/bin/bash

# Autogenerate galaxy.yml
# TODO: Use git tag as version in default case
VERSION="1.0.0"

usage()
{
   echo ""
   echo "Usage: $0 -v version"
   echo -e "\t-v Semantic version number"
   exit 1 # Exit script after printing help
}


while getopts "v:" opt
do
   case "$opt" in
      v ) VERSION="$OPTARG" ;;
      ? ) usage  ;;
   esac
done

cat << EOF > galaxy.yml
namespace: orjangj

name: editors

version: $VERSION

readme: README.md

authors:
  - Ørjan Gjengedal <orjan.gjengedal@gmail.com>

description: This collection includes Ansible roles and content to help with editor automation

license:
  - MIT

tags:
  - editors
  - vscode
  - vim

dependencies: {}

repository: https://github.com/orjangj/ansible-collection-editors

documentation: https://github.com/orjangj/ansible-collection-editors

homepage: https://github.com/orjangj/ansible-collection-editors

issues: https://github.com/orjangj/ansible-collection-editors/issues

build_ignore:
  - fixture
  - molecule
  - scripts
  - '*.tar.gz'
EOF

