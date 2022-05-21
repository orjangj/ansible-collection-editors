Vim
===

an Ansible Role that installs Vim and plugin:

Notes
-----

When vim is installed for the first time in /usr/local/bin/vim, you might have
to restart your terminal for the terminal to pick up the new install.

A Word of advice when using plugin managers depending on the vimrc:
This role will execute vim command line to invoke the plugin installation.
Plugin managers depending on the vimrc (e.g. vim-plug) requires the vimrc to be
loaded before processing plugin operations. In situations where the vimrc
contains code that depends on plugins being installed (i.e. setting the
colorscheme to a scheme installed by vim-plug) will result in an error on the
first run of this role until the plugin has actually been installed. It's
recommended to use i.e. ':silent! colorscheme scheme" to suppress such
errors.

Requirements
------------

This role has only been tested on Ubuntu 20.04.

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml)

    vim_clone_path: "{{ ansible_user_dir }}/vim"

The directory to clone vim to.

    vim_dotfiles: []

List of dotfiles to copy to "{{ ansible_user_dir }}".

    vim_extra_features: []

List of extra features to compile vim with (i.e. `--enable-python3interp`). Note
however that extra features might require certain packages to be installed. Use
`vim_extra_packages` for that.

    vim_extra_packages: []

A list of extra vim package dependencies. Use this when required by the the
extra features.

    vim_plugin_autoremove: false

Whether to remove unused plugins.

    vim_plugin_autoupdate: false

Wheter to update plugins.

    vim_plugin_extra_packages: []

Some plugins require post-installation/compilation to work properly (i.e.
YouCompleteMe). Use this variable to install requirements for the
post-installation.

    vim_plugin_manager: "native"  # ["native", "vim-plug"]

The plugin manager to use.

> NOTE: Currently only supports `vim-plug`.

    vim_version: "master"

The version of vim to install. This could be branch name, tag or a commit.

Dependencies
------------

None

Example Playbook
----------------

Consider the following vimrc.

```
" Contents of vimrc
" ...

call plug#begin()

Plug 'ycm-core/YouCompleteMe', { 'do': './install.py'}

call plug#end()

" ...
```

The following playbook will install the latest vim version on master-branch and
install YouCompleteMe plugin using the vim-plug manager.

```yaml
# Contents of example.yml
- hosts: all
  vars:
    vim_dotfiles:
      - "{{ playbook_dir }}/files/.vimrc"
    vim_extra_packages:
      - libpython3-dev
    vim_extra_features:
      - "--enable-python3interp"
    vim_plugin_extra_packages:
      - build-essential
      - cmake
      - python3-dev
    vim_plugin_manager: "vim-plug"
  roles:
  - orjangj.editors.vim
```

ansible-playbook example.yml -K

License
-------

MIT / BSD
