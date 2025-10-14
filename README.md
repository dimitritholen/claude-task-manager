# Task Management System for Claude Code

Production-ready task management with intelligent orchestration, zero-tolerance quality gates, and 97%+ token efficiency.

**Built on [Minion Engine v3.0](https://www.reddit.com/r/PromptEngineering/comments/1o4kdko/been_awhile_friends_heres_my_latest_prompt_engine/)** - Meta-cognitive AI framework enforcing systematic thinking, anti-hallucination safeguards, and reliability-labeled outputs.

## Quick Start

```bash
# 1. Copy to your project
cp -r .claude/commands/task-*.md your-project/.claude/commands/
cp -r .claude/agents/task-*.md your-project/.claude/agents/
cp .claude/core/minion-engine.md your-project/.claude/core/

# 2. Initialize
cd your-project
/task-init

# 3. Start working
/task-next          # Find next task
/task-start T001    # Execute with TDD
/task-complete T001 # Validate & archive
```

## Core Workflow

```mermaid
graph LR
    A[/task-init] --> B[/task-status]
    B --> C[/task-next]
    C --> D[/task-start]
    D --> E[/task-complete]
    E --> C

    style A fill:#e3f2fd
    style D fill:#c8e6c9
    style E fill:#ffcdd2
```

## 7 Commands

| Command | Purpose | Tokens | Agent |
|---------|---------|--------|-------|
| `/task-init` | Initialize system (one-time) | ~500-1000 | task-initializer |
| `/task-add` | Add new tasks incrementally | ~800 | task-creator |
| `/task-status` | Quick overview | ~150 | (direct read) |
| `/task-next` | Find next actionable task | ~150 | task-discoverer |
| `/task-health` | Diagnose system issues | ~2000 | task-manager |
| `/task-start` | Execute task with TDD | ~1650+ | task-executor / task-ui |
| `/task-complete` | Validate & archive | ~2350 | task-completer |

## 7 Specialized Agents

### Discovery & Creation
- **task-initializer** (Sonnet) - Auto-discovers project, creates initial tasks
- **task-creator** (Sonnet) - Adds comprehensive tasks incrementally
- **task-discoverer** (Haiku) - Ultra-fast task queries (~150 tokens)

### Orchestration
- **task-manager** (Sonnet) - Diagnoses and remediates stalled tasks

### Execution
- **task-executor** (Sonnet) - TDD-driven backend/logic implementation
- **task-ui** (Sonnet) - Expert UI/UX designer with anti-generic enforcement
- **task-completer** (Sonnet) - Zero-tolerance quality gate

## Agent Selection (Automatic)

`/task-start` automatically routes to the right agent:

**task-ui** for:
- UI/UX design and implementation
- Interface components, page layouts
- Design systems, visual styling

**task-executor** for:
- Backend logic, APIs, data processing
- Business logic, algorithms
- Database operations, system integrations
- Testing infrastructure

## task-ui Agent Features

**Anti-Generic Enforcement:**
- Mandatory Brand DNA analysis (archetype, voice, audience)
- Genericness Test (must score ≤3.0/10)
- Pre-Delivery Audit (confidence ≥7/10)
- 11 anti-patterns checked (no centered heroes, Lorem ipsum, generic CTAs)

**Design System Management:**
- First UI task: Creates reusable design system in `.tasks/design-system/`
- Subsequent tasks: Loads and applies consistently
- Includes: colors, typography, spacing, effects, layout, components

**Quality Standards:**
- 3 distinct concepts generated (forced divergence)
- Brand DNA alignment for every decision
- Strategic trend research (not blind copying)
- WCAG AA accessibility required
- Complete code (no placeholders, all states)

## task-executor Features

**Mandatory TDD:**
1. Write failing test (must fail for right reason)
2. Implement minimal code to pass
3. Run test → verify pass
4. Validate (linter, build, type check)
5. Refactor if needed
6. Repeat

**Quality Enforcement:**
- 60+ item completion gate
- 0 linter errors, 0 warnings
- 100% test pass rate
- No TODO/FIXME comments
- Evidence required (attach outputs)

## Token Efficiency

**Traditional monolithic approach:**
- Every operation: 12,000+ tokens
- 10 checks: 120,000 tokens

**This system:**
- Status check: ~150 tokens
- Task discovery: ~150 tokens
- Task execution: ~1,650 tokens startup
- 10 checks + 1 task: 3,150 tokens

**Savings: 97.4% reduction** 🎉

## Directory Structure

```
.tasks/
├── manifest.json              # Central index (~150 tokens)
├── metrics.json               # Performance tracking
├── tasks/                     # Task files (~600 tokens each)
├── completed/                 # Archived tasks with learnings
├── updates/                   # Atomic updates (concurrency-safe)
├── context/                   # Project context (~900 tokens)
│   ├── project.md             # Vision, goals, brand
│   ├── architecture.md        # Tech stack, patterns
│   └── acceptance-templates.md
└── design-system/             # UI design system (task-ui)
    ├── system.json            # Design tokens
    ├── brand-dna.md           # Brand attributes
    ├── components.md          # Component specs
    └── trends-research.md     # Trend findings
```

## Quality Guarantees

**Zero-Tolerance Completion:**
- ✅ ALL acceptance criteria checked (100%)
- ✅ ALL validation commands pass
- ✅ ALL tests passing
- ✅ Build succeeds with 0 warnings
- ✅ Documentation updated
- ✅ Security reviewed

**For UI tasks:**
- ✅ Genericness score ≤3.0
- ✅ Brand DNA alignment verified
- ✅ Design system applied consistently
- ✅ WCAG AA accessibility met
- ✅ Pre-delivery audit passed (≥7)

**Binary outcome: 100% complete or rejected. No shortcuts.**

## Key Features

**Minion Engine v3.0 Integration:**
- 12-Step Reasoning Chain (systematic problem-solving)
- Reliability Labeling (every claim has confidence score)
- Conditional Interview (asks questions vs. guessing)
- Anti-Hallucination Safeguards (never invents APIs/configs)

**Universal Compatibility:**
- Works with ANY language (Python, TypeScript, Rust, Go, Java, etc.)
- Auto-discovers validation tools (pytest, jest, cargo, etc.)
- No hardcoded project details

**Intelligent Health Monitoring:**
- Auto-detects stalled tasks (>24h)
- Identifies critical path blockages
- Executes remediation (not just recommendations)
- Circuit breaker prevents infinite loops

**Concurrent Safe:**
- Atomic updates via `.tasks/updates/`
- Race condition protection
- Multi-agent workflows supported

## Common Workflows

### Solo Developer
```bash
/task-init              # Initialize (once)
/task-status            # Check overall status
/task-next              # Find next task
/task-start T001        # Start task with TDD
# ... implement ...
/task-complete T001     # Validate & archive
```

### When Things Go Wrong
```bash
/task-health            # Diagnose issues
/task-status            # Check bottlenecks
/task-next              # Auto-remediation if needed
```

## Design System Workflow (UI Tasks)

**First UI Task:**
1. `/task-start T001` (UI task detected)
2. Extracts Brand DNA from `context/project.md`
3. Researches current design trends
4. Creates design system in `.tasks/design-system/`
5. Generates 3 concepts, scores genericness
6. Implements complete UI code
7. Runs pre-delivery audit

**Subsequent UI Tasks:**
1. `/task-start T005` (UI task detected)
2. Loads existing design system
3. Applies tokens consistently
4. References Brand DNA for decisions
5. Same quality gates (genericness, audit)

## Troubleshooting

| Issue | Solution |
|-------|----------|
| "Task system not initialized" | Run `/task-init` |
| "No actionable tasks" | Check `/task-health` for bottlenecks |
| "Validation failed" | Fix issues, re-validate, retry completion |
| Stats mismatch | Run `/task-health` for diagnosis |
| Circuit breaker triggered | Review `.tasks/updates/`, manual manifest reset if needed |

## Auto-Discovery Support

**Languages:** Python, TypeScript/JavaScript, Rust, Go, C#, Java, Ruby, PHP

**Test Frameworks:** pytest, jest, vitest, cargo test, go test, dotnet test, maven, gradle

**Linters:** ruff, pylint, eslint, clippy, golangci-lint, checkstyle

**Formatters:** black, prettier, rustfmt, gofmt

## What Makes This Different

1. **Minion Engine v3.0** - Meta-cognitive framework with systematic thinking
2. **Dual Execution Agents** - Backend (TDD) + UI (design excellence)
3. **Anti-Generic Enforcement** - UI designs must pass genericness test ≤3.0
4. **Zero-Tolerance Quality** - Binary completion: 100% or reject
5. **Design System Management** - Create once, reuse consistently
6. **Health Monitoring** - Auto-detects and fixes issues
7. **97%+ Token Efficiency** - Load only what's needed
8. **Universal** - Works with any project, any language

## Integration Example

```bash
# Your existing project
my-app/
├── src/
├── tests/
└── package.json

# After /task-init
my-app/
├── src/
├── tests/
├── package.json
└── .tasks/                    # ← Created automatically
    ├── manifest.json
    ├── metrics.json
    ├── tasks/
    │   ├── T001-setup.md
    │   └── T002-feature.md
    ├── context/
    │   ├── project.md
    │   └── architecture.md
    └── design-system/         # ← Created on first UI task
        ├── system.json
        └── brand-dna.md
```

## Documentation

```
.claude/
├── commands/              # 7 slash commands
│   ├── task-init.md
│   ├── task-add.md
│   ├── task-next.md
│   ├── task-start.md      # Includes agent routing logic
│   ├── task-complete.md
│   ├── task-status.md
│   └── task-health.md
├── agents/                # 7 specialized agents
│   ├── task-initializer.md
│   ├── task-creator.md
│   ├── task-discoverer.md
│   ├── task-manager.md
│   ├── task-executor.md   # Backend/logic implementation
│   ├── task-ui.md         # UI/UX design & implementation
│   └── task-completer.md
└── core/
    └── minion-engine.md   # Foundational framework
```

---

**Framework:** Built on Minion Engine v3.0
**License:** MIT
**Status:** Production-Ready
**Last Updated:** 2025-10-14
