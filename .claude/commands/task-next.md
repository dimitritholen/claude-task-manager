---
allowed-tools: Read
description: Check manifest and identify next actionable task (minimal tokens)
---

Find the next task to work on with minimal token usage (~150 tokens).

**What This Command Does:**

1. Read `.tasks/manifest.json` only (no task files loaded)
2. Filter tasks by:
   - Status: `pending` (not started)
   - Dependencies: All must be `completed`
   - Blocked: `blocked_by` must be empty
3. Sort by priority (1 = highest)
4. Display next actionable task

**Output Format:**

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

Display reason:
- "All pending tasks have incomplete dependencies"
- "All tasks are blocked or in progress"
- "No pending tasks found"

Show blocked tasks with their blockers so user can resolve them.

**Token Efficiency:**

This command uses ~150 tokens by only reading the manifest.
No task files or context loaded until you actually start the task.

**Next Steps:**
- Use `/task-start T00X` to load full task details and begin work
- Use `/task-status` for complete overview
- Resolve blockers if no tasks are actionable
