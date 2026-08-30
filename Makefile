dotfiles:
	ln -sf "$$(pwd)/.tigrc" "$$HOME/"
	ln -sf "$$(pwd)/.zshrc" "$$HOME/"
	ln -sf "$$(pwd)/.zshenv" "$$HOME/"
	ln -sf "$$(pwd)/.zsh" "$$HOME/"
	ln -sf "$$(pwd)/.tmux.conf" "$$HOME/"
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

${HOME}/bin/%: bin/%
	mkdir -p ${HOME}/bin
	ln -s $(shell pwd)/$< $@

bin: $(addprefix ${HOME}/, $(shell find bin -type f))
.PHONY: bin

iterm:
	curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
	curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
.PHONY: iterm

homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"	
	echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
.PHONY: homebrew

brew:
	brew install tig delta hub ghq readline lv direnv fd fzf zplug entr tree ripgrep ffmpeg helix
.PHONY: brew

cask:
	brew install --cask dropbox google-chrome google-japanese-ime karabiner-elements slack zoom
.PHONY: cask

claude:
	curl -fsSL https://claude.ai/install.sh | bash
.PHONY: claude

dotclaude:$(addprefix ${HOME}/,$(shell find .claude -type f))
.PHONY: dotclaude

${HOME}/.claude/settings.json: .claude/settings.json
	mkdir -p $(@D)
	envsubst < $< > $@

${HOME}/.claude/%: .claude/%
	mkdir -p $(@D)
	ln -sf $(shell pwd)/$< $@

# (Re)install the passwordless sudoers entry yabai needs to load its
# scripting addition. The entry pins a hash of the yabai binary, so it must
# be regenerated after every `brew upgrade yabai` (or a --HEAD rebuild).
# env -u TERMINFO: kitty exports TERMINFO, which sudo refuses to accept.
yabai-sa:
	echo "$$(whoami) ALL=(root) NOPASSWD: sha256:$$(shasum -a 256 $$(which yabai) | cut -d ' ' -f 1) $$(which yabai) --load-sa" \
		| env -u TERMINFO sudo tee /private/etc/sudoers.d/yabai
	env -u TERMINFO sudo yabai --load-sa
.PHONY: yabai-sa

stub-ollama:
	plutil -insert EnvironmentVariables.OLLAMA_HOST -string '0.0.0.0' /opt/homebrew/opt/ollama/homebrew.mxcl.ollama.plist 2>/dev/null || \
	plutil -replace EnvironmentVariables.OLLAMA_HOST -string '0.0.0.0' /opt/homebrew/opt/ollama/homebrew.mxcl.ollama.plist
.PHONY: stub-ollama

init-mac: dotfiles homebrew brew cask
.PHONY: init-mac

init-linux: dotfiles linuxbrew brew
.PHONY: init-linux


verify-sudo:
	@echo "Permission required."
	test $$USER = root
	@echo "...OK"
.PHONY: verify-sudo

xps15: xps15-brightness # For Ubuntu
xps15: xps15-mayu
.PHONY: xps15

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
