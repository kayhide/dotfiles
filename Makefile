dotfiles:
	ln -sf "$$(pwd)/.gitconfig" "$$HOME/"
	ln -sf "$$(pwd)/.tigrc" "$$HOME/"
	ln -sf "$$(pwd)/.zshrc" "$$HOME/"
	ln -sf "$$(pwd)/.zsh" "$$HOME/"
	ln -sf "$$(pwd)/.tmux.conf" "$$HOME/"
.PHONY: dotfiles

iterm:
	curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
.PHONY: iterm

linuxbrew:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	test -d ~/.linuxbrew && eval $$(~/.linuxbrew/bin/brew shellenv) || true
	test -d /home/linuxbrew/.linuxbrew && eval $$(/home/linuxbrew/.linuxbrew/bin/brew shellenv) || true
	echo "eval \$$($$(brew --prefix)/bin/brew shellenv)" >> ~/.profile
.PHONY: linuxbrew

brew:
	brew install zsh tig hub readline lv direnv peco zplug entr tree
.PHONY: brew


init: dotfiles iterm linuxbrew brew
