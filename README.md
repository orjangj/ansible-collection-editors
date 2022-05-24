# Ansible collection for editors

This collection includes Ansible roles and content to help with editor automation.

Roles included in this collection:

  - `orjangj.editors.vscode` ([documentation](https://github.com/orjangj/ansible-collection-editors/blob/master/roles/vscode/README.md))
  - `orjangj.editors.vim` ([documentation](https://github.com/orjangj/ansible-collection-editors/blob/master/roles/vim/README.md))

## Installation

Currently not installable from Ansible Galaxy. Historically this collection has been for personal use only.

Install using `ansible-galaxy` with git url:

```
ansible-galaxy collection install git+https://github.com/orjangj/ansible-collection-editors.git
```

Or include this collection in your playbook's `requirements.yml` file:

```
---
collections:
  - name: https://github.com/orjangj/ansible-collection-editors.git
    type: git
    version: master
```

## Usage

See role documentation.

## License

MIT
