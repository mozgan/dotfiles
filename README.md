# dotfiles

dotfiles

# Steps

- Install command-line tools

```shell
xcode-select --install
```

- Install brew

```shell
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew doctor
```

- Install Nerd Fonts

```shell
$ brew tap homebrew/cask-fonts
$ brew search '/font-.*-nerd-font/' | awk '{ print $1 }' | xargs -I{} brew install --cask {} || true
```

- Install oh-my-zsh

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Install zsh plugins

```shell
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
$ git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

- Install Powerlevel10k

```shell
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

- Install Python

```shell
$ brew rm python
$ brew rm python3
$ rm -rf /usr/local/opt/python
$ rm -rf /usr/local/opt/python3
$ brew install python3
$ brew postinstall python3
$ python3 -m pip install --upgrade setuptools
```

- Install tools via brew

  - fortune, lolcat, cowsay, trash, exa
  - kitty
  - llvm, clang-format, cmake, cpplint, cppman
  - cppman
  - macvim, nvim, neovide
  - wget, ranger, fzf, ripgrep, fd, htop, ncdu
  - lazygit, proselint, flake8, isort, jsonlint, jq, shfmt
  - node, pyright, prettier

- Install tools via pip

  - cmake_tools

- cppman config

```shell
$ cppman -s cppreference.com
$ cppman -C
$ cppman -c
```

- node config

```shell
npm install -g neovim
```

- NeoVim Plugins

  - Colors: tokyonight, catppuccin, gruvbox-material, PaperColor
  -

