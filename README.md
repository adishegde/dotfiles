# Dotfiles

This is the customary dotfile repo maintained by anyone who's wasted a
**lot** of time customizing their editor and terminal.

**Note:** A lot of the initial configuration has been copied from other sources.
I wasn't in the habit of mentioning the sources at the time and so I apologize
if content has been copied without due credit.

Also, everything might not work out of the box. The configurations are for a
MacOS with an iTerm2 but should work well on most Linux OS.

## Tmux

The Tmux configuration is pretty minimal and should work as is.
Place the `.tmux.conf` file into `~/.tmux.conf`.

## Emacs

This repo actually contains [spacemacs](http://spacemacs.org/) configuration
file.

To use the configuration you'll need to:

- Download and install [spacemacs](http://spacemacs.org/)
- Copy/Symlink `spacemacs` into `~/.spacemacs` file (the configuration file
for spacemacs).

I now use NeoVim instead of emacs/spacemacs. The reason for the shift was that
Spacemacs was getting quite slow and a lot of things were preconfigured making
it harder to get the exact behaviour I wanted.

## NeoVim

Modal editing is the only true way to edit text. NeoVim is one of the best
modal text editors out there.

If you want to switch to Vim from editors like Atom, VScode, Sublime text etc.
then I suggest using [spacevim](https://spacevim.org/).

My current nim/neovim configuration is minimal and configured to suit my needs.
It uses [vim-plug](https://github.com/junegunn/vim-plug) as the plugin manager.

To use the configuration:

- Download and install [neovim](https://neovim.io/).
- Download and install [vim-plug](https://github.com/junegunn/vim-plug).
- Create python2 virtual environments at `~/.local/share/nvim/python2` and run `pip install neovim`.
- Create python3 virtual environments at `~/.local/share/nvim/python3` and run `pip install neovim`.
- Copy/Symlink `init.vim` into `~/.config/nvim/init.vim` (the neovim config file).
- Run `nvim` and then type `:PlugInstall`.

The python virtual environments are required for running python based neovim
plugins. It's better to maintain a seperate python installation for neovim.

To use some of the plugins like `ranger` and `fzf` you'll need to also install
the corresponding programs and configure it. The `zshrc` file contains the
required configuration but it I'm not sure it will work out of the box.

## Zsh

The current configuration uses [prezto](https://github.com/sorin-ionescu/prezto)
as the plugin manager for zsh. It also uses [spaceship](https://github.com/denysdovhan/spaceship-prompt)
as the prompt. It uses [snazzy](https://github.com/sindresorhus/iterm2-snazzy)
as the terminal theme.

To use the configuration:

- Download and install zsh.
- Download and install [prezto](https://github.com/sorin-ionescu/prezto). Don't
forget to copy the files from prezto/runcoms as suggested in the prezto/README.
- Download and install [spaceship](https://github.com/denysdovhan/spaceship-prompt).
- Download and install the [snazzy](https://github.com/sindresorhus/iterm2-snazzy)
theme. It's also available for other Terminals.
- Copy/Symlink `zshrc` into `~/.zshrc`.
- Copy/Symlink `zpreztorc` into `~/.zpreztorc`.
- Copy/Symlink `zprofile` into `~/.zprofile`.
- Copy/Symlink `zshenv` into `~/.zshenv`.
- Copy/Symlink `zlogin` into `~/.zlogin`.
- Copy/Symlink `zlogout` into `~/.zlogout`.
- Source the new zshrc file.

## Ranger

Ranger is a file manager for the console. The current neovim
configuration uses ranger as the file manager.

To use the configuration:

- Download and install [ranger](https://ranger.github.io/ranger-stable.tar.gz).
- Copy/Symlink `rc.conf` to `~/.config/ranger/rc.conf`.
- Copy/Symlink `rifle.conf` to `~/.config/ranger/rifle.conf`.

With the current configuration ranger should work properly in neovim and
console.

## Git

To use the configuration:

- Change Name and Email in gitconfig.
- Copy/Symlink `gitconfig` to `~/.gitconfig`.
- Copy/Symlink `gitignore_global` to `~/.gitignore_global`.
