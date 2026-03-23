#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# NOTE:
# Use /usr/bin/env to find shell interpreter for better portability.
# Reference: https://en.wikipedia.org/wiki/Shebang_%28Unix%29#Portability

# NOTE:
# Exit immediately if any commands (even in pipeline)
# exits with a non-zero status.
set -e
set -o pipefail

# WARNING:
# This is not reliable when using POSIX sh
# and current script file is sourced by `source` or `.`
CURRENT_SOURCE_FILE_PATH="${BASH_SOURCE[0]:-$0}"
CURRENT_SOURCE_FILE_NAME="$(basename -- "$CURRENT_SOURCE_FILE_PATH")"
SCRIPT_DIR="$(cd "$(dirname -- "$CURRENT_SOURCE_FILE_PATH")" &>/dev/null && pwd)"
PROJECT_ROOT="$(dirname -- "$SCRIPT_DIR")"

# shellcheck disable=SC2016
USAGE="$CURRENT_SOURCE_FILE_NAME [OPTIONS]

Description:
  Install the kbp (Kernel Backport) skill for Claude Code.

  This script installs the skill to user level (~/.claude/skills/).
  Project-level installation is not supported since the backport process
  requires two git worktrees.

Usage:
  $CURRENT_SOURCE_FILE_NAME [OPTIONS]

Options:
  -h, --help              Show this screen.
  -f, --force             Force overwrite if skill already exists.
  -l, --link              Create symbolic link instead of copying (default).
  -c, --copy              Copy files instead of creating symbolic link.

Examples:
  # Install to user level
  $CURRENT_SOURCE_FILE_NAME

  # Install with copy instead of symlink
  $CURRENT_SOURCE_FILE_NAME --copy

  # Force reinstall
  $CURRENT_SOURCE_FILE_NAME --force"

# Default values
FORCE=false
USE_LINK=true

# This function log messages to stderr works like printf
# with a prefix of the current script name.
# Arguments:
#   $1 - The format string.
#   $@ - Arguments to the format string, just like printf.
function log() {
	local format="$1"
	shift
	# shellcheck disable=SC2059
	printf "$CURRENT_SOURCE_FILE_NAME: $format\n" "$@" >&2 || true
}

function parse_args() {
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-h | --help)
			echo "$USAGE"
			exit 0
			;;
		-f | --force)
			FORCE=true
			shift
			;;
		-l | --link)
			USE_LINK=true
			shift
			;;
		-c | --copy)
			USE_LINK=false
			shift
			;;
		--)
			shift
			break
			;;
		-*)
			log "[ERROR] Unknown option: %s" "$1"
			exit 1
			;;
		*)
			break
			;;
		esac
	done
}

function install_skill() {
	local target_dir="$HOME/.claude/skills"
	local skill_name="kbp"
	local skill_target="$target_dir/$skill_name"

	# Create target directory if it doesn't exist
	if [[ ! -d "$target_dir" ]]; then
		log "Creating directory: %s" "$target_dir"
		mkdir -p "$target_dir"
	fi

	# Check if skill already exists
	if [[ -e "$skill_target" || -L "$skill_target" ]]; then
		if [[ "$FORCE" != true ]]; then
			log "[ERROR] Skill already exists at %s. Use --force to overwrite." "$skill_target"
			exit 1
		fi
		log "Removing existing skill at %s" "$skill_target"
		rm -rf "$skill_target"
	fi

	# Install the skill
	if [[ "$USE_LINK" == true ]]; then
		log "Creating symbolic link: %s -> %s" "$skill_target" "$PROJECT_ROOT"
		ln -s "$PROJECT_ROOT" "$skill_target"
	else
		log "Copying skill to: %s" "$skill_target"
		cp -r "$PROJECT_ROOT" "$skill_target"
	fi

	log "[SUCCESS] Skill installed to: %s" "$skill_target"
	log ""
	log "You can now use the skill in Claude Code with:"
	log "  /kbp <upstream-worktree> <commit> <target-worktree>"
}

function main() {
	parse_args "$@"
	install_skill
}

main "$@"
