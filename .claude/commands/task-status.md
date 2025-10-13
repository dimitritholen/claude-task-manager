---
allowed-tools: Read
description: Show comprehensive task management system status
---

Display complete task management system status with error recovery and adaptive output.

## Purpose

This command provides a comprehensive overview of the task system by:
1. Reading `.tasks/manifest.json` (~150 tokens) with error recovery
2. Reading `.tasks/metrics.json` (if exists) with fallback
3. Displaying status overview adapted to project state
4. Providing troubleshooting guidance if issues detected

Token budget: ~150-300 tokens (manifest + metrics + minimal overhead)

## Implementation

**FIRST**, attempt to read `.tasks/manifest.json`:

### If manifest exists and is valid:

Display comprehensive status:

```
📊 Task Management System Status

═══════════════════════════════════════════════════════
Project: <project-name>
Last Updated: <timestamp>

Statistics:
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

📈 Performance Metrics:

Token Efficiency:
├── Average per task: <avg> tokens
├── vs. Monolithic: ~12,000 tokens
└── Savings: ~<percentage>% reduction

Completion Stats:
├── Total completed: <count>
├── Average duration: <minutes> minutes
├── Token estimate accuracy: <percentage>% (±<variance>%)
└── Total tokens used: <total>

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

### If manifest doesn't exist:

```
⚠️  Task Management System Not Initialized

No .tasks/ directory found.

Initialize with: /task-init

This will:
- Discover project structure
- Find documentation
- Create task system
- Generate initial tasks
```

### If manifest is corrupted:

```
❌ Manifest File Error

Issue: .tasks/manifest.json is corrupted or invalid JSON
Location: .tasks/manifest.json

Recovery Options:
1. Restore from backup: .tasks/updates/ (if atomic updates exist)
2. Re-initialize: /task-init (WARNING: will recreate from scratch)
3. Manual repair: Edit manifest.json to fix JSON syntax

Common Issues:
- Trailing comma in JSON
- Missing closing bracket
- Invalid UTF-8 characters

To diagnose: cat .tasks/manifest.json | jq .
```

### If metrics.json is missing:

```
ℹ️  Metrics file not found, continuing without performance data.
   Metrics will be created on next task completion.
```

## Conditional Output

The output adapts based on system state:
- **Empty project**: Shows initialization prompt only
- **Small project** (<10 tasks): Shows full task list
- **Large project** (>50 tasks): Shows summary + actionable tasks only
- **Critical issues**: Prioritizes blocker/stalled task information
- **Healthy state**: Shows progress and recent completions

## Token Efficiency

This status command uses ~150-300 tokens:
- Manifest: ~150 tokens
- Metrics: ~100 tokens
- Minimal overhead for comprehensive overview

Compare to loading all task details: 12,000+ tokens!

## Use Cases

- Quick health check of task system
- Identify bottlenecks (blocked tasks)
- Track progress toward completion
- Monitor token efficiency
- Find next work to do

## Troubleshooting

| Symptom | Diagnosis | Solution |
|---------|-----------|----------|
| "File not found" | .tasks/ doesn't exist | Run /task-init |
| "Invalid JSON" | Corrupted manifest | Check .tasks/updates/ for recovery |
| Stats don't match reality | Stale manifest | Run /task-health to diagnose |
| No actionable tasks shown | All pending have deps | Check dependency graph |
| Metrics missing | First run or error | Will regenerate on completion |

## Performance Notes

- First load: ~150 tokens (manifest only)
- With metrics: ~250 tokens (manifest + metrics)
- Compare to loading all tasks: ~12,000+ tokens
- Efficiency gain: ~98% token reduction for status checks
