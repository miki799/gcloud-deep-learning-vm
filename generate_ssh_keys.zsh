#!/bin/zsh

help() {
    cat <<EOF
Usage: ./generate_ssh_keys [options] <USER> <PROJECT_ID>

Generated ed25519 keys are saved in the ~/.ssh directory

Options:
  -h, --help       Show this help message and exit.

Arguments:
  <USER>            The username to associate with the generated SSH key.
  <PROJECT_ID>  The Google Cloud project ID for which the SSH key is created.

Example:
  ./generate_ssh_keys user1 project-12345
EOF
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    help
    exit 0
fi

if [[ $# -ne 2 ]]; then
    echo "Error: Invalid arguments."
    echo "Use -h or --help for usage information."
    exit 1
fi

USER=$1
PROJECT_ID=$2

ssh-keygen -t ed25519 -f ~/.ssh/gcloud-${PROJECT_ID} -C ${USER}