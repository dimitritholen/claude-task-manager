---
allowed-tools: Read, Task
description: Standalone health check for task management system (no task selection)
---

<purpose>
**COMPREHENSIVE HEALTH CHECK** on task system **WITHOUT** selecting next task.

**DIAGNOSTIC MODE**: Analysis/reporting ONLY—no task selection, no remediation.
</purpose>

<scope>
Analyzes `.tasks/manifest.json` for planning issues, provides diagnostic report.

**KEY DIFFERENCE**: `/task-next` = health check + task selection. This = health check ONLY.
</scope>

<output_guarantee>
**DELIVERS**:

- Stalled task detection (>24h in progress)
- Critical path bottleneck analysis
- Priority misalignment identification
- Dependency health assessment
- Actionable recommendations (NOT fixes)
</output_guarantee>

<usage_context>
Use to understand system health before decisions.

For next task selection with health checks: use `/task-next`.

Token budget: ~150-300 (manifest only)
</usage_context>

<instructions>
**MANDATORY**: Read `.tasks/manifest.json` and analyze:

### 1. Stalled Task Detection

- Find `status: "in_progress"` tasks
- Calculate time since `started_at`
- **Flag >24h** as "potentially stalled"
- **Flag >72h** as "definitely stalled"

### 2. Critical Path Analysis

- Load `critical_path` array
- Check task statuses: `completed`, `in_progress`, `blocked`
- **Identify bottlenecks**: which in_progress task blocks most downstream work?
- Calculate completion percentage

### 3. Priority Misalignment Detection

- Find priority 1 tasks
- Check if `pending` but blocked by lower-priority in_progress tasks
- **Indicates suboptimal work ordering**

### 4. Dependency Health

- Check `dependency_graph` for circular dependencies
- Find tasks with completed dependencies but still `blocked`/`pending`
- **Identify orphaned tasks** (no blockers/dependents, not started)

### 5. Task Age Analysis

- Calculate average time per status
- **Find outliers** (tasks exceeding average)
- Check `estimated_tokens` vs `actual_tokens` variance (indicates poor planning)
</instructions>

<output_format>

## Success Format

Provide diagnostic report with Minion Engine reliability labels:

```markdown
# Task Management System Health Report

Generated: <timestamp>
Framework: Minion Engine v3.0 (Evidence-Based Analysis)

## Overall Health: [Healthy | Warning | Critical] 🟢/🟡/🔴 [CONFIDENCE SCORE] [CATEGORY]

## Summary
- Total: X | Completed: X (Y%) | In Progress: X | Pending: X | Blocked: X

## Issues Detected

### 🚨 Critical Issues
[Critical path blockers or progress preventers]

### ⚠️ Warnings
[Issues needing attention soon]

### ℹ️  Observations
[Non-urgent task health notes]

## Detailed Analysis

### Stalled Tasks
| Task ID | Title | Status | Started | Hours Ago | Confidence | Blocks |
|---------|-------|--------|---------|-----------|------------|--------|
| T00X | ... | in_progress | 2025-10-12 | 24 | 🟢85 [CONFIRMED] | T00Y, T00Z |

**Evidence:** manifest.json lines X-Y, started_at verified

### Critical Path Status
- Total: X 🟢100 [CONFIRMED] | Completed: X (Y%) 🟢100 [CONFIRMED]
- Bottleneck: T00X (in_progress 24h) 🟢90 [CONFIRMED]
- Blocked Downstream: X tasks 🟢95 [CONFIRMED]

### Priority Misalignments
[Cases where low-priority work blocks high-priority]

### Dependency Issues
[Circular dependencies, deadlocks, inconsistencies]

## Recommendations

1. [Specific action]
2. [Specific action]
3. [Specific action]

## Next Actions

**Immediate:** [Do now]
**Short Term:** [Do soon]
**Long Term:** [Systemic improvements]
```

## Report Elements

**MANDATORY**:

- Overall health + confidence score
- Evidence citations (lines, timestamps)
- Stalled tasks table + blocking relationships
- Critical path bottleneck ID
- Priority misalignments
- Dependency issues
- Actionable recommendations
</output_format>

<agent_invocation>

## Optional: Deep Analysis with task-manager

For complex issues requiring remediation (not diagnostics), **MAY** escalate to `task-manager`:

```
Perform comprehensive health analysis of task management system.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Apply Reliability Labeling to ALL diagnoses
- Cite evidence (manifest.json lines, timestamps, IDs)
- Use Evidence-Based Analysis (no speculation without labeling)
- Provide confidence scores

**Mission:**
1. Read manifest.json
2. Analyze ALL issues in depth
3. Identify root causes
4. Provide diagnostic report (NOT remediation)
5. Recommend next steps

**Focus:**
- Stalled tasks (>24h)
- Critical path blockages
- Priority misalignments
- Dependency issues
- Token estimate accuracy

**Output:**
Health report with recommendations (do NOT execute remediation).

Begin analysis.
```

Use: `subagent_type: "task-manager"`

**Note:** Only escalate if manifest reveals complex issues needing deep investigation. For simple diagnostics, direct manifest reading suffices.
</agent_invocation>

<constraints>
## DO NOT

- **Do NOT** select/recommend next task (that's /task-next)
- **Do NOT** modify manifest.json (report only)
- **Do NOT** execute remediation (diagnostic only)
- **Do NOT** load individual task files (manifest only for speed)
</constraints>

<use_cases>

## When to Use

Run when:

- Understanding system health before work
- Debugging slow progress
- Planning sprint/iteration
- Auditing task system

Run `/task-next` when ready to select/start next task.
</use_cases>

<performance_metrics>

## Token Efficiency

- Manifest-only: ~150 tokens
- Agent escalation: ~2,000-3,000 tokens
- Loading all tasks: ~12,000+ tokens

Choose depth:

- **Quick check**: Direct manifest analysis
- **Deep investigation**: Agent escalation
</performance_metrics>
