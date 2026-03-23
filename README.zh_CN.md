<!--
SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>

SPDX-License-Identifier: MIT
-->

# 内核特性前向移植技能

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

[en](README.md) | zh_CN

一个用于 Linux 内核变动 backport 的 Claude Code 技能。该技能说明应当如何将Linux内核的变动从较新版本移植到较旧版本。

## 安装

将技能安装到用户级别：

```bash
./scripts/install.sh
```

由于backport过程会使用到两个git worktree，该技能不支持安装到项目目录。

## 使用

安装完成后，您可以在 Claude Code 中使用：

```
/kbp <上游工作区> <起始commit> <目标工作区>
```

参数说明：
- `<上游工作区>`：包含上游内核源码的 git worktree 路径
- `<起始commit>`：起始 commit，从该 commit 到 HEAD 的所有提交都将被 backport
- `<目标工作区>`：应用变更的目标 git worktree 路径

## 许可证

如无特殊说明，该项目的代码以GNU通用公共许可协议第三版或任何更新的版本开源，文档、配置文件以及开发维护过程中使用的脚本等以MIT许可证开源。

该项目遵守[REUSE规范]。

你可以使用[reuse-tool](https://github.com/fsfe/reuse-tool)生成这个项目的SPDX列表：

```bash
reuse spdx
```

[REUSE规范]: https://reuse.software/spec-3.3/
