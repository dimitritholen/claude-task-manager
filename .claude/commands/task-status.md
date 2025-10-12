---
allowed-tools: Read
description: Show comprehensive task management system status
---

Display complete task management system status.

**What This Command Does:**

1. Read `.tasks/manifest.json` (~150 tokens)
2. Read `.tasks/metrics.json` (if exists)
3. Display comprehensive status overview

**Output Format:**

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

**If No Tasks Exist:**

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

**Token Usage:**

This status command uses ~150-300 tokens:
- Manifest: ~150 tokens
- Metrics: ~100 tokens
- Minimal overhead for comprehensive overview

Compare to loading all task details: 12,000+ tokens!

**Use Cases:**

- Quick health check of task system
- Identify bottlenecks (blocked tasks)
- Track progress toward completion
- Monitor token efficiency
- Find next work to do
