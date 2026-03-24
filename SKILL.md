---
name: kbp
description: Backport commits in reference linux worktree to target worktree
context: fork
argument-hint: <upstream-worktree> <commit> <target-worktree>
---

# Kernel Backport Task

Backport Linux kernel commits (from $ARGUMENTS[1] to HEAD) from an upstream
worktree $ARGUMENTS[0] to target worktree $ARGUMENTS[2].

## Preparation

Before starting the backport, verify that both the reference branch and the
target branch compile successfully:

0. **Verify reference branch compilation**: Start a subagent in the upstream
   worktree to verify that the reference branch (at the commit specified by
   $ARGUMENTS[1]) compiles successfully. If it fails, report the issue to the
   user and stop.

1. **Verify target branch compilation**: Start a subagent in the target
   worktree to verify that the current target branch compiles successfully.
   If it fails, report the issue to the user and stop.

Only proceed to the analysis phase after both branches compile successfully.

## Analysis and Planning

2. **Analyze the commits**: Start a subagent in the upstream worktree to
   understand what changes are in the commits. Identify all files modified and
   the nature of each change.

3. **Identify compilation configuration**: Analyze the upstream commits to
   determine what kernel configuration options (Kconfig symbols) are required
   to enable the feature being backported. This includes:
   - Identify all `CONFIG_*` symbols that control the feature
   - Determine the dependencies between these configuration options
   - Document the minimal configuration needed to compile and enable the feature

4. **Identify dependencies**: For each commit, start a subagent in the upstream
   worktree to determine what kernel APIs, structures, or features it depends
   on.

5. **Check target kernel version**: Start a subagent to determine the target
   kernel version by examining the Makefile or version files in the target
   worktree.

6. **Decide how to backport the changes**: Start a subagent to analyze how to
   backport these changes. This analysis must:

   - **Thoroughly read the upstream commits**: Carefully read the source code
     changes in each commit to understand the implementation details and how the
     feature works
   - **Identify all dependencies**: Based on reading the actual code changes,
     determine what kernel APIs, structures, or features each commit depends on
     and whether these dependencies exist in the target kernel version
   - **Decide the backport strategy**: Generally, decide whether to backport all
     dependencies or just adapt these commits to the target kernel

   After completing the dependency analysis, present possible backport plans and
   let the user decide which plan to follow. The plan must:

   - List all commits to backport in order, including dependency commits first
     (if any), followed by the target commits
   - For each commit, describe the changes and list the corresponding upstream
     commit hash and title for traceability
   - Explicitly mark which commits are dependencies and which are the target
     commits to backport

7. **Execute the backport plan**: Execute the plan **commit by commit** in the
   order specified in the plan (dependencies first, then target commits). For
   each commit:

   - Start a subagent to perform the initial backport (cherry-pick or manual
     adaptation)
   - After the initial backport, start a **separate subagent** to fix any
     compilation issues and ensure the code compiles successfully
   - **Verify the feature is actually compiled**: The compilation verification
     must ensure that the backported feature is actually being compiled, not
     just that the kernel compiles without errors. This requires:
     - Enable the necessary configuration options identified in step 3
     - Verify that the relevant source files are being compiled by checking
       the build output or object file generation
     - Confirm that the feature's code paths are reachable with the current
       configuration
   - Only proceed to the next commit after the current commit compiles and is
     committed

   Requirements for each backport subagent:

   - Prefer cherry-pick when possible: If a target commit can be achieved by
     cherry-picking an upstream commit, use `git cherry-pick -x` to preserve
     the original commit hash in the message for traceability
   - Allow finer commit splitting: The agent may split the planned work into
     smaller commits if it better matches the upstream commit structure, but
     should strive to maintain correspondence with upstream commits
   - Commit with proper traceability: Every commit must reference its upstream
     source. If cherry-pick is not applicable, manually include the original
     upstream commit hash in the commit message for traceability
   - Do NOT skip committing or leave changes uncommitted
