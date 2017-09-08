NAME=borgbackup-bin
BIN64_URL=$(shell wget https://api.github.com/repos/borgbackup/borg/releases/latest -qO - |jq --raw-output '.assets[] | select(.name == "borg-linux64") | .browser_download_url')
BIN32_URL=$(shell wget https://api.github.com/repos/borgbackup/borg/releases/latest -qO - |jq --raw-output '.assets[] | select(.name == "borg-linux32") | .browser_download_url')
VERSION=$(shell wget https://api.github.com/repos/borgbackup/borg/releases/latest -qO - |jq --raw-output '.tag_name')

.PHONY: clean package64 package32

all: clean package64 package32

clean:
	rm -f $(NAME)_*.deb

prepare:
	mkdir -p src/usr/bin
	if [ ! -e src/usr/bin/borg ]; then  cd src/usr/bin/ ; ln -s borgbackup borg ; fi

package64: prepare
	wget $(BIN64_URL) -qO src/usr/bin/borgbackup
	fpm -s dir -t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-m alernc@webelys.com \
		--conflicts borgbackup \
		--category admin \
		--architecture amd64 \
		--chdir src \
		.
		
package32: prepare
	wget $(BIN32_URL) -qO src/usr/bin/borgbackup
	fpm -s dir -t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-m alernc@webelys.com \
		--conflicts borgbackup \
		--category admin \
		--architecture i386 \
		--chdir src \
		.