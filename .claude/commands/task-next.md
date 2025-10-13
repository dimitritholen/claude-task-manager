---
allowed-tools: Read, Task
description: Check manifest and identify next actionable task (minimal tokens)
---

Find the next task to work on with intelligent health checks and escalation.

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-discoverer` - Haiku-optimized fast discovery specialist for manifest-only queries (~150 tokens)
- ✅ `task-manager` - Deep analysis and remediation specialist for planning issues, stalled tasks, and critical path blockages

**FORBIDDEN:**
- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents
- ❌ ANY agent not explicitly listed above

**Enforcement:**
This command uses TWO agents depending on system state:
1. **Healthy state** → task-discoverer (fast, token-efficient)
2. **Issues detected** → task-manager (deep analysis, remediation)

Both agents MUST be from THIS workflow only.

**Why This Matters:**
- task-discoverer: Optimized for 150-token manifest queries, not general searching
- task-manager: Knows this workflow's remediation patterns, atomic updates, and circuit breaker logic
- Global agents do NOT understand this task system's structure or recovery mechanisms

**Configuration:**
Stall thresholds can be customized in manifest.json `config` section:
```json
"config": {
  "stall_threshold_hours": 24,
  "stall_threshold_critical_hours": 72,
  "circuit_breaker_max_retries": 3
}
```
Defaults: 24h warning, 72h critical, 3 retry limit

## Phase 1: Health Check (Manifest-Only Analysis)

**Decision Tree:**
```
┌─ Read manifest.json
│
├─ Check for in_progress tasks
│  ├─ None found → Phase 2 (Discovery)
│  └─ Found → Check timestamps
│     ├─ All recent (<24h) → Phase 2 (Discovery)
│     └─ Stalled detected → Check circuit breaker
│        ├─ Retries < max → Escalate to task-manager
│        └─ Retries ≥ max → Alert user, skip to Phase 2
│
├─ Check critical path
│  ├─ Healthy → Continue
│  └─ Blocked → Escalate if combined with stalls
│
└─ Check priority misalignment
   ├─ Aligned → Continue
   └─ Misaligned → Note for task-manager
```

**FIRST**, check for planning issues before finding next task:

1. **Read `.tasks/manifest.json`** to analyze system health
2. **Detect Anomalies (configurable thresholds):**
   - **Stalled Tasks**: Any `in_progress` tasks with `started_at` > threshold hours?
   - **Critical Path Blockage**: Are tasks on `critical_path` blocked by in_progress tasks?
   - **Priority Misalignment**: Are high-priority (1-2) tasks blocked by stalled work?
   - **Dependency Deadlocks**: Any circular dependencies or impossible conditions?

3. **If Anomalies Detected:**
   - Report the specific issues found
   - Calculate time since stalled tasks started
   - Identify which high-priority tasks are blocked
   - **Check circuit breaker state** in manifest (`config.remediation_attempts` < `config.circuit_breaker_max_retries`)
   - If circuit breaker NOT tripped: **Invoke task-manager agent**
   - If circuit breaker tripped: **Alert user and proceed to discovery** (system needs human intervention)

   **Circuit Breaker Logic:**
   ```
   If manifest.config.remediation_attempts >= manifest.config.circuit_breaker_max_retries:
     1. Report: "Task system remediation has failed 3+ times"
     2. Report: "Manual intervention required - possible systemic issues"
     3. Suggest: Review .tasks/updates/ for remediation history
     4. Proceed to Phase 2 to at least provide next available task
     5. Do NOT invoke task-manager again (prevents infinite loops)
   ```

   **Otherwise, IMMEDIATELY invoke the task-manager agent using the Task tool** with the following prompt:

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

   **Increment remediation counter:**
   Update manifest.json `config.remediation_attempts` += 1 (reset to 0 on successful completion)

4. **If Healthy:**
   - Reset remediation counter to 0 (if was non-zero)
   - Proceed to Phase 2 (normal task discovery)

5. **If Circuit Breaker Tripped:**
   ```
   🚨 Circuit Breaker: Remediation Loop Detected

   The task system has attempted automated remediation 3+ times without success.
   This indicates a systemic issue requiring human intervention.

   Recent Remediation Attempts:
   - <timestamp-1>: <issue-detected>
   - <timestamp-2>: <issue-detected>
   - <timestamp-3>: <issue-detected>

   Recommendations:
   1. Review .tasks/updates/ for remediation history
   2. Check for recurring patterns in task failures
   3. Consider manual manifest correction
   4. Run /task-health for detailed diagnostics
   5. Reset circuit breaker: Edit manifest.json config.remediation_attempts = 0

   Proceeding with next task discovery, but system health is compromised.
   ```

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


**Handling Simultaneous Failures:**

If both health check AND discovery fail:
```
❌ Task System Critical Failure

Both health assessment and task discovery have failed.

Health Check Error: <error>
Discovery Error: <error>

This suggests manifest.json corruption or structural issues.

Recovery Steps:
1. Validate manifest: cat .tasks/manifest.json | jq .
2. Check file permissions: ls -la .tasks/
3. Review recent changes: git log .tasks/
4. Restore from backup: .tasks/updates/
5. Last resort: /task-init (WARNING: recreates system)

Cannot proceed without functioning manifest.
```

## Benefits of This Approach

- **Token Efficient**: Healthy state still ~150-300 tokens
- **Self-Correcting**: Automatically detects planning issues
- **Actionable**: User gets clear guidance, not just "next task"
- **Prevents Waste**: Stops working on low-priority tasks while critical path blocked
- **Safe**: Circuit breaker prevents infinite remediation loops
- **Configurable**: Thresholds adapt to project workflow

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
