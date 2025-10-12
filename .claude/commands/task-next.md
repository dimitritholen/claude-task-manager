---
allowed-tools: Read, Task
description: Check manifest and identify next actionable task (minimal tokens)
---

Find the next task to work on with minimal token usage (~150 tokens).

**MANDATORY**: This command MUST use the `task-discoverer` agent (Haiku-optimized) via the Task tool for fast, token-efficient discovery.

**Invoke the task-discoverer agent with:**

```
Find the next actionable task from the task management system.

**Task:**
1. Read `.tasks/manifest.json` ONLY (do not load task files)
2. Filter tasks by:
   - Status: `pending` (not started)
   - Dependencies: All must be `completed`
   - Blocked: `blocked_by` must be empty
3. Sort by priority (1 = highest)
4. Return the highest priority actionable task

**Token Budget:** ~150 tokens maximum

**Expected Output Format:**
```
📋 Next Task: T00X

Title: <task-title>
Priority: <1-5>
Dependencies: <list or "None">
Estimated Tokens: <number>

Status Summary:
- Total: X tasks
- Pending: X
- In Progress: X
- Blocked: X
- Completed: X

To start this task: /task-start T00X
```

**If No Task Available:**
Report reason:
- "All pending tasks have incomplete dependencies"
- "All tasks are blocked or in progress"
- "No pending tasks found"

Show blocked tasks with their blockers so user can resolve them.

Begin discovery now.
```

**Why Use task-discoverer Agent:**

- **Ultra-fast**: Haiku model optimized for speed
- **Token efficient**: ~150 tokens vs ~1,650 with full context
- **Specialized**: Designed specifically for manifest queries and filtering
- **Reliable**: Consistent output format following discovery patterns

**Next Steps After Getting Result:**
- Use `/task-start T00X` to begin work on the identified task
- Use `/task-status` for complete project overview
- Resolve blockers if no tasks are actionable
