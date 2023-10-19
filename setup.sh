if [ -n "$BASH_VERSION" ]; then
    echo "Your shell is BASH"
elif [ -n "$ZSH_VERSION" ]; then
    echo "Your shell is ZSH"
else
    echo "Your current shell is not Bash or Zsh. Aborting."
    exit 1
fi

mkdir -p ~/.selleo

# install Rust and Cargo so we can install other packages
if [ ! -e "/usr/bin/cargo" ] && [ ! -e "$HOME/.cargo/bin/cargo" ]; then
    echo "Cargo is not installed. Installing Rust..."
    
    # Download and run the Rust installation script
    curl https://sh.rustup.rs -sSf | sh

    # Add Rust binaries to PATH
    if [ -d "$HOME/.cargo/bin" ]; then
        export PATH="$HOME/.cargo/bin:$PATH"
    fi

    echo "Rust has been installed."
else
    echo "Cargo is already installed."
fi

# install cargo packages
echo "Installing cargo packages..."
cargo install git-delta eza bat hwatch

echo "Linking configuration files..."
ln -f -s "$(pwd)/aliases.sh" ~/.selleo/aliases.sh
ln -f -s "$(pwd)/exports.sh" ~/.selleo/exports.sh
ln -f -s "$(pwd)/rc.sh" ~/.selleo/rc.sh

. ~/.selleo/rc.sh

echo
echo "Manual steps (one time setup):"
echo "- add .gitconfig content to your git-delta configuration (or edit it manually):"
echo
echo "    cat .gitconfig >> ~/.gitconfig"
echo
echo "  now check if config was added correctly:"
echo
echo "    cat ~/.gitconfig"
echo
echo "- add this to your .zshrc or .bashrc file:"
echo
echo "    [ -f ~/.selleo/rc.sh ] && . ~/.selleo/rc.sh"
echo
