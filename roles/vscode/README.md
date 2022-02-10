VSCode
======

An Ansible Role that installs and configures [VSCode](https://code.visualstudio.com/).

Requirements
------------

This role has only been tested on Ubuntu 20.04.

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml)

    vscode_user_settings: ""

Empty string means VSCode will be installed with the default user settings. To override the default user settings you can provide your own `settings.yml` file as a replacement.

    vscode_user_keybindings: ""

Empty string means VSCode will be installed with the default user keybindings. To override the default user keybindings you can provide your own `keybindings.yml` file as a replacement.

    vscode_user_tasks: ""

Empty string means VSCode will be installed with the default user tasks. To override the default user tasks you can provide your own `tasks.yml` file as a replacement.

    vscode_extensions: []

By default, VSCode is installed with no extensions. You can specify the extensions you want installed using a list of Unique Identifiers. See [VSCode extensions](https://marketplace.visualstudio.com/VSCode) for extensions that can be installed (e.g. ms-python.python).

Dependencies
------------

None

Example Playbook
----------------

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

License
-------

MIT / BSD
