---
allowed-tools: Read, Task
description: Standalone health check for task management system (no task selection)
---

<purpose>
Perform **COMPREHENSIVE HEALTH CHECK** on task management system **WITHOUT** finding next task.

**DIAGNOSTIC MODE**: Analysis and reporting ONLY—no task selection, no remediation execution.
</purpose>

<scope>
This command analyzes `.tasks/manifest.json` for planning issues and provides diagnostic report.

**KEY DIFFERENCE**: `/task-next` includes health check + task selection. This command = health check ONLY.
</scope>

<output_guarantee>
**YOU WILL RECEIVE**:

- Stalled task detection (>24h in progress)
- Critical path bottleneck analysis
- Priority misalignment identification
- Dependency health assessment
- Actionable recommendations (NOT automatic fixes)
</output_guarantee>

<usage_context>
Use this when you want to understand system health before making decisions.

For finding next task with health checks, use `/task-next` instead.

Token budget: ~150-300 tokens (manifest analysis only)
</usage_context>

<instructions>
**MANDATORY**: Read `.tasks/manifest.json` and analyze:

### 1. Stalled Task Detection

- Find all tasks with `status: "in_progress"`
- Calculate time since `started_at` timestamp
- **Flag tasks in_progress > 24 hours** as "potentially stalled"
- **Flag tasks in_progress > 72 hours** as "definitely stalled"

### 2. Critical Path Analysis

- Load `critical_path` array from manifest
- Check which critical_path tasks are `completed`, `in_progress`, or `blocked`
- **Identify bottlenecks**: which in_progress task is blocking most downstream work?
- Calculate critical path completion percentage

### 3. Priority Misalignment Detection

- Find all priority 1 tasks (highest priority)
- Check if any are `pending` but blocked by lower-priority in_progress tasks
- **This indicates suboptimal work ordering**

### 4. Dependency Health

- Check `dependency_graph` for circular dependencies
- Find tasks with all dependencies completed but still marked `blocked` or `pending`
- **Identify orphaned tasks** (no blockers, no dependents, not started)

### 5. Task Age Analysis

- Calculate average time tasks spend in each status
- **Find outliers** (tasks taking much longer than average)
- Check if `estimated_tokens` vs `actual_tokens` variance is high (indicates poor planning)
</instructions>

<output_format>

## Success Format

Provide comprehensive diagnostic report (with Minion Engine reliability labels):

```markdown
# Task Management System Health Report

Generated: <timestamp>
Framework: Minion Engine v3.0 (Evidence-Based Analysis)

## Overall Health: [Healthy | Warning | Critical] 🟢/🟡/🔴 [CONFIDENCE SCORE] [CATEGORY]

## Summary
- Total Tasks: X
- Completed: X (Y%)
- In Progress: X
- Pending: X
- Blocked: X

## Issues Detected

### 🚨 Critical Issues
[Issues that block critical path or prevent progress]

### ⚠️ Warnings
[Issues that should be addressed soon]

### ℹ️  Observations
[Non-urgent observations about task health]

## Detailed Analysis

### Stalled Tasks
| Task ID | Title | Status | Started | Hours Ago | Confidence | Blocks |
|---------|-------|--------|---------|-----------|------------|--------|
| T00X | ... | in_progress | 2025-10-12 | 24 | 🟢85 [CONFIRMED] | T00Y, T00Z |

**Evidence:** manifest.json lines X-Y, started_at timestamp verified

### Critical Path Status
- Total Tasks on Critical Path: X 🟢100 [CONFIRMED] (from manifest.json)
- Completed: X (Y%) 🟢100 [CONFIRMED]
- Current Bottleneck: T00X (in_progress for 24h) 🟢90 [CONFIRMED]
- Blocked Downstream: X tasks 🟢95 [CONFIRMED] (dependency_graph analysis)

### Priority Misalignments
[List cases where low-priority work blocks high-priority work]

### Dependency Issues
[List circular dependencies, deadlocks, or inconsistencies]

## Recommendations

1. [Specific action to take]
2. [Specific action to take]
3. [Specific action to take]

## Next Actions

**Immediate:**
- [What should be done right now]

**Short Term:**
- [What should be done soon]

**Long Term:**
- [Systemic improvements needed]
```

## Report Elements

**MANDATORY** inclusions:

- Overall health status with confidence score
- Evidence citations (manifest.json lines, timestamps)
- Stalled tasks table with blocking relationships
- Critical path bottleneck identification
- Priority misalignment cases
- Dependency health issues
- Specific actionable recommendations
</output_format>

<agent_invocation>

## Optional: Deep Analysis with task-manager

For complex issues requiring remediation (not just diagnostics), you **MAY** optionally escalate to `task-manager` agent:

```
Perform comprehensive health analysis of task management system.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Apply Reliability Labeling to ALL diagnoses
- Cite evidence (manifest.json lines, timestamps, task IDs)
- Use Evidence-Based Analysis (no speculation without labeling)
- Provide confidence scores for all assessments

**Your Mission:**
1. Read manifest.json
2. Analyze ALL detected issues in depth
3. Identify root causes
4. Provide detailed diagnostic report (NOT remediation actions)
5. Recommend specific next steps

**Focus Areas:**
- Stalled tasks (>24h in progress)
- Critical path blockages
- Priority misalignments
- Dependency issues
- Token estimate accuracy

**Expected Output:**
Comprehensive health report with specific recommendations (but do NOT execute remediation).

Begin analysis now.
```

Use: `subagent_type: "task-manager"`

**Note:** Only use agent escalation if manifest analysis reveals complex issues requiring deep investigation. For simple diagnostics, direct manifest reading is sufficient.
</agent_invocation>

<constraints>
## DO NOT

- **Do NOT** select or recommend the next task (that's /task-next's job)
- **Do NOT** modify manifest.json (report only)
- **Do NOT** execute remediation (this is diagnostic only)
- **Do NOT** load individual task files (manifest analysis only for speed)
</constraints>

<use_cases>

## When to Use This Command

Run this command when:

- User wants to understand system health before starting work
- Debugging why progress feels slow
- Planning sprint or iteration
- Auditing task management system

Run `/task-next` when actually ready to select and start next task.
</use_cases>

<performance_metrics>

## Token Efficiency

- Manifest-only analysis: ~150 tokens
- With agent escalation: ~2,000-3,000 tokens
- Compare to loading all tasks: ~12,000+ tokens

Choose analysis depth based on needs:

- **Quick check**: Direct manifest analysis
- **Deep investigation**: Agent escalation
</performance_metrics>
