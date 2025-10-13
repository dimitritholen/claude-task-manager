---
allowed-tools: Read, Task
description: Check manifest and identify next actionable task (minimal tokens)
---

Find the next task to work on with intelligent health checks and escalation.

## Phase 1: Health Check (Manifest-Only Analysis)

**FIRST**, check for planning issues before finding next task:

1. **Read `.tasks/manifest.json`** to analyze system health
2. **Detect Anomalies:**
   - **Stalled Tasks**: Any `in_progress` tasks with `started_at` > 24 hours ago?
   - **Critical Path Blockage**: Are tasks on `critical_path` blocked by in_progress tasks?
   - **Priority Misalignment**: Are high-priority (1-2) tasks blocked by stalled work?
   - **Dependency Deadlocks**: Any circular dependencies or impossible conditions?

3. **If Anomalies Detected:**
   - Report the specific issues found
   - Calculate time since stalled tasks started
   - Identify which high-priority tasks are blocked
   - **IMMEDIATELY invoke the task-manager agent using the Task tool** with the following prompt:

   ```
   Planning issues detected in task manifest. Perform deep analysis and execute remediation.

   **Detected Issues:**
   [List specific issues you found in step 2 above - be specific with task IDs, timestamps, and impacts]

   **Your Mission:**
   1. Load task files for flagged `in_progress` tasks
   2. Check progress logs and acceptance criteria completion percentages
   3. Analyze `dependency_graph` for critical path blockages
   4. Determine root cause of stalling
   5. **EXECUTE remediation** (not just recommend):
      - Reset stalled tasks to `pending` if abandoned
      - Mark tasks as `blocked` if they have undocumented blockers
      - Update task statuses to reflect reality
      - Adjust priorities if needed
      - Fix dependency violations

   **You MUST:**
   - Use Edit tool to update `.tasks/manifest.json` with corrected task statuses
   - Use Edit tool to update task files in `.tasks/tasks/` if needed
   - Report what actions you took (not what you recommend)
   - At the end, tell user to run `/task-next` again to get correct next task

   **Token Budget:** ~2000-3000 tokens for deep analysis

   Begin analysis and remediation now.
   ```

   Use: `subagent_type: "task-manager"` when invoking the Task tool.

   **STOP after invoking the agent** - let it complete its work.

4. **If Healthy:**
   - Proceed to Phase 2 (normal task discovery)

## Phase 2: Task Discovery (If No Anomalies)

**MANDATORY**: Use the `task-discoverer` agent (Haiku-optimized) via the Task tool for fast, token-efficient discovery.

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


## Benefits of This Approach

- **Token Efficient**: Healthy state still ~150-300 tokens
- **Self-Correcting**: Automatically detects planning issues
- **Actionable**: User gets clear guidance, not just "next task"
- **Prevents Waste**: Stops working on low-priority tasks while critical path blocked

## Why Use task-discoverer Agent

- **Ultra-fast**: Haiku model optimized for speed
- **Token efficient**: ~150 tokens vs ~1,650 with full context
- **Specialized**: Designed specifically for manifest queries and filtering
- **Reliable**: Consistent output format following discovery patterns

## Why Escalate to task-manager Agent

- **Deep Analysis**: Loads task files to check actual completion state
- **Root Cause**: Determines why tasks are stalled
- **Remediation**: Provides actionable fixes, not just warnings
- **Intelligence**: Understands critical path and priority trade-offs

## Next Steps After Getting Result

- Use `/task-start T00X` to begin work on the identified task
- Use `/task-status` for complete project overview
- Use `/task-health` for standalone health check without finding next task
- Resolve blockers if no tasks are actionable
