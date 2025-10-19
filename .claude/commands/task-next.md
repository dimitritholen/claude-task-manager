---
allowed-tools: Read, Task
description: Check manifest and identify next actionable task (minimal tokens)
---

<purpose>
Find next task with **HEALTH CHECKS** and **AUTO-REMEDIATION**.

**WORKFLOW**: Health Check → Remediation (if needed) → Task Discovery
</purpose>

<critical_setup>
**REQUIREMENTS**:

- Use only authorized workflow agents
- Perform health check before discovery
- Respect circuit breaker (3 attempts max)
- Apply Minion Engine v3.0 (Reliability Labeling + Evidence-Based Analysis)
</critical_setup>

<agent_whitelist>

## AGENT WHITELIST

**ONLY these workflow agents authorized:**

- ✅ **`task-discoverer`** - Haiku-optimized fast discovery (~150 tokens)
- ✅ **`task-manager`** - Deep analysis and remediation

**FORBIDDEN:**

- ❌ Global ~/.claude/agents/ with same name
- ❌ Other workflow agents
- ❌ General-purpose agents

**Why:**

- **task-discoverer**: Optimized for manifest queries
- **task-manager**: Knows remediation patterns and atomic updates
- **Global agents**: Don't understand this system
</agent_whitelist>

<workflow_overview>

## Workflow

Two-phase discovery:

1. **Health Check**: Detect stalled tasks, blockages, misalignments
2. **Task Discovery**: Find highest-priority actionable task

**Token Budget**: Healthy ~150-300, Remediation ~2000-3000
</workflow_overview>

<execution_phases>

## Phase 1: Health Check

<reasoning_checkpoint>
**Before Phase 1:**

- What anomalies indicate planning issues?
- Escalate to `task-manager` or proceed?
- Circuit breaker state (3+ failures)?
</reasoning_checkpoint>

<health_check_instructions>
Read `.tasks/manifest.json` for planning issues:

### Detect Anomalies

- **Stalled**: `in_progress` tasks with `started_at` > 24h?
- **Critical Path**: Blocked by stalled work?
- **Priority**: High-priority (1-2) blocked by stalled work?

### If Issues Detected

Check circuit breaker (`manifest.config.remediation_attempts < 3`):

<agent_invocation type="remediation">
**Circuit breaker OK**: Escalate to task-manager:

```
Planning issues detected. Execute deep analysis and remediation.

**Minion Engine v3.0**: [framework](../core/minion-engine.md)
- Apply Reliability Labeling (cite evidence)
- Use Evidence-Based Analysis (quote files with line numbers)
- Make binary decisions (no "maybes")

**Issues**: [List: task IDs, timestamps, impacts]

**Mission:**
1. Load flagged `in_progress` task files
2. Check logs and acceptance criteria
3. Analyze dependency_graph for blockages
4. Determine root cause
5. **EXECUTE remediation**:
   - Reset abandoned → `pending`
   - Mark as `blocked` if blockers exist
   - Update statuses to reality
   - Adjust priorities

Report actions (not recommendations) and instruct re-run /task-next.
```

**Agent**: `subagent_type: "task-manager"`

**STOP after agent invocation** - let it complete.
</agent_invocation>

<error_handling type="circuit_breaker">
**Circuit breaker tripped** (≥3): Report and proceed to Phase 2:

```
🚨 **CIRCUIT BREAKER**: Remediation Loop

Remediation **FAILED 3+ times**. **MANUAL INTERVENTION REQUIRED**.

**Recovery**:
1. Review .tasks/updates/ for history
2. Run `/task-health` for diagnostics
3. Manual manifest correction
4. Reset breaker: `manifest.json` → `config.remediation_attempts = 0`

**WARNING**: Proceeding with discovery, system health compromised.
```

</error_handling>

### If Healthy

Proceed to Phase 2.
</health_check_instructions>

## Phase 2: Task Discovery

<agent_invocation type="discovery">
Use `task-discoverer` (Haiku-optimized):

```
Find next actionable task.

**Minion Engine v3.0**: [framework](../core/minion-engine.md)
- Apply Reliability Labeling
- Minimal tokens, fast results
- NO deep analysis

**Steps:**
1. Read `.tasks/manifest.json`
2. Filter: `status = "pending"`, deps `"completed"`, `blocked_by` empty
3. Sort by priority (1 = highest)
4. Return highest priority task

**Output (with labels):**
📋 Next Task: T00X

Title: <task-title>
Priority: <1-5> 🟢95 [CONFIRMED] (manifest.json)
Dependencies: <list or "None"> 🟢90 [CONFIRMED] (completed)
Estimated Tokens: <number> 🟡75 [REPORTED] (metadata)

Status:
- Total: X | Pending: X | In Progress: X | Blocked: X | Completed: X

To start: /task-start T00X

**No task?** Report reason, show blocked tasks.
```

**Agent**: `subagent_type: "task-discoverer"`

**Token Budget**: ~150 max
</agent_invocation>

<error_handling type="critical_failure">

## Critical Failure

**Both health check AND discovery fail:**

```
❌ **CRITICAL FAILURE**

Health and discovery **FAILED**.

**Recovery**:
1. Validate: `cat .tasks/manifest.json | jq .`
2. Permissions: `ls -la .tasks/`
3. Changes: `git log .tasks/`
4. Restore: `.tasks/updates/`
5. **Last resort**: `/task-init` (**DESTROYS DATA**)

**WARNING**: Manual intervention required.
```

</error_handling>

</execution_phases>

<output_format>

## Output Format

### SUCCESS

```markdown
📋 Next Task: **T00X**

**Title**: [action-oriented]
**Priority**: [1-5] 🟢95 [CONFIRMED] (manifest.json)
**Dependencies**: [list or "None"] 🟢90 [CONFIRMED]
**Estimated Tokens**: [number] 🟡75 [REPORTED]

**Why**: [1-2 sentences]

**To Start**: `/task-start T00X`
```

**Required**: Task ID, title, priority/deps/tokens with labels, rationale, next action.

### NO TASK

```markdown
ℹ️  No Actionable Tasks

**Reason**: [specific - all blocked, in progress, etc.]

**Blocked** ([count]):
- **T00X**: Blocked by [blocker]
- **T00Y**: Waiting for [dependency]

**Action**: [resolve blocker, complete task, etc.]
```

**Required**: Reason, blocked list with blockers, recommendation.

### REMEDIATION

```markdown
🔧 **Health Issues** - Escalating to Task Manager

**Issues**:
- [Issue 1: task IDs, evidence]
- [Issue 2: task IDs, evidence]

**Action**: `task-manager` invoked.

**Next**: Re-run `/task-next` after completion.
```

</output_format>

<next_steps>

## Next Steps

**Task Found**:
- `/task-start T00X` - Begin work
- `/task-status` - View overview first

**No Task**:
- Resolve blockers
- Complete in-progress tasks
- `/task-health` for diagnostics

**Remediation**:
- **WAIT** for `task-manager` completion
- **Re-run** `/task-next` after
- Circuit breaker trips: Follow recovery steps

**Commands**:
- `/task-health` - Health check only
- `/task-status` - System overview
- `/task-init` - **LAST RESORT** (destroys data)
</next_steps>
