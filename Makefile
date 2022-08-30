dotfiles:
	ln -sf "$$(pwd)/.gitconfig" "$$HOME/"
	ln -sf "$$(pwd)/.tigrc" "$$HOME/"
	ln -sf "$$(pwd)/.zshrc" "$$HOME/"
	ln -sf "$$(pwd)/.zsh" "$$HOME/"
	ln -sf "$$(pwd)/.tmux.conf" "$$HOME/"
	ln -sf "$$(pwd)/.spacemacs" "$$HOME/"
	ln -sf "$$(pwd)/.magic" "$$HOME/"
.PHONY: dotfiles

dotconfig: $(addprefix ${HOME}/,$(shell find .config -type f))
.PHONY: dotconfig

${HOME}/.config/%: .config/%
	mkdir -p $(@D)
	ln -sf $(shell pwd)/$< $@

emacs-private: $(addprefix ${HOME}/,$(shell find .emacs.d/private/local -type d))
.PHONY: emacs-private

${HOME}/.emacs.d/private/local/%: .emacs.d/private/local/%
	ln -s $(shell pwd)/$< $@

kak:
	ghq get -p mawww/kakoune
	mkdir -p ~/.config/kak/plugins
	git clone git@github.com:andreyorst/plug.kak ~/.config/kak/plugins/plug.kak
	# ln -sf $(shell ghq root)/github.com/mawww/kakoune/share/kak/autoload ~/.config/kak/autoload
.PHONY: kak
	
iterm:
	curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
.PHONY: iterm

linuxbrew:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
	$(eval PATH+=~/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/bin:$$PATH )
	echo "eval \$$($$(brew --prefix)/bin/brew shellenv)" >> ~/.profile
.PHONY: linuxbrew


homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
	echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
.PHONY: homebrew

brew:
	brew install tig hub readline lv direnv fzf zplug entr tree ripgrep ffmpeg
.PHONY: brew

cask:
	brew install --cask alfred bettertouchtool dropbox google-chrome google-japanese-ime iterm2 karabiner-elements slack zoom
.PHONY: cask

init-mac: dotfiles homebrew brew cask
.PHONY: init-mac

init-linux: dotfiles iterm linuxbrew brew
.PHONY: init-linux


verify-sudo:
	@echo "Permission required."
	test $$USER = root
	@echo "...OK"
.PHONY: verify-sudo

xps15: xps15-brightness # For Ubuntu
# xps15: bin-dell-brightness # For Pop!_OS
xps15: xps15-mayu
.PHONY: xps15

bin-dell-brightness:
	@mkdir -p "$$HOME/bin"
	ln -s $(pwd)/bin/dell-brightness "$$HOME/bin/"
.PHONY: bin-dell-brightness

xps15-brightness: verify-sudo
	cp dell-xps15/dell-brightness/dell-brightness-down /etc/acpi/events/
	cp dell-xps15/dell-brightness/dell-brightness-up /etc/acpi/events/
	cp dell-xps15/dell-brightness/dell-brightness.sh /etc/acpi/
	acpid reload
.PHONY: xps15-brightness

xps15-mayu: verify-sudo
	ln -sf "$$(pwd)/.mayu" "/root/"
	cp dell-xps15/mayu/mayu.service /etc/systemd/system/
	systemctl enable mayu
	systemctl start mayu
.PHONY: xps15-mayu
