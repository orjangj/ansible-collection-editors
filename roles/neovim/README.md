Neovim
======

An Ansible Role that installs Neovim and plugins.

Highlights
----------

- Install Neovim from official release source
- Install config files 
- Automated plugin management
  - [Vim-plug](https://github.com/junegunn/vim-plug)
    - Automated setup of vim-plug
    - Invokes vim-plug on your behalf to install/update/remove plugins
    - Continue using your nvim configuration files to list preferred plugins.
    - See vim-plug for more information

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml)

    neovim_version: ""

The version of Neovim to install. The default value will skip installing Neovim. The variable must
be in the format of `vX.Y.Z` or `nightly`. The default install location is /usr/local, and thus requires privilege
escalation to work. Use `-K` option when invoking your playbook.

    neovim_configs: []

List of Neovim configuration files to install in `{{ ansible_user_dir }}/.config/nvim` directory.

    neovim_packages: []

List of Neovim package dependencies (i.e. when plugins require certain packages to be installed).
This require privilege escalation to work. Use `-K` option when invoking your playbook.

    neovim_plugin_manager: "vim-plug"

The plugin manager to use (currently only supports `vim-plug`, but planning to support native
manager).

    neovim_plugin_autoremove: false

Whether to remove unused plugins.

    neovim_plugin_autoupdate: false

Whether to update plugins.

Dependencies
------------

None

Examples
--------

```yaml
---
- hosts: all

  vars:
    neovim_version: "v0.7.0"
    neovim_configs:
      - "{{ playbook_dir }}/files/init.nvim"
    neovim_plugin_autoremove: true
    neovim_plugin_autoupdate: true

  roles:
    - orjangj.editors.neovim
```

License
-------

MIT / BSD
