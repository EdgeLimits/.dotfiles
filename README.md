# .dotfiles (EdgeLimits edition)
## 0. Pre-requisites

This guide is intended for the Mac OS. If this is a fresh install, make sure you have set the following:
- Xcode
```bash
xcode-select --install
```
- Homebrew
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

3. Go to the .dotfiles directory and update submodules
```bash
cd ~/.dotfiles
git submodule update --init --recursive
```

4. Change the permission to the files to make them executable
```bash
chmod +x install
chmod +x macos-packages
chmod +x macos
```

5. (Optional) If this is a fresh install, run this file to install fonts and brew packages
```bash
./macos-packages
```

6. Create symbolic links using stow
```bash
~/.dotfiles/macos
```

## 2. Setup

If this is a fresh install, you'll need to install the TMUX package manager.
1. Start TMUX
```bash
tmux
```

2. Install TMUX plugins (\<leader\> + I)
```bash
` + I 
```
