# Claude Task Manager

> Token-efficient, quality-driven task management framework for Claude Code with specialized AI agents

**98% token reduction** | **Zero-tolerance quality gates** | **TDD-enforced workflows** | **Self-healing task management**

---

## Why Claude Task Manager?

Traditional monolithic approaches to AI-assisted development consume 12,000+ tokens per task. Claude Task Manager reduces this to ~150-300 tokens while enforcing enterprise-grade quality standards through specialized agents and multi-stage verification.

### Key Benefits

- **[EFFICIENT] Token Efficient**: 98% reduction (150 tokens vs 12,000+) through manifest-based architecture
- **[SECURE] Quality Enforced**: Zero-tolerance completion gates with 22 specialized verify-* agents
- **[SPECIALIZED] Specialized Agents**: TDD-enforced backend (task-developer), anti-generic UI (task-ui), quality audits (task-smell)
- **[AUTO-HEAL] Self-Healing**: Automatic detection and remediation of stalled tasks and critical path blockages
- **[EVIDENCE] Evidence-Based**: Minion Engine v3.0 framework with reliability labeling for all claims
- **[BINARY] Binary Completion**: 100% done or 0% done - no partial credit, no shortcuts

---

## Quick Start

### Installation

Clone or copy the `.claude/` directory into your project:

```bash
# Option 1: Clone directly into your project
git clone https://github.com/yourusername/claude-task-manager .claude-temp
cp -r .claude-temp/.claude .
rm -rf .claude-temp

# Option 2: Copy from another project
cp -r /path/to/claude-task-manager/.claude /your/project/
```

### First Time Setup

```bash
# In Claude Code, initialize the task system
/task-init
```

This will:

- Discover your project structure
- Find and parse documentation (README, PRD, architecture docs)
- Create `.tasks/` directory with manifest, context, and initial tasks
- Set up validation commands for your tech stack

### Basic Workflow (5 Commands)

```bash
# 1. View system status
/task-status

# 2. Find next actionable task
/task-next

# 3. Start working on task T001
/task-start T001

# 4. Complete and validate task
/task-complete T001

# 5. Repeat from step 2
```

---

## Core Concepts

### The `.tasks/` Directory

After initialization, you'll have:

```text
.tasks/
├── manifest.json          # Single source of truth (~150 tokens)
├── metrics.json           # Performance tracking
├── tasks/
│   ├── T001-feature.md   # Individual task files
│   └── T002-bugfix.md
├── completed/             # Archived completed tasks
├── context/
│   ├── project.md        # Project vision and context
│   ├── architecture.md   # Technical architecture
│   └── test-scenarios/   # Test scenarios and patterns
├── reports/              # Verification reports
└── audit/                # Audit trail (JSONL)
```

### Minion Engine v3.0

The foundational reasoning framework providing:

- **12-Step Reasoning Chain**: Systematic thinking (Understanding -> Analysis -> Execution)
- **Reliability Labeling**: All claims tagged with confidence (GREEN-95 [CONFIRMED], YELLOW-70 [CORROBORATED], etc.)
- **Conditional Interview Protocol**: Asks clarifying questions instead of making assumptions
- **Anti-Hallucination Safeguards**: Evidence-based claims with source citations (file:line, URLs, command outputs)

### Specialized Agents vs General Agents

This system uses **workflow-specific specialized agents**, NOT global agents:

| Agent | Specialization | Key Enforcements |
|-------|---------------|------------------|
| **task-developer** | Backend, APIs, logic | **MANDATORY TDD**, tests before code, 60+ completion criteria |
| **task-ui** | UI/UX design | Brand DNA alignment, genericness test <=3.0, design system consistency |
| **task-smell** | Code quality audit | Detects smells, anti-patterns, technical debt |
| **task-completer** | Quality gatekeeper | 22 verify-* agents, 100% acceptance criteria, zero-tolerance |
| **task-manager** | Self-healing | Detects stalled tasks, resolves blockages, resets abandoned work |
| **task-discoverer** | Fast task lookup | Haiku-optimized, ~150 tokens |

**CRITICAL**: These agents have extreme validation standards not found in general-purpose agents.

### Binary Completion Model

```text
[PASS] 100% Complete = ALL criteria met + ALL tests pass + production-ready
[FAIL] 0% Complete = Anything less than 100%
```

**No partial credit**:

- "90% done" = INCOMPLETE
- "Just this one test failing" = INCOMPLETE
- "Will fix linter later" = INCOMPLETE
- "Good enough for now" = INCOMPLETE

---

## Command Reference

### `/task-init`

**Initialize task management system**

```bash
/task-init
```

**What it does**:

- Discovers project type, languages, frameworks
- Finds documentation (PRD, README, architecture)
- Extracts requirements and creates initial tasks
- Sets up `.tasks/` directory structure
- Discovers validation commands (linters, tests, build)

**Output**: Initialization report with project discovery, files created, and next steps.

**Token cost**: ~2,000 tokens (one-time)

---

### `/task-status`

**Show comprehensive task system overview**

```bash
/task-status
```

**What it does**:

- Reads `manifest.json` (single source of truth)
- Shows task statistics (total, completed, in progress, pending, blocked)
- Lists recent completions
- Displays performance metrics
- Validates system health

**Output**: Dashboard with statistics, actionable tasks, blockers, and metrics.

**Token cost**: ~150-300 tokens

**Example output**:

```text
[STATUS] Task Management System Status
=====================================================
Project: My Application
Last Updated: 2025-10-19T14:23:45Z

Statistics: GREEN-100 [CONFIRMED]
├── Total Tasks: 23
├── [DONE] Completed: 8 (35%)
├── [ACTIVE] In Progress: 2
├── [TODO] Pending: 11
└── [BLOCKED] Blocked: 2

[METRICS] Performance Metrics:
├── Average per task: 1,850 tokens YELLOW-75 [CORROBORATED]
├── vs. Monolithic: ~12,000 tokens
└── Savings: ~85% reduction GREEN-85 [CONFIRMED]
```

---

### `/task-next`

**Find next actionable task with health checks**

```bash
/task-next
```

**What it does**:

1. **Health Check**: Detects stalled tasks, critical path blockages
2. **Auto-Remediation**: Escalates to task-manager if issues found
3. **Task Discovery**: Returns highest-priority actionable task

**Output**: Next task with priority, dependencies, and token estimate.

**Token cost**: ~150-300 tokens (healthy), ~2,000-3,000 (remediation)

**Example output**:

```text
[NEXT] Next Task: T005

Title: Implement user authentication API
Priority: 2 GREEN-95 [CONFIRMED]
Dependencies: None - ready to start GREEN-90 [CONFIRMED]
Estimated Tokens: 2,100 YELLOW-75 [REPORTED]

Why This Task: Highest priority with all dependencies met

To Start: /task-start T005
```

---

### `/task-start [task-id]`

**Claim task and delegate to specialized agent**

```bash
/task-start T005
```

**What it does**:

1. **Load and analyze** task file
2. **Determine task type** (UI vs backend vs mixed)
3. **Delegate to specialist**:
   - Backend/API/logic -> **task-developer** (TDD-enforced)
   - UI/design/interface -> **task-ui** (anti-generic enforcement)
4. **Post-implementation audit** with task-smell
5. **Automatic remediation loop** (max 3 attempts if quality issues found)

**Output**: Task started confirmation, agent assignment, implementation progress, quality verification.

**Token cost**: ~1,700 startup + variable implementation

---

### `/task-complete [task-id]`

**Validate completion with zero-tolerance quality gates**

```bash
/task-complete T005
```

**What it does**:

1. **Load task** and parse ALL acceptance criteria
2. **Verify 100% completion** - ALL checkboxes must be [x]
3. **Run validation commands** (linters, tests, build, type checker)
4. **Multi-Stage Verification Pipeline** (5 stages):
   - **STAGE 1**: Syntax, Complexity, Dependencies (**ALWAYS**)
   - **STAGE 2**: Execution, Business Logic, Test Quality
   - **STAGE 3**: Security, Data Privacy
   - **STAGE 4**: Performance, Architecture, Quality, Documentation
   - **STAGE 5**: Database, Integration, Regression, Production Readiness
5. **Definition of Done checklist**
6. **Extract learnings**
7. **Atomic archival** if ALL checks pass
8. **Report unblocked tasks**

**Output**: Validation results with evidence OR rejection with required fixes.

**Token cost**: ~2,500-3,000 tokens

**Success example**:

```text
[PASS] Task T005 Completed Successfully!

Summary:
- ALL acceptance criteria met: GREEN-100 [CONFIRMED] (12 criteria)
- ALL validation commands passed: GREEN-100 [CONFIRMED] (4 commands)
- Definition of Done verified: GREEN-95 [CONFIRMED]

Validation Results:
[PASS] Linter: GREEN-100 [CONFIRMED] (ruff check, exit 0)
[PASS] Tests: GREEN-100 [CONFIRMED] (pytest, 47 passed)
[PASS] Build: GREEN-100 [CONFIRMED] (0 warnings)
[PASS] Multi-Stage Verification: GREEN-100 [CONFIRMED] (8 agents, all passed)

Metrics:
- Estimated: 2,100 tokens
- Actual: 2,340 tokens
- Variance: +11.4%

Impact:
- Progress: 9/23 tasks (39%)
- Unblocked: 2 tasks now actionable

Next: Use /task-next to find next task
```

**Rejection example**:

```text
[FAIL] Task T005 Completion REJECTED

Reason: Validation commands failed

Issues Found:
- Linter: 3 errors in src/api/auth.py
- Tests: 2 failures in test_auth.py

Failed Validation:
[FAIL] ruff check: EXIT 1
  src/api/auth.py:23:5 F841 Local variable 'token' assigned but never used

Required Actions:
1. Fix linter errors
2. Fix failing tests
3. Re-run: pytest && ruff check
4. Retry /task-complete T005

Task remains in_progress.
```

---

## How It Works

### Task Lifecycle

```text
┌─────────────────────────────────────────────────────────┐
│ 1. /task-init                                           │
│    Discovers project -> Creates .tasks/ structure       │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│ 2. /task-next                                           │
│    Health check -> Find actionable -> Return priority   │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│ 3. /task-start T00X                                     │
│    Analyze type -> Delegate to specialist agent         │
│    ├─ Backend -> task-developer (TDD enforced)          │
│    └─ UI -> task-ui (anti-generic enforced)             │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│ 4. Implementation Phase                                 │
│    Agent implements -> Tests -> Validates -> Documents  │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│ 5. Quality Audit (task-smell)                           │
│    Detect smells -> Report issues -> Auto-remediation   │
│    ├─ PASS -> Ready for completion                      │
│    ├─ REVIEW/FAIL -> task-developer fixes (max 3 loops) │
│    └─ Max attempts -> Manual intervention               │
└──────────────────────────┬──────────────────────────────┘
                           │
┌──────────────────────────▼──────────────────────────────┐
│ 6. /task-complete T00X                                  │
│    Multi-stage verification -> Archive if 100% done     │
│    ├─ PASS -> Archived to .tasks/completed/             │
│    └─ FAIL -> Remains in_progress, fixes required       │
└──────────────────────────┬──────────────────────────────┘
                           │
                      Repeat from step 2
```

### Quality Enforcement Layers

```text
Layer 1: Agent Specialization
├─ task-developer -> MANDATORY TDD, tests before code
├─ task-ui -> Brand DNA alignment, genericness <=3.0
└─ Every agent -> Minion Engine v3.0 reliability labeling

Layer 2: Post-Implementation Audit
├─ task-smell -> Detect code smells, anti-patterns
└─ Auto-remediation -> Max 3 fix attempts

Layer 3: Completion Verification (22 verify-* agents)
├─ STAGE 1: verify-syntax, verify-complexity, verify-dependency
├─ STAGE 2: verify-execution, verify-business-logic, verify-test-quality
├─ STAGE 3: verify-security, verify-data-privacy
├─ STAGE 4: verify-performance, verify-architecture, verify-quality, etc.
└─ STAGE 5: verify-database, verify-integration, verify-regression, etc.

Layer 4: Definition of Done
├─ ALL acceptance criteria checked
├─ ALL validation commands pass (exit 0)
├─ NO TODOs, FIXMEs, or technical debt
└─ Documentation updated
```

### Token Efficiency Explained

**Traditional Monolithic Approach**:

```text
Load ALL project files -> 12,000+ tokens per task
├─ Every file read
├─ Full context every time
└─ Massive overhead
```

**Claude Task Manager Approach**:

```text
Read manifest.json ONLY -> ~150 tokens
├─ Task metadata in manifest
├─ Full context loaded only when needed
└─ 98% reduction
```

---

## Advanced Features

### Multi-Stage Verification Pipeline

Based on PubNub best practices, the verification pipeline uses:

1. **Intelligent Agent Selection**: 8-12 of 22 verify-* agents selected based on task type
2. **5 Progressive Stages**: Syntax -> Execution -> Security -> Quality -> Integration
3. **Parallel Within Stages**: Agents run concurrently within each stage
4. **Fail-Fast Between Stages**: First failure stops pipeline
5. **Summary Return Pattern**: Agents return concise summaries, write full reports to files
6. **Audit Trail**: ALL activity logged to `.tasks/audit/` (JSONL format)

**Available Verify Agents** (22 total):

- verify-syntax, verify-complexity, verify-dependency
- verify-execution, verify-business-logic, verify-test-quality
- verify-security, verify-data-privacy
- verify-performance, verify-architecture, verify-quality
- verify-documentation, verify-error-handling, verify-maintainability
- verify-duplication, verify-debt
- verify-database, verify-integration, verify-regression
- verify-production, verify-compliance, verify-localization

### Automatic Remediation

When task-smell detects issues:

```text
PASS -> Skip remediation, proceed to completion
├─ No issues found
└─ Ready for /task-complete

REVIEW/FAIL -> Auto-remediation (max 3 attempts)
├─ Invoke task-developer with issue report
├─ Fix all CRITICAL issues
├─ Fix as many WARNING issues as feasible
├─ Re-run task-smell verification
└─ Repeat until PASS or max attempts

Max Attempts Reached -> Manual intervention
├─ Report remaining issues
├─ Request user to fix manually
└─ Re-run verification when ready
```

### Self-Healing with task-manager

Detects and auto-remediates:

- **Stalled Tasks**: `in_progress` > 24h with no activity
- **Critical Path Blockages**: High-priority tasks blocked by stalled work
- **Priority Misalignment**: Dependencies preventing critical work
- **Circuit Breaker**: Stops after 3 failed remediation attempts

**Recovery Actions**:

- Reset abandoned tasks to `pending`
- Mark tasks as `blocked` if blockers identified
- Update statuses to reflect reality
- Adjust priorities if needed

### Metrics Tracking

`.tasks/metrics.json` tracks:

```json
{
  "token_efficiency": {
    "average_per_task": 1850,
    "vs_monolithic": 12000,
    "savings_percentage": 85
  },
  "completion_stats": {
    "total_completed": 8,
    "average_duration_minutes": 45,
    "token_estimate_accuracy": 88,
    "total_tokens_used": 14800
  },
  "quality_metrics": {
    "first_time_pass_rate": 75,
    "avg_remediation_attempts": 1.2,
    "verification_pass_rate": 92
  }
}
```

---

## Architecture

### Directory Structure

```text
your-project/
├── .claude/                    # Claude Code configuration
│   ├── commands/              # Slash commands
│   │   ├── task-init.md
│   │   ├── task-status.md
│   │   ├── task-next.md
│   │   ├── task-start.md
│   │   └── task-complete.md
│   ├── agents/                # Specialized agents
│   │   ├── task-initializer.md
│   │   ├── task-developer.md
│   │   ├── task-ui.md
│   │   ├── task-smell.md
│   │   ├── task-completer.md
│   │   ├── task-discoverer.md
│   │   ├── task-manager.md
│   │   └── verify-*.md        # 22 verification agents
│   └── core/
│       └── minion-engine.md   # Reasoning framework
├── .tasks/                    # Created by /task-init
│   ├── manifest.json          # Single source of truth
│   ├── metrics.json           # Performance data
│   ├── tasks/                 # Active tasks
│   ├── completed/             # Archived tasks
│   ├── context/               # Project context
│   ├── reports/               # Verification reports
│   └── audit/                 # Audit trail
└── [your project files]
```

### Agent Specializations

**task-initializer**: Project discovery and system setup

- Discovers project structure, languages, frameworks
- Finds and parses documentation
- Creates .tasks/ directory with context and initial tasks
- Universal compatibility (any project, any language)

**task-developer**: Backend implementation with TDD enforcement

- **MANDATORY** TDD: tests before code, always
- Anti-hallucination rules: verify everything
- Iteration mandate: until proven correct
- Meaningful tests: realistic inputs, edge cases
- 60+ completion criteria before marking done

**task-ui**: Expert UI/UX designer

- **MANDATORY** Brand DNA alignment for every design decision
- Anti-generic enforcement: genericness test <=3.0 **REQUIRED**
- Design system: create once, reuse everywhere
- Sophisticated design: no junior/template patterns
- 11 anti-patterns checked, accessibility **REQUIRED**

**task-smell**: Post-implementation code quality auditor

- Detects code smells, anti-patterns, technical debt
- Language-specific patterns (Python, TypeScript, Rust, Go, etc.)
- Returns PASS/REVIEW/FAIL with specific file:line references
- Triggers automatic remediation for FAIL/REVIEW

**task-completer**: Zero-tolerance quality gatekeeper

- Verifies ALL acceptance criteria (100%, no exceptions)
- Runs ALL validation commands (must exit 0)
- Multi-stage verification with 22 verify-* agents
- Definition of Done checklist
- Binary outcome: Complete (100%) or Incomplete (0%)

**task-manager**: Deep analysis and remediation specialist

- Diagnoses planning issues (stalled tasks, blockages)
- Executes remediation (not just recommendations)
- Updates manifest atomically
- Circuit breaker (max 3 attempts)

**task-discoverer**: Fast task discovery (Haiku-optimized)

- Reads manifest.json ONLY (~150 tokens)
- Finds highest-priority actionable task
- Minimal overhead, maximum speed

### Reliability Labeling System

Every claim includes reliability metadata:

```text
Format: <COLOR>-<SCORE 1-100> [CATEGORY]

Colors:
GREEN: High confidence (80-100)
YELLOW: Medium confidence (50-79)
BLUE: Low confidence (30-49)
RED: Very low confidence (1-29)

Categories:
[CONFIRMED] - Verified by running commands/reading source
[CORROBORATED] - Multiple consistent sources
[OFFICIAL CLAIM] - From authoritative documentation
[REPORTED] - From single source or reasonable inference
[SPECULATIVE] - Educated guess based on patterns
[CONTESTED] - Conflicting information exists
[HYPOTHETICAL] - Theoretical, not validated

Examples:
GREEN-95 [CONFIRMED] - "Tests pass" (ran pytest, saw output)
YELLOW-75 [CORROBORATED] - "Token estimate ~8k" (based on 3 similar tasks)
BLUE-45 [SPECULATIVE] - "Likely uses Redis" (pattern suggests it)
```

---

## Troubleshooting

### Common Issues

**Issue**: `Task system not initialized`

```bash
# Solution: Run initialization
/task-init
```

**Issue**: `Manifest file corrupted or invalid JSON`

```bash
# Solution 1: Restore from backup
cp .tasks/updates/latest-backup.json .tasks/manifest.json

# Solution 2: Validate and repair
cat .tasks/manifest.json | jq .

# Solution 3: Re-initialize (WARNING: destroys existing data)
/task-init
```

**Issue**: `Circuit breaker tripped (3+ remediation attempts)`

```bash
# Solution 1: Review remediation history
ls -la .tasks/updates/

# Solution 2: Run health diagnostics
/task-health

# Solution 3: Reset circuit breaker
# Edit manifest.json -> config.remediation_attempts = 0
```

**Issue**: `No actionable tasks available`

```bash
# Check why tasks are blocked
/task-status

# Common causes:
# - All tasks have incomplete dependencies
# - All tasks are in_progress or blocked
# - Need to complete current tasks first
```

**Issue**: `Task completion rejected`

```bash
# Review rejection reason in output
# Common causes:
# - Unchecked acceptance criteria
# - Failing tests
# - Linter errors
# - Verification failures

# Fix issues and retry
/task-complete T00X
```

### Recovery Procedures

**Stalled Task Recovery**:

```bash
# /task-next automatically detects and remediates stalled tasks
# If auto-remediation fails, manually update manifest:
# 1. Open .tasks/manifest.json
# 2. Find stalled task
# 3. Change status from "in_progress" to "pending"
# 4. Save and re-run /task-next
```

**Manifest Corruption Recovery**:

```bash
# Check atomic updates directory
ls -la .tasks/updates/

# Restore from most recent backup
cp .tasks/updates/agent_task-completer_<timestamp>.json .tasks/manifest.json

# Validate restoration
cat .tasks/manifest.json | jq .
```

---

## Project Philosophy

### Automation with Oversight

This system automates quality enforcement while maintaining transparency:

- Every decision is traceable (reliability labels, source citations)
- Every validation is evidence-based (command outputs, file references)
- Every agent operates within documented standards (Minion Engine v3.0)

### Creation with Integrity

Quality is non-negotiable:

- **Binary completion**: 100% done or 0% done, no partial credit
- **Zero-tolerance gates**: ANY failure blocks completion
- **Evidence required**: "It works" without proof = INCOMPLETE
- **No shortcuts**: TDD is mandatory, not optional

### Power with Control

Self-healing prevents runaway failures:

- Circuit breakers stop infinite loops
- Health checks detect anomalies early
- Auto-remediation fixes common issues
- Manual intervention available when needed

---

## Contributing

Contributions welcome! This project follows:

- **Minion Engine v3.0** reasoning framework
- **Evidence-based** claims with source citations
- **Reliability labeling** for all assessments
- **Zero-tolerance** quality standards

---

## License

[Your chosen license]

---

## Acknowledgments

Built with Claude Code and inspired by:

- PubNub Claude Code best practices (multi-agent patterns, summary return)
- Test-Driven Development methodologies
- Enterprise software quality gates
- Token-efficient AI workflows

---

**Version**: 1.0.0
**Framework**: Minion Engine v3.0
**Last Updated**: 2025-10-19
