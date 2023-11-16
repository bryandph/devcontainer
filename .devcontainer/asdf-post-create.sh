#!/usr/bin/zsh

cd "${0%/*}/.."

asdf plugin-add direnv
asdf direnv setup --shell zsh --version latest
echo "direnv 2.32.3" >> /home/vscode/.tool-versions

# find all .tool-versions within the repo, but ignore all hidden directories
/bin/find /workspaces -type d -path '*/.*' -prune -o -name '*.tool-version*' -print | while read filePath; do
  echo "asdf setup for $filePath"

  # install all required plugins
  cat $filePath | cut -d' ' -f1 | grep "^[^\#]" | xargs -i asdf plugin add {}

  # install all required versions
  (cd $(dirname $filePath) && direnv allow && asdf install)
done

# automatically startup a docker-compose that exists in the devcontainer folder
# if test -f $CODESPACE_VSCODE_FOLDER/.devcontainer/docker-compose.yml; then
#   echo "docker-compose found, starting up"
#   (cd $CODESPACE_VSCODE_FOLDER/.devcontainer && docker compose up -d)
# fi