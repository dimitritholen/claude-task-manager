---
allowed-tools: Read
description: Show comprehensive task management system status
---

<invocation>
Display comprehensive task system status with error recovery and adaptive output.
</invocation>

<critical_setup>
**MANDATORY** before displaying status:

1. **Read manifest**: `.tasks/manifest.json` (ONLY source of truth)
2. **Validate JSON**: Ensure manifest is parseable
3. **Apply reliability labels**: Use Minion Engine confidence indicators
4. **Adapt output**: Scale to project size (small/medium/large)
</critical_setup>

<purpose>
Provides comprehensive overview with error recovery and intelligent adaptation:

1. **Read** `.tasks/manifest.json` (~150 tokens) with error recovery
2. **Read** `.tasks/metrics.json` (if exists) with fallback
3. **Display** status overview adapted to project state
4. **Provide** troubleshooting guidance if issues detected

**Token budget**: ~150-300 tokens (manifest + metrics + minimal overhead)
</purpose>

<reasoning_chain>
**Execute in order:**

1. Check `.tasks/manifest.json` exists and is valid
2. Analyze task distribution and progress
3. Detect anomalies requiring remediation
4. Adapt output to project size and state
</reasoning_chain>

<instructions>

<step priority="critical">
**STEP 1 - MANDATORY**: Read `.tasks/manifest.json` (ONLY source of truth for task state)
</step>

<step priority="normal">
**STEP 2**: Read `.tasks/metrics.json` (graceful fallback if missing)
</step>

<step priority="normal">
**STEP 3**: Apply adaptive output logic based on project state
</step>

<step priority="normal">
**STEP 4**: Display status with **MANDATORY** Minion Engine reliability labels
</step>

</instructions>

<output_format>

## Success Format - Manifest Valid

Display comprehensive status with **MANDATORY** Minion Engine reliability labels:

```
📊 Task Management System Status

═══════════════════════════════════════════════════════
Project: <project-name>
Last Updated: <timestamp>

Statistics: 🟢100 [CONFIRMED] (from manifest.json)
├── Total Tasks: <total>
├── ✅ Completed: <count> (<percentage>%)
├── 🚀 In Progress: <count>
├── 📋 Pending: <count>
└── 🚫 Blocked: <count>

═══════════════════════════════════════════════════════

🚀 In Progress (<count>):
├── T00X: <title> (Priority <N>, Est: <tokens> tokens)
└── <agent> working since <timestamp>

📋 Pending - Next Actionable (<count>):
├── T00Y: <title> (Priority <N>, Est: <tokens> tokens)
│   Dependencies: ✓ All met
├── T00Z: <title> (Priority <N>, Est: <tokens> tokens)
│   Dependencies: ✓ All met
└── Use /task-next to select

📋 Pending - Waiting on Dependencies (<count>):
├── T0XX: <title> (Priority <N>)
│   Waiting for: [T00Y] <dependency-title>
└── Will become actionable when dependencies complete

🚫 Blocked (<count>):
├── T0XY: <title> (Priority <N>)
│   Blocked by: <blocker-description>
└── Resolve blocker to unblock

✅ Recently Completed (<last-5>):
├── T00A: <title> (<timestamp>, <actual-tokens> tokens)
├── T00B: <title> (<timestamp>, <actual-tokens> tokens)
└── See .tasks/completed/ for full archive

═══════════════════════════════════════════════════════

📈 Performance Metrics: 🟢90 [CONFIRMED] (from metrics.json)

Token Efficiency:
├── Average per task: <avg> tokens 🟡75 [CORROBORATED]
├── vs. Monolithic: ~12,000 tokens (baseline)
└── Savings: ~<percentage>% reduction 🟢85 [CONFIRMED]

Completion Stats:
├── Total completed: <count> 🟢100 [CONFIRMED]
├── Average duration: <minutes> minutes 🟡80 [CORROBORATED]
├── Token estimate accuracy: <percentage>% (±<variance>%) 🟡75 [REPORTED]
└── Total tokens used: <total> 🟢95 [CONFIRMED]

Last Activity:
└── <timestamp>: <action> on T00X by <agent>

═══════════════════════════════════════════════════════

💡 Quick Commands:
├── /task-next       → Find next task
├── /task-start T00X → Begin specific task
├── /task-complete   → Finish current task
└── /task-init       → Initialize in new project

Context Files:
├── ✓ context/project.md
├── ✓ context/architecture.md
├── ✓ context/acceptance-templates.md
└── ✓ context/test-scenarios/ (<count> scenarios)

System Health: ✅ All checks passed
```

## Error Format - System Not Initialized

**CONDITION**: `.tasks/` directory not found

```
⚠️  Task Management System Not Initialized

No .tasks/ directory found.

Initialize with: /task-init

This will discover project structure, find documentation,
create task system, and generate initial tasks.
```

## Error Format - Manifest Corrupted

**CONDITION**: `.tasks/manifest.json` exists but contains invalid JSON

```
❌ Manifest File Error

Issue: .tasks/manifest.json is corrupted or invalid JSON
Location: .tasks/manifest.json

Recovery Options:
1. Restore from backup: .tasks/updates/ (if atomic updates exist)
2. Re-initialize: /task-init (**WARNING**: will recreate from scratch)
3. Manual repair: Edit manifest.json to fix JSON syntax

Common Issues:
- Trailing comma in JSON
- Missing closing bracket
- Invalid UTF-8 characters

To diagnose: cat .tasks/manifest.json | jq .
```

## Warning Format - Metrics Missing

**CONDITION**: `.tasks/metrics.json` not found (non-blocking)

```
ℹ️  Metrics file not found. Metrics will be created on next task completion.
```

## Required Elements

**MANDATORY** in status output:

- **Statistics** with reliability labels (🟢100 [CONFIRMED])
- **In Progress** tasks with agent and timestamp
- **Pending actionable** (dependencies met)
- **Pending blocked** (waiting on dependencies)
- **Blocked** tasks with blocker descriptions
- **Recently completed** (last 5)
- **Performance metrics** with reliability labels
- **Quick commands**
- **Context files** validation
- **System health** summary

</output_format>

<conditional_output>

## Adaptive Output Logic

**Decision Tree**:

```
Project State Analysis:
├─ NO .tasks/ directory
│  └─ OUTPUT: Initialization prompt only
│
├─ <10 tasks (Small Project)
│  └─ OUTPUT: Full task list with details
│
├─ 10-50 tasks (Medium Project)
│  └─ OUTPUT: Summary + next actionable tasks
│
├─ >50 tasks (Large Project)
│  └─ OUTPUT: Stats + critical path + actionable only
│
├─ Critical Issues Detected
│  └─ OUTPUT: Prioritize blocker/stalled information
│
└─ Healthy State
   └─ OUTPUT: Progress metrics + recent completions
```

**Adaptation Principle**: Show what's most useful, not everything.
</conditional_output>

<examples>

## Use Cases

- Quick health check of task system
- Identify bottlenecks (blocked tasks)
- Track progress toward completion
- Monitor token efficiency
- Find next work to do

</examples>

<error_handling>

## Troubleshooting

| Symptom | Diagnosis | Solution |
|---------|-----------|----------|
| "File not found" | `.tasks/` doesn't exist | Run `/task-init` |
| "Invalid JSON" | Corrupted manifest | Check `.tasks/updates/` for recovery |
| Stats don't match reality | Stale manifest | Run `/task-health` to diagnose |
| No actionable tasks shown | All pending have deps | Check dependency graph |
| Metrics missing | First run or error | Will regenerate on completion |

</error_handling>

<performance_metrics>

## Token Efficiency

| Operation | Token Cost | Comparison |
|-----------|-----------|------------|
| Manifest only | ~150 tokens | 98% reduction vs loading all tasks |
| With metrics | ~250 tokens | 98% reduction vs loading all tasks |
| All tasks loaded | ~12,000+ tokens | ❌ NEVER DO THIS for status |

**Efficiency Principle**: Load summary data (manifest), not individual tasks.

Status command uses ~150-300 tokens (Manifest: ~150, Metrics: ~100). Compare to loading all task details: 12,000+ tokens.

</performance_metrics>

<quality_gates>

## Quality Checklist

**BEFORE displaying status, verify:**

- [ ] Manifest JSON is valid (not corrupted)
- [ ] Referenced task files exist
- [ ] Stats counters match actual task count
- [ ] Reliability labels applied to all metrics
- [ ] User-friendly error messages for failures

**IF ANY FAIL**: Show diagnostic error, not broken output

</quality_gates>

<next_steps>

## After Status Display

**User can proceed with:**

1. `/task-next` - Find and start next actionable task
2. `/task-start T00X` - Begin specific task by ID
3. `/task-complete` - Finish active task
4. `/task-init` - Set up task system in new project
5. `/task-health` - Deep diagnostic if issues detected

**Decision aid**:

- 0 actionable tasks → Check dependency graph or blockers
- Multiple actionable → Use `/task-next` for priority selection
- System not initialized → Run `/task-init` first

</next_steps>
