# macos-development-setup

## System Update

First thing first, update the system!

For that: **Apple Icon > About This Mac** then **Software Update...**

## System Preferences

- Dock

  - Remove most applications from Dock
  - Dock to the left
  - Automatic Hide
  - "Show recent applications in Dock" OFF
  - "Show indicators for open applications" ON

- Security and Privacy

  - Touch ID
  - Allow apps downloaded from App Store and identified developer

- Siri

  - Disable

- Trackpad

  - Tap to Click
  - Secondary Click: Bottom Right Corner

- Spotlight

  - Disable Spotlight except for Applications and System Preferences

- Mission ControlChange computer name

  - Hot Corners: Right Corner to display Desktop

- Sharing

  - Change computer name

  - Make sure all file sharing is disabled

## Command Line Tools

```bash
xcode-select --install
```

```bash
sudo xcode-select --switch /Library/Developer/CommandLineTools
```

## Homebrew

[Homebrew](http://brew.sh/) is a package manager: it's a software used to install other software from the command line.

Open a terminal and run the following command

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Set options for Homebrew

```bash
export HOMEBREW_CASK_OPTS="--appdir=~/Applications --fontdir=/Library/Fonts"
export HOMEBREW_NO_ANALYTICS=1
```

## Mas

[Mas](https://github.com/mas-cli/mas) is a command line interface for the App Store.

```bash
brew install mas
```

## Fonts

- InputMono: [Site](https://input.djr.com)

- Monoid: [Site](https://larsenwork.com/monoid)

## Shell

Since Catalina, macOS comes with [ZSH](https://zsh.sourceforge.io/).

I use [OMZ](https://ohmyz.sh/).

### Installation

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

In your $HOME, you should have the folder ".oh-my-zsh".

### Theme

- Bullet Train: [Site](https://github.com/caiogondim/bullet-train.zsh)

### Plugins

- Auto Suggestions: [Site](https://github.com/zsh-users/zsh-autosuggestions)

- Syntx Highlighting: [Site

## Iterm2

[Iterm2](https://iterm2.com/) is a terminal emulator for macOS.

```bash
brew install --cask iterm2
```

### Theme

- [Material Colors](./iterm2/material-design-colors.itermcolors)

In **iTerm2 Preferences**, under **Profiles** and **Colors**, go to **Color Presets... > Import...**

Now open **Color Presets...** again and select **Material Colors** to activate the theme.

## Git

**macOS\*** comes with a pre-installed version of [Git](http://git-scm.com/) but we'll install our own via Homebrew and not interfere with the system version.

```bash
brew install git
```

Define your git user in `.gitconfig`

```bash
git config --global user.name "Your Name"
git config --global user.email "your_email@youremail.com"
```

## SSH

### Generate SSH keys

```
ssh-keygen -t ed25519 -C "your_personal_email@example.com" -f ~/.ssh/<personal_key>
```

ED25519 are recommended for security and performance, but RSA with a sufficient length is also a valid alternative:

```
ssh-keygen -t rsa -b 4096 -C "your_personal_email@example.com" -f ~/.ssh/<personal_key>
```

### Add a passphrase

Next, you will be prompted to add an (optional) passphrase. **We recommend you do so** because it adds an extra layer of security: if someone gains access to
your computer, your keys will be compromised unless they are attached
to a passphrase.

To update a passphrase:

```
ssh-keygen -p -f ~/.ssh/<personnal_key>
```

### Tell SSH agent

```
eval "$(ssh-agent -s)" && ssh-add -K ~/.ssh/<personal_key>
```

### Edit SSH config

Example with Github

```
Host github.com
    HostName github.com
    IdentityFile ~/.ssh/<personal_key>
```

### Copy SSH public key

```
tr -d '\n' < ~/.ssh/<created_key>.pub | pbcopy
```

## Fix: The authenticity of host github.com (or gitlab) can't be established.

**Error**

```
The authenticity of host 'github.com (140.82.113.4)' can't be established.
```

**Fix**

```
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
```

## Visual Studio Code

### Installation

```bash
brew install visual-studio-code
```

#

## Node.js

Let's install [n](https://github.com/tj/n), a version manager for Node.js.

```bash
brew install n
```

Then install the latest version of node

```bash
n lts
```

Don't forget to set the PATH variable

```bash
export PATH="${N_PREFIX}/bin:$PATH"
```
