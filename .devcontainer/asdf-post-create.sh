#!/usr/bin/zsh

cd "${0%/*}/.."

asdf plugin add asdf-plugin-manager https://github.com/asdf-community/asdf-plugin-manager.git
asdf install asdf-plugin-manager latest
asdf global asdf-plugin-manager latest
asdf plugin-add direnv
asdf direnv setup --shell zsh --version latest
asdf global direnv latest

asdf-plugin-manager export > ~/.plugin-versions


# find all .tool-versions within the repo, but ignore all hidden directories
# /bin/find /workspaces -type d -path '*/.*' -prune -o -name '*.tool-version*' -print | while read filePath; do
#   echo "asdf setup for $filePath"

#   # install all required plugins
#   cat $filePath | cut -d' ' -f1 | grep "^[^\#]" | xargs -i asdf plugin add {}

#   # install all required versions
#   (cd $(dirname $filePath) && direnv allow && asdf install)
# done

/bin/find /workspaces -type d -path '*/.*' -prune -o -name '*.plugin-versions*' -print | while read filePath; do
  echo "asdf setup for $filePath"
  cd $(dirname  "$filePath")
  asdf-plugin-manager add-all
done
