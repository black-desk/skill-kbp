<!--
SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>

SPDX-License-Identifier: MIT
-->

# Kernel Backport Skill

[![checks][badge-shields-io-checks]][actions]
[![commit activity][badge-shields-io-commit-activity]][commits]
[![contributors][badge-shields-io-contributors]][contributors]
[![release date][badge-shields-io-release-date]][releases]
![commits since release][badge-shields-io-commits-since-release]
[![codecov][badge-shields-io-codecov]][codecov]

[badge-shields-io-checks]:
  https://img.shields.io/github/check-runs/black-desk/skill-kbp/master

[actions]: https://github.com/black-desk/skill-kbp/actions

[badge-shields-io-commit-activity]:
  https://img.shields.io/github/commit-activity/w/black-desk/skill-kbp/master

[commits]: https://github.com/black-desk/skill-kbp/commits/master

[badge-shields-io-contributors]:
  https://img.shields.io/github/contributors/black-desk/skill-kbp

[contributors]: https://github.com/black-desk/skill-kbp/graphs/contributors

[badge-shields-io-release-date]:
  https://img.shields.io/github/release-date/black-desk/skill-kbp

[releases]: https://github.com/black-desk/skill-kbp/releases

[badge-shields-io-commits-since-release]:
  https://img.shields.io/github/commits-since/black-desk/skill-kbp/latest

[badge-shields-io-codecov]:
  https://codecov.io/github/black-desk/skill-kbp/graph/badge.svg?token=6TSVGQ4L9X
[codecov]: https://codecov.io/github/black-desk/skill-kbp

en | [zh_CN](README.zh_CN.md)

> [!WARNING]
>
> This English README is translated from the Chinese version using LLM and may
> contain errors.

A Claude Code skill for Linux kernel change backporting. This skill explains
how to backport Linux kernel changes from newer versions to older ones.

## Installation

Install the skill to user level:

```bash
./scripts/install.sh
```

Since the backport process requires two git worktrees, this skill does not
support installation to project directories.

## Usage

Once installed, you can use the skill in Claude Code with:

```
/kbp <upstream-worktree> <commit> <target-worktree>
```

Parameters:
- `<upstream-worktree>`: Path to the git worktree containing upstream kernel
  source
- `<commit>`: Starting commit, all commits from this commit to HEAD will be
  backported
- `<target-worktree>`: Path to the target git worktree where changes will be
  applied

## License

Unless otherwise specified, the code of this project is open source under the
GNU General Public License version 3 or any later version, while documentation,
configuration files, and scripts used in the development and maintenance process
are open source under the MIT License.

This project complies with the [REUSE specification].

You can use [reuse-tool](https://github.com/fsfe/reuse-tool) to generate the
SPDX list for this project:

```bash
reuse spdx
```

[REUSE specification]: https://reuse.software/spec-3.3/
