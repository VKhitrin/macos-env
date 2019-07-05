# Function which prints an error message and then returns exit code 1
function error_exit {
    echo "$1" >&2
    exit "${2:-1}"
}

# Make sure script isn't executed on non macOS systems
if [[ $(uname) != "Darwin" ]];then
    error_exit "Please make sure you're running on macOS"
fi

# Verify brew is installed
which brew > /dev/null 2>/dev/null || error_exit "Brew is not installed, please download from https://brew.sh/"

# Verify existence of Brewfile
[ -f ./Setup/Brewfile ] || error_exit "No Brewfile is found"
echo "Uninstalling brew taps/casks:"
brew bundle --file=./Setup/Brewfile cleanup --force

# Remove Vim Plug
[ -d ~/.local/share/nvim ] && rm -rf ~/.local/share/nvim

# Restore from backup if exists
[ -f ~/.zshrc.bk ] && mv ~/.zshrc.bk ~/.zshrc
[ -f ~/.tmux.conf.bk ] && mv ~/.tmux.conf.bk ~/.tmux.conf