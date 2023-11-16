# Devcontainer

This Devcontainer implements ZSH shell in a Debian environment with support for ASDF and Direnv.

The container and embeded `devcontainer.json` are designed to run in Docker Compose (or equivilent docker compose tool).

To use this repo I suggest creating the following files in a repo and opening the repo as a [devcontainer in VSCode](https://code.visualstudio.com/docs/devcontainers/containers):


##### .devcontainer/devcontainer.json
```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/powershell
{
    "name": "devcontainer",
    "dockerComposeFile": "docker-compose.yml",
    "service": "devcontainer",
    "workspaceFolder": "/workspace",
	  // "postStartCommand": "", // Uncomment to disable ASDF .tool-versions install on container start
    "mounts": [
    ],
	"forwardPorts": [
	]
}
```

##### .devcontainer/docker-compose.yml
```yaml
version: '3.8'
services:

  devcontainer:
    image: gitlab.personal.bryanph.com:5050/bryanph/devcontainer:latest
    volumes:
      - ..:/workspace:cached
    command: -c sleep infinity
```

I also highly recommend [configuring dotfiles in VSCode](https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories) to enhance the rather bare zsh installed by default. My dotfiles are in `bryandph/dotfiles`.

Additionally, you can configure ASDF and direnv and bootstrap your development environment by creating files like:

##### .envrc (but don't track this file in VCS if you plan to expose secrets here)
```shell
export SOMEVAR = "SOME VALUE"

use asdf
```

##### .tool-versions
```
python 3.11.5
```