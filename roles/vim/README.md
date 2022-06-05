Vim
===

An Ansible Role that installs Vim and plugins.

Highlights
----------

- Install Vim from source with user-defined features
- Install dotfiles
- Automated plugin management
  - Vim 8 native plugin manager
    - version management
    - Post-install hooks to compile/build plugin dependencies after
      install/update
    - Helptags created automatically when plugin is installed/updated
    - Automated removal of unused plugins (if previously installed by this
      manager)
  - [Vim-plug](https://github.com/junegunn/vim-plug)
    - Automated setup of vim-plug
    - Invokes vim-plug on your behalf to install/update/remove plugins
    - Continue using your vimrc to list preferred plugins.
    - See vim-plug for more information

Caveats
-------

- **Please read the requirements section and the role variable section carefully.**
- If you run this role locally you might have to restart your terminal to pick
  up the installed/updated version of Vim (see `vim_version` for more details).
- Only the native plugin manager guarantees true idempotency. Invoking external
  plugin managers (i.e. vim-plug) requires executing Vim command line with your
  vimrc as input. Vim may repport errors if your vimrc contains settings that it
  cannot handle at the time of loading your vimrc (i.e. setting a colorscheme that
  hasn't been installed yet by the plugin manager). All errors reported by Vim
  is thus ignored to avoid failures in such situations (that includes errors
  reported by the plugin manager as well). Hence, this role operates with a
  "best-effort" policy when executing external plugin managers.
- When using post-install hooks for plugins, ensure the script is/can be invoked
  non-interactively. Else the role will hang (possibly indefinitely) waiting for
  the task to finish.
- This role should work on most Linux distributions, but has currently only been
  tested on Ubuntu 20.04.

Requirements
------------

- Vim > 8.0 when using the native plugin manager
- Vim > 7.0 when using the vim-plug manager
- Git 
- Any packages required for compiling the target version of  Vim from source (see
  `vim_extra_packages`).
- Any extra packages required to compile Vim with extra features (see
  `vim_extra_packages`).
- Any packages required by plugin post-install hooks (see `vim_extra_packages`).

Role Variables
--------------

Available variables are listed below, along with default values (see defaults/main.yml)

    vim_version: ""

The version of Vim to install. The default value will skip installing Vim from
source. The variable may be a branch name, tag, commit or HEAD. If HEAD or
branch name is specified, then Vim may be updated on successive runs of this
role if there are changes on remote origin. Use a tag or commit to lock the
installed version of Vim.

    vim_install_prefix: "/usr/local"

Where to install Vim. The default value is Vim's default install destination
(`/usr/local/bin`) when installing from source. This path requires privilege
escalation, so remember to use `-K` if you use the default value. It's,
recommended to change the default value to i.e. `{{ ansible_user_dir }}/.local`
to avoid privelege escalation (just remember to add the local Vim to `PATH`, and
make sure it comes before any other installed Vim in `PATH`).

    vim_clone_path: "{{ ansible_user_dir }}/vim"

Where to clone Vim to.

    vim_extra_packages: []

Use this to define package dependencies (i.e. for Vim or plugins). Note that
privelege escalation is required (use `-K` when invoking your playbook) if the
list is non-empty.

    vim_extra_features: []

List of extra features to compile Vim with. Note that extra features usually
requires certain packages to be installed prior to enabling the feature. I.e.
`--enable-python3interp` requires the `libpython3-dev` package to be installed.
See [Vim](https://github.com/vim/vim) documentation for more information.

    vim_dotfiles: []

List of dotfiles to install in `{{ ansible_user_dir }}` directory.

    vim_plugin_manager: "native"

The plugin manager to use (`native`, `vim-plug`).

    vim_plugin_install: []

List of plugins to install. This variable is only relevant in combination with
the `native` plugin manager.

```yaml
# Examples
vim_plugins_install:
  - name: "junegunn/fzf"  # Shorthand notation -> fetches from https://github.com/junegunn/fzf
    type: "start"  # Install plugin to automatically load on Vim startup
    hook: "./install --all"
    version: "0.30.0"  # Use tagged version. 'HEAD' is the default if left undefined.
  - name: "junegunn/fzf.vim"
    type: "start"
  - name: "ycm-core/YouCompleteMe"
    type: "opt"  # Install plugin as optional. Can be loaded inside Vim using :packadd
    hook: "./install.py" 
```

    vim_plugin_autoremove: false

Whether to remove unused plugins.

    vim_plugin_autoupdate: false

Whether to update plugins. When using the `native` plugin manager, this will only
have an effect on plugins that specifies versions to HEAD (default) or a branch
name.

    vim_plugin_dir: "{{ ansible_user_dir }}/.vim/pack/plugins"

Where to put start/opt plugins when using the `native` plugin manager. This should
generally be left as-is, but you can opt to rename the directories following
./vim path if you want to.

Dependencies
------------

None

Examples
--------

To install latest Vim with Python3 support, and some plugins using the native
plugin manager:

```yaml
---
- hosts: all

  vars:
    vim_version: "HEAD"
    vim_install_prefix: "{{ ansible_user_dir }}/.local"
    vim_extra_packages:
      - "make"
      - "clang"
      - "libtool-bin"
      - "python3-dev"
    vim_extra_features:
      - "--enable-python3interp"
    vim_dotfiles:
      - "{{ playbook_dir }}/files/dotfiles/.vimrc"
    vim_plugin_autoremove: true
    vim_plugin_autoupdate: true
    vim_plugin_install:
      - { name: "junegunn/fzf", type: "start", hook: "./install --all" }
      - { name: "junegunn/fzf.vim", type: "start" }
      - { name: "ycm-core/YouCompleteMe", type: "start", hook: "./install.py" }

  roles:
    - orjangj.editors.vim
```

Consider the following vimrc:

```
" Contents of vimrc
" ...

call plug#begin()

Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

call plug#end()

" ...
```

Then the following playbook should be equivalent to using the native plugin
manager example above, but with `vim-plug` instead.

```yaml
---
- hosts: all

  vars:
    vim_version: "HEAD"
    vim_install_prefix: "{{ ansible_user_dir }}/.local"
    vim_extra_packages:
      - "make"
      - "clang"
      - "libtool-bin"
      - "python3-dev"
    vim_extra_features:
      - "--enable-python3interp"
    vim_dotfiles:
      - "{{ playbook_dir }}/files/dotfiles/.vimrc"
    vim_plugin_manager: "vim-plug"
    vim_plugin_autoremove: true
    vim_plugin_autoupdate: true

  roles:
    - orjangj.editors.vim
```

License
-------

MIT / BSD
