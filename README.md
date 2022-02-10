# Ansible collection for editors

This collection includes Ansible roles and content to help with editor automation.

Roles included in this collection:

  - `orjangj.editors.vscode` ([documentation](https://github.com/orjangj/ansible-collection-editors/blob/master/roles/vscode/README.md))

## Supported distributions

* Ubuntu 20.04

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

Here's an example playbook which installs VSCode and configures user settings and extensions:

```yaml
- hosts: all

  vars:
    vscode_user_settings: vscode-settings.json
    vscode_extensions:
      - eamodio.gitlens
      - hediet.vscode-drawio
      - ms-azuretools.vscode-docker
      - ms-python.python
      - ms-vscode.cpptools
      - ms-vscode-remote.remote-containers
      - ms-vscode-remote.remote-ssh
      - redhat.ansible

  roles:
    - orjangj.editors.vscode
```

## License

MIT
