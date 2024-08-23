# asdf-gitui <!-- omit in toc -->

[![Build](https://github.com/looztra/asdf-gitui/actions/workflows/code_checks.yml/badge.svg)](https://github.com/looztra/asdf-gitui/actions/workflows/code_checks.yml)
[![Build](https://github.com/looztra/asdf-gitui/actions/workflows/workflows_checks.yml/badge.svg)](https://github.com/looztra/asdf-gitui/actions/workflows/workflows_checks.yml)
[![GitHub license](https://img.shields.io/github/license/looztra/asdf-gitui?style=plastic)](https://github.com/looztra/asdf-gitui/blob/master/LICENSE)

[gitui](https://github.com/extrawurst/gitui) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Contents](#contents)
- [Build History](#build-history)
- [Dependencies](#dependencies)
- [Install](#install)
  - [add the plugin](#add-the-plugin)
  - [install gitui](#install-gitui)
- [Contributing](#contributing)
- [License](#license)

## Build History

[![Build history](https://buildstats.info/github/chart/looztra/asdf-gitui?branch=main)](https://github.com/looztra/asdf-gitui/actions)

## Dependencies

- `bash`, `curl`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- a python 3 runtime (provided through [asdf-python](https://github.com/asdf-community/asdf-python) or not)

## Install

### add the plugin

```shell
asdf plugin add gitui
```

Or:

```shell
asdf plugin add copier https://github.com/looztra/asdf-copier.git
```

### install gitui

```shell
# Show all installable versions
asdf list all gitui

# Install latest version
asdf install gitui latest

# Set a version globally (on your ~/.tool-versions file)
asdf global gitui latest

# Now copier commands are available
gitui --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/looztra/asdf-gitui/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Christophe Furmaniak](https://github.com/looztra/)
