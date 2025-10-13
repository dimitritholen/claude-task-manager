---
allowed-tools: Read, Task
description: Check manifest and identify next actionable task (minimal tokens)
---

Find the next task to work on with intelligent health checks and escalation.

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-discoverer` - Haiku-optimized fast discovery (~150 tokens)
- ✅ `task-manager` - Deep analysis and remediation for planning issues

**FORBIDDEN:**

- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents

**Why This Matters:**

- task-discoverer: Optimized for 150-token manifest queries
- task-manager: Knows this workflow's remediation patterns and atomic updates
- Global agents do NOT understand this task system's structure

## Purpose

This command performs two-phase discovery:

1. **Health Check**: Detect stalled tasks, critical path blockages, priority misalignments
2. **Task Discovery**: Find highest-priority actionable task

Token budget: ~150-300 tokens (healthy state), ~2000-3000 tokens (remediation needed)

## Phase 1: Health Check (~150 tokens)

**FIRST**, read `.tasks/manifest.json` to check for planning issues:

### Detect Anomalies

- **Stalled Tasks**: Any `in_progress` tasks with `started_at` > 24h?
- **Critical Path Blockage**: Are critical path tasks blocked by stalled work?
- **Priority Misalignment**: Are high-priority (1-2) tasks blocked by stalled work?

### If Issues Detected

Check circuit breaker state (`manifest.config.remediation_attempts < 3`):

**Circuit breaker NOT tripped**: Escalate to task-manager agent:

```
Planning issues detected. Perform deep analysis and execute remediation.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Apply Reliability Labeling to ALL diagnoses (cite evidence from files)
- Use Evidence-Based Analysis (quote task files with line numbers)
- Binary decisions (no "maybes" - make the call)

**Detected Issues:**
[List specific issues: task IDs, timestamps, impacts]

**Your Mission:**
1. Load task files for flagged `in_progress` tasks
2. Check progress logs and acceptance criteria completion
3. Analyze dependency_graph for critical path blockages
4. Determine root cause
5. EXECUTE remediation:
   - Reset abandoned tasks to `pending`
   - Mark tasks as `blocked` if blockers exist
   - Update statuses to reflect reality
   - Adjust priorities if needed

Report actions taken (not recommendations) and instruct user to re-run /task-next.

Begin analysis and remediation now.
```

Use: `subagent_type: "task-manager"`

**STOP after invoking agent** - let it complete its work.

**Circuit breaker tripped** (≥3 attempts): Report failure and proceed to Phase 2:

```
🚨 Circuit Breaker: Remediation Loop Detected

Task system remediation has failed 3+ times. Manual intervention required.

Recent attempts reviewed in .tasks/updates/

Recommendations:
1. Review .tasks/updates/ for remediation history
2. Run /task-health for detailed diagnostics
3. Consider manual manifest correction
4. Reset circuit breaker: Edit manifest.json config.remediation_attempts = 0

Proceeding with discovery, but system health is compromised.
```

### If Healthy

Proceed to Phase 2 (normal discovery)

## Phase 2: Task Discovery (~150 tokens)

**MANDATORY**: Use `task-discoverer` agent (Haiku-optimized) for fast discovery.

```
Find the next actionable task from the task management system.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Apply Reliability Labeling to task recommendations
- Speed-optimized: Minimal tokens, fast results
- No deep analysis (leave that to task-manager if needed)

**Task:**
1. Read .tasks/manifest.json ONLY
2. Filter: status = "pending", dependencies all "completed", blocked_by empty
3. Sort by priority (1 = highest)
4. Return highest priority actionable task

**Expected Output (with Confidence Labels):**
📋 Next Task: T00X

Title: <task-title>
Priority: <1-5> 🟢95 [CONFIRMED] (from manifest.json)
Dependencies: <list or "None"> 🟢90 [CONFIRMED] (all completed per manifest)
Estimated Tokens: <number> 🟡75 [REPORTED] (from task metadata)

Status Summary:
- Total: X tasks
- Pending: X
- In Progress: X
- Blocked: X
- Completed: X

To start: /task-start T00X

**If No Task Available:**
Report reason and show blocked tasks with blockers.

Begin discovery now.
```

Use: `subagent_type: "task-discoverer"`

**Token Budget:** ~150 tokens maximum

## Error Handling

**If both health check AND discovery fail:**

```
❌ Task System Critical Failure

Both health assessment and discovery have failed.

Recovery Steps:
1. Validate manifest: cat .tasks/manifest.json | jq .
2. Check permissions: ls -la .tasks/
3. Review changes: git log .tasks/
4. Restore from backup: .tasks/updates/
5. Last resort: /task-init (recreates system)
```

## Next Steps

After getting result:

- `/task-start T00X` - Begin work on identified task
- `/task-status` - Complete project overview
- `/task-health` - Standalone health check without discovery
