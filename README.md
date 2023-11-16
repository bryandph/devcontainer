# Devcontainer

This Devcontainer implements a nice ZSH shell in a Debian environment with support for ASDF and Direnv.

Included are docker-compose files to build the devcontainer and add services. 





```json
// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/powershell
{
	"name": "bryanph-site",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	// "build": {
	// 	// Sets the run context to one level up instead of the .devcontainer folder.
	// 	"context": ".",
	// 	// Update the 'dockerFile' property if you aren't using the standard 'Dockerfile' filename.
	// 	"dockerfile": "Containerfile"
	// },
    // "image": "gitlab.personal.bryanph.com:5050/bryanph/devcontainer:latest"
	"dockerComposeFile": "docker-compose.yml",
	"service": "devcontainer",
	"workspaceFolder": "/workspace",
	"overrideCommand": false,
	"postStartCommand": "/home/vscode/asdf-post-create.sh",
	// "postAttachCommand": [],
	// Configure tool-specific properties.
	"customizations": {
		// Configure properties specific to VS Code.
		"vscode": {
			// Set *default* container specific settings.json values on container create.
			"settings": {
				"editor.tabSize": 4,
				"terminal.integrated.defaultProfile.linux": "zsh",
				"terminal.integrated.profiles.linux": {
					"bash": {
						"path": "bash",
						"icon": "terminal-bash"
					},
					"zsh": {
						"path": "zsh"
					}
				}
			},
			// Add the IDs of extensions you want installed when the container is created.
			"extensions": [
				"nguyenngoclong.asdf"
			]
		}
	},
	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	"forwardPorts": [
		3000
	]
	// Uncomment to connect as root instead. More info: https://aka.ms/dev-containers-non-root.
	// "remoteUser": "root"
}
```