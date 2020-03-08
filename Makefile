dotfiles:
	ln -sf "$$(pwd)/.gitconfig" "$$HOME/"
	ln -sf "$$(pwd)/.tigrc" "$$HOME/"
	ln -sf "$$(pwd)/.zshrc" "$$HOME/"
	ln -sf "$$(pwd)/.zsh" "$$HOME/"
	ln -sf "$$(pwd)/.tmux.conf" "$$HOME/"
	ln -sf "$$(pwd)/.mayu" "$$HOME/"
	ln -sf "$$(pwd)/.spacemacs" "$$HOME/"
.PHONY: dotfiles

iterm:
	curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
.PHONY: iterm

linuxbrew:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	$(eval PATH+=~/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/bin:$$PATH )
	echo "eval \$$($$(brew --prefix)/bin/brew shellenv)" >> ~/.profile
.PHONY: linuxbrew

brew:
	brew install zsh tig hub readline lv direnv peco zplug entr tree
.PHONY: brew


init: dotfiles iterm linuxbrew brew
.PHONY: init


verify-sudo:
	@echo "Permission required."
	test $$USER = root
	@echo "...OK"
.PHONY: verify-sudo

xps15: xps15-brightness xps15-mayu
.PHONY: xps15

xps15-brightness: verify-sudo
	cp dell-xps15/dell-brightness/dell-brightness-down /etc/acpi/events/
	cp dell-xps15/dell-brightness/dell-brightness-up /etc/acpi/events/
	cp dell-xps15/dell-brightness/dell-brightness.sh /etc/acpi/
	acpid reload
.PHONY: xps15-brightness

xps15-mayu: verify-sudo
	cp dell-xps15/mayu/mayu.service /etc/systemd/system/
	systemctl enable mayu
	systemctl start mayu
.PHONY: xps15-mayu
