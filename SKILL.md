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

   - For each resulting commit in order, describe the changes and list the
     corresponding upstream commit(s) from the reference branch (including
     commit hashes and titles for traceability)

5. **Execute the backport plan**: For each planned commit, start a subagent to
   execute the plan one by one. Each subagent must:

   - Prefer cherry-pick when possible: If a target commit can be achieved by
     cherry-picking an upstream commit, use `git cherry-pick -x` to preserve
     the original commit hash in the message for traceability
   - Allow finer commit splitting: The agent may split the planned work into
     smaller commits if it better matches the upstream commit structure, but
     should strive to maintain correspondence with upstream commits
   - Ensure the code compiles successfully
   - Commit with proper traceability: Every commit must reference its upstream
     source. If cherry-pick is not applicable, manually include the original
     upstream commit hash in the commit message for traceability
   - Do NOT skip committing or leave changes uncommitted
