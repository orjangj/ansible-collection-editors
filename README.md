# Ansible collection for editors

[![CI](https://github.com/orjangj/ansible-collection-editors/workflows/CI/badge.svg?event=push)](https://github.com/orjangj/ansible-collection-editors/actions?query=workflow%3ACI)

This collection includes Ansible roles and content to help with editor automation.

Roles included in this collection:

  - `orjangj.editors.vscode` ([documentation](https://github.com/orjangj/ansible-collection-editors/blob/master/roles/vscode/README.md))
  - `orjangj.editors.vim` ([documentation](https://github.com/orjangj/ansible-collection-editors/blob/master/roles/vim/README.md))

## Usage

Install this collection locally:

```bash
ansible-galaxy collection install orjangj.editors -p ./collections
```

Use the roles from the collection in your playbooks:

```yaml
---
- hosts: all

  roles:
    - role: orjangj.editors.vscode
      vars:
        vscode_user_settings: "{{ playbook_dir }}/files/vscode-settings.json"
        vscode_extensions:
          - ms-azuretools.vscode-docker
          - ms-python.python
    - role: orjangj.editors.vim
      vars:
        vim_version: "HEAD"
        vim_extra_packages:
          - "make"
          - "clang"
          - "libtool-bin"
          - "python3-dev"
        vim_extra_features:
          - "--enable-python3interp"
        vim_dotfiles:
          - "{{ playbook_dir }}/files/.vimrc"
        vim_plugin_autoremove: true
        vim_plugin_autoupdate: true
        vim_plugin_install:
          - { name: "junegunn/fzf", type: "start", hook: "./install --all" }
          - { name: "junegunn/fzf.vim", type: "start" }
          - { name: "ycm-core/YouCompleteMe", type: "start", hook: "./install.py" }
```

See role documentation for more detailed usage of each role.

## License

MIT
