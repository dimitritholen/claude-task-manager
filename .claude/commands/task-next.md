---
allowed-tools: Read, Task
description: Check manifest and identify next actionable task (minimal tokens)
---

<purpose>
Find the next task to work on with **INTELLIGENT HEALTH CHECKS** and **AUTO-REMEDIATION**.

**WORKFLOW**: Health Check → Issue Detection → Remediation (if needed) → Task Discovery
</purpose>

<critical_setup>
**MANDATORY REQUIREMENTS**:

- **MUST** use only authorized agents from this workflow
- **MUST** perform health check before task discovery
- **MUST** respect circuit breaker limits (3 remediation attempts max)
- **MUST** apply Minion Engine v3.0 framework (Reliability Labeling + Evidence-Based Analysis)
</critical_setup>

<agent_whitelist>

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ **`task-discoverer`** - Haiku-optimized fast discovery (~150 tokens)
- ✅ **`task-manager`** - Deep analysis and remediation for planning issues

**FORBIDDEN:**

- ❌ **ANY** agent with same name from global ~/.claude/agents/
- ❌ **ANY** agent from other workflows
- ❌ **ANY** general-purpose agents

**Why This Matters:**

- **task-discoverer**: Optimized for 150-token manifest queries
- **task-manager**: Knows this workflow's remediation patterns and atomic updates
- **Global agents**: Do NOT understand this task system's structure
</agent_whitelist>

<workflow_overview>

## Workflow Overview

This command performs two-phase discovery:

1. **Phase 1 - Health Check**: Detect stalled tasks, critical path blockages, priority misalignments
2. **Phase 2 - Task Discovery**: Find highest-priority actionable task

**Token Budget**:

- Healthy state: ~150-300 tokens
- Remediation needed: ~2000-3000 tokens
</workflow_overview>

<execution_phases>

## Phase 1: Health Check (~150 tokens)

<reasoning_checkpoint>
**Before executing Phase 1, think:**

- What anomalies might indicate planning issues?
- Should I escalate to `task-manager` or proceed to discovery?
- What's the circuit breaker state (has remediation failed 3+ times)?
</reasoning_checkpoint>

<health_check_instructions>
**FIRST**, read `.tasks/manifest.json` to check for planning issues:

### Detect Anomalies

- **Stalled Tasks**: Any `in_progress` tasks with `started_at` > 24h?
- **Critical Path Blockage**: Are critical path tasks blocked by stalled work?
- **Priority Misalignment**: Are high-priority (1-2) tasks blocked by stalled work?

### If Issues Detected

Check circuit breaker state (`manifest.config.remediation_attempts < 3`):

<agent_invocation type="remediation">
**Circuit breaker NOT tripped**: Escalate to task-manager agent:

```
Planning issues detected. Perform deep analysis and execute remediation.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- **MUST** apply Reliability Labeling to ALL diagnoses (cite evidence from files)
- **MUST** use Evidence-Based Analysis (quote task files with line numbers)
- **MUST** make binary decisions (no "maybes" - make the call)

**Detected Issues:**
[List specific issues: task IDs, timestamps, impacts]

**Your Mission:**
1. Load task files for flagged `in_progress` tasks
2. Check progress logs and acceptance criteria completion
3. Analyze dependency_graph for critical path blockages
4. Determine root cause
5. **EXECUTE remediation** (NOT recommendations):
   - Reset abandoned tasks to `pending`
   - Mark tasks as `blocked` if blockers exist
   - Update statuses to reflect reality
   - Adjust priorities if needed

Report actions taken (not recommendations) and instruct user to re-run /task-next.

Begin analysis and remediation now.
```

**Agent**: `subagent_type: "task-manager"`

**CRITICAL**: **STOP after invoking agent** - let it complete its work.
</agent_invocation>

<error_handling type="circuit_breaker">
**Circuit breaker tripped** (≥3 attempts): Report failure and proceed to Phase 2:

```
🚨 **CIRCUIT BREAKER**: Remediation Loop Detected

Task system remediation has **FAILED 3+ times**. **MANUAL INTERVENTION REQUIRED**.

Recent attempts reviewed in .tasks/updates/

**Recovery Steps**:
1. Review .tasks/updates/ for remediation history
2. Run `/task-health` for detailed diagnostics
3. Consider manual manifest correction
4. Reset circuit breaker: Edit `manifest.json` → `config.remediation_attempts = 0`

**WARNING**: Proceeding with discovery, but system health is compromised.
```

</error_handling>

### If Healthy

Proceed to Phase 2 (normal discovery)
</health_check_instructions>

## Phase 2: Task Discovery (~150 tokens)

<agent_invocation type="discovery">
**MANDATORY**: Use `task-discoverer` agent (Haiku-optimized) for fast discovery.

```
Find the next actionable task from the task management system.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- **MUST** apply Reliability Labeling to task recommendations
- Speed-optimized: Minimal tokens, fast results
- **NO** deep analysis (leave that to task-manager if needed)

**Task:**
1. Read `.tasks/manifest.json` ONLY
2. Filter: `status = "pending"`, dependencies all `"completed"`, `blocked_by` empty
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

**Agent**: `subagent_type: "task-discoverer"`

**Token Budget**: ~150 tokens maximum
</agent_invocation>

<error_handling type="critical_failure">

## Critical Failure Handling

**If both health check AND discovery fail:**

```
❌ **TASK SYSTEM CRITICAL FAILURE**

Both health assessment and discovery have **FAILED**.

**Recovery Steps**:
1. Validate manifest: `cat .tasks/manifest.json | jq .`
2. Check permissions: `ls -la .tasks/`
3. Review changes: `git log .tasks/`
4. Restore from backup: `.tasks/updates/`
5. **Last resort**: `/task-init` (recreates system - **DESTROYS EXISTING DATA**)

**WARNING**: Manual intervention required before proceeding.
```

</error_handling>

</execution_phases>

<output_format>

## Expected Output Format

### SUCCESS - Task Found

**MUST include** all of the following:

```markdown
📋 Next Task: **T00X**

**Title**: [action-oriented title]
**Priority**: [1-5] 🟢95 [CONFIRMED] (from manifest.json)
**Dependencies**: [list or "None - ready to start"] 🟢90 [CONFIRMED]
**Estimated Tokens**: [number] 🟡75 [REPORTED]

**Why This Task**: [1-2 sentences explaining selection rationale]

**To Start**: `/task-start T00X`
```

**Required Elements**:

- Task ID with emoji prefix
- Action-oriented title
- Priority score with Reliability Label
- Dependency status with Reliability Label
- Token estimate with Reliability Label
- Selection rationale
- Clear next action command

### NO TASK AVAILABLE

**MUST include** all of the following:

```markdown
ℹ️  No Actionable Tasks Available

**Reason**: [specific reason - all blocked, all in progress, etc.]

**Blocked Tasks** ([count]):
- **T00X**: Blocked by [specific blocker]
- **T00Y**: Waiting for [dependency task]

**Suggested Action**: [resolve blocker, complete in-progress task, etc.]
```

**Required Elements**:

- Clear reason for no available tasks
- List of blocked tasks with specific blockers
- Actionable recommendation for user

### REMEDIATION TRIGGERED

When health check detects issues:

```markdown
🔧 **Health Issues Detected** - Escalating to Task Manager

**Issues Found**:
- [Specific issue 1 with task IDs and evidence]
- [Specific issue 2 with task IDs and evidence]

**Action**: `task-manager` agent invoked for deep analysis and remediation.

**Next Step**: Re-run `/task-next` after remediation completes.
```

</output_format>

<next_steps>

## Next Steps

After receiving task discovery result:

**If Task Found**:

- **Primary Action**: `/task-start T00X` - Begin work on identified task
- **Alternative**: `/task-status` - View complete project overview first

**If No Task Available**:

- Resolve blockers as indicated in output
- Complete in-progress tasks
- Run `/task-health` for detailed diagnostics

**If Remediation Triggered**:

- **WAIT** for `task-manager` agent to complete analysis
- **Re-run** `/task-next` after remediation completes
- If circuit breaker trips: Follow recovery steps in error message

**Additional Commands**:

- `/task-health` - Standalone health check without discovery
- `/task-status` - Comprehensive system overview
- `/task-init` - **LAST RESORT** system rebuild (destroys data)
</next_steps>
