---
name: kbp
description: Backport commits in reference linux worktree to target worktree
context: fork
argument-hint: <upstream-worktree> <commit> <target-worktree>
---

# Kernel Backport Task

Backport Linux kernel commits (from $ARGUMENTS[1] to HEAD) from an upstream
worktree $ARGUMENTS[0] to target worktree $ARGUMENTS[2].

1. **Analyze the commits**: Start a subagent in the upstream worktree to
   understand what changes are in the commits. Identify all files modified and
   the nature of each change.

2. **Identify dependencies**: For each commit, start a subagent in the upstream
   worktree to determine what kernel APIs, structures, or features it depends
   on.

3. **Check target kernel version**: Start a subagent to determine the target
   kernel version by examining the Makefile or version files in the target
   worktree.

4. **Decide how to backport the changes**: Start a subagent to analyze how to
   backport these changes. Generally, we need to decide whether to backport all
   dependencies or just adapt these commits to the target kernel. This subagent
   should present possible backport plans, then let the user decide which plan
   to follow. The plan must:

   - List each resulting commit in the target worktree in order
   - For each commit, describe what changes will be made

5. **Execute the backport plan**: For each planned commit, start a subagent to
   execute the plan one by one. Each subagent must:

   - Implement the changes described in the plan
   - Ensure the code compiles successfully
   - Commit the changes with a proper commit message
