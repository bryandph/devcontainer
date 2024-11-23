variable "REPOS" {
  default = ["gitlab.personal.bryanph.com:5050/bryanph/devcontainer"]
}

variable "BASE_IMAGES" {
  default = ["docker.io/library/ubuntu:noble", ]
}

variable "TAGS" {
  default = ["latest"]
}

target "bookworm" {
    context = ".devcontainer"
    dockerfile = "Containerfile"
    args = {
        BASE_IMAGE = "docker.io/library/debian:bookworm"
    }
    tags = ["${REPOS[0]}:${TAGS[0]}"]
}

target "arm64" {
    inherits = ["bookworm"]
    platforms = [ "linux/arm64" ]
}

target "amd64" {
    inherits = ["bookworm"]
    platforms = [ "linux/amd64" ]
}

target "all" {
    inherits = ["arm64", "amd64"]
}