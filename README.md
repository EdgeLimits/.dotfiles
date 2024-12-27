# EdgeLimits .dotfiles
## 0. Pre-requisites

- Xcode
- Homebrew

```bash
xcode-select --install
```

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 1. Installation

1. Clone this repo into your home directory
```bash
git clone git@github.com:EdgeLimits/.dotfiles.git ~/.dotfiles
```

2. Clone TMUX Plugin Manager
```bash
git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
```
```

3. Go to .dotfiles directory and update submodules
```bash
cd ~/.dotfiles
git submodule update --init --recursive
```

4. Run the following commands
```bash
chmod +x install
chmod +x macos-packages
chmod +x macos

./macos-packages # for the first time
```

5. Run the following command
```bash
~/.dotfiles/macos

```

## 2. Setup
1. Start TMUX
```bash
tmux
```

2. Install TMUX plugins
```bash
Ctrl + I
```
