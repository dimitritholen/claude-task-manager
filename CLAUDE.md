# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Task Management System for Claude Code - A production-ready system with intelligent orchestration, zero-tolerance quality gates, and 97%+ token efficiency. Built on Minion Engine v3.0, a meta-cognitive AI framework enforcing systematic thinking and anti-hallucination safeguards.

**Architecture Pattern**: Agent-based orchestration with specialized roles (discovery, execution, verification, management)

## Core Commands

All commands must be run in order for new projects. Status and health commands can be run anytime.

```bash
# Initialize system (one-time setup)
/task-init

# View current status
/task-status

# Find next actionable task
/task-next

# Start working on a task
/task-start T001

# Complete and validate task
/task-complete T001

# Add new tasks incrementally
/task-add

# Diagnose system issues
/task-health
```

## Agent Architecture

### 7 Specialized Agents

**Discovery & Creation**

- `task-initializer` (Sonnet): Auto-discovers project structure, creates initial tasks
- `task-creator` (Sonnet): Adds comprehensive tasks incrementally
- `task-discoverer` (Haiku): Ultra-fast task queries (~150 tokens)

**Orchestration**

- `task-manager` (Sonnet): Diagnoses and remediates stalled tasks

**Execution** (Auto-routed by /task-start)

- `task-executor` (Sonnet, red): TDD-driven backend/logic implementation with mandatory quality metrics
- `task-ui` (Sonnet, pink): Expert UI/UX with anti-generic enforcement and design system management

**Verification**

- `task-completer` (Sonnet, green): Zero-tolerance quality gates with code metrics validation

### Agent Selection

`/task-start` automatically routes based on task type:

- **task-ui**: UI/UX design, components, pages, design systems, visual styling
- **task-executor**: Backend logic, APIs, databases, business logic, testing infrastructure

## System Architecture

### Directory Structure

```
.tasks/
├── manifest.json              # Central index (~150 tokens)
├── metrics.json               # Performance tracking
├── ecosystem-guidelines.json  # Cached quality baselines
├── tasks/                     # Active task files (~600 tokens each)
├── completed/                 # Archived tasks with learnings
├── updates/                   # Atomic updates (concurrency-safe)
├── context/                   # Project context (~900 tokens)
│   ├── project.md             # Vision, goals, brand DNA
│   ├── architecture.md        # Tech stack, patterns
│   └── acceptance-templates.md
└── design-system/             # UI design system (task-ui)
    ├── system.json            # Design tokens
    ├── brand-dna.md           # Brand archetype, voice
    ├── components.md          # Component specs
    └── trends-research.md     # Trend findings
```

### Token Efficiency

- Status check: ~150 tokens
- Task discovery: ~150 tokens
- Task execution: ~1,650 tokens startup
- **97.4% reduction** vs traditional monolithic approach

## Key Frameworks

### Minion Engine v3.0

All agents operate within this meta-cognitive framework:

- **12-Step Reasoning Chain**: Systematic problem-solving (Understanding → Analysis → Execution)
- **Reliability Labeling**: Every claim has confidence score (🟢90+ [CONFIRMED], 🟡70-85 [CORROBORATED], 🔵<70 [SPECULATIVE])
- **Conditional Interview**: Asks questions instead of guessing when input is ambiguous
- **Anti-Hallucination**: Never invents APIs, configs, or behavior without verification

### Quality Standards

**task-executor (Backend/Logic)**

- **TDD Required**: Test before code, always
- **Quality Metrics Enforcement**: Files/functions/complexity must meet ecosystem-specific thresholds
- **YAGNI**: Build only what's explicitly requested
- **SOLID Principles**: Discovered patterns applied per ecosystem
- **Ecosystem Discovery**: First task discovers and caches baselines from official guides

**task-ui (Frontend/Design)**

- **Anti-Generic Enforcement**: Genericness test ≤3.0/10 (mandatory)
- **Design System Management**: Creates once on first UI task, reuses consistently
- **Brand DNA**: All decisions mapped to brand archetype/voice/audience
- **Quality Gates**: 3 distinct concepts, pre-delivery audit ≥7/10 confidence
- **No Placeholders**: Complete code, no Lorem ipsum, brand-specific content

**task-completer (Verification)**

- **Zero-Tolerance**: 100% complete or rejected (no partial credit)
- **Evidence Required**: Actual command outputs, not descriptions
- **Quality Metrics Verification**: Files/complexity/duplication checked against discovered baselines
- **Fail Fast**: First failure = immediate rejection

## Universal Compatibility

Works with ANY language/framework through auto-discovery:

**Languages**: Python, TypeScript/JavaScript, Rust, Go, C#, Java, Ruby, PHP
**Test Frameworks**: pytest, jest, vitest, cargo test, go test, dotnet test
**Linters**: ruff, pylint, eslint, clippy, golangci-lint
**Formatters**: black, prettier, rustfmt, gofmt

## Workflows

### Standard Development Flow

```bash
/task-init              # One-time initialization
/task-status            # Check current state
/task-next              # Find next task
/task-start T001        # Execute with TDD/design system
# ... implement ...
/task-complete T001     # Validate with quality gates
```

### When Issues Arise

```bash
/task-health            # Diagnose stalled tasks, critical path blockages
/task-status            # Identify bottlenecks
/task-next              # Auto-remediation triggered if needed
```

### First UI Task (Special Workflow)

1. `/task-start T001` detects UI task
2. Discovers existing design systems (docs → code → components)
3. If none found: Extracts Brand DNA, researches trends, creates design system
4. Generates 3 distinct concepts, scores genericness
5. Implements with WCAG AA accessibility
6. Runs pre-delivery audit

**Subsequent UI tasks** load existing design system and apply consistently.

### Ecosystem Discovery (First Backend Task)

1. `/task-start T001` detects no cache
2. Discovers language, framework, tools
3. Researches official style guides for quality thresholds
4. Caches to `.tasks/ecosystem-guidelines.json`
5. All future tasks load from cache (~50 tokens)

## Important Patterns

### Task File Structure

Tasks use frontmatter + markdown with:

- Acceptance criteria (checkboxes)
- Validation commands (discovered from project)
- Test scenarios (Gherkin or inline)
- Progress log (timestamped updates)
- Learnings (post-completion)

### Atomic Updates

All state changes go through `.tasks/updates/` directory for concurrency safety.

### Project Structure Discovery

**CRITICAL**: Both execution agents MUST discover project structure before creating files:

1. Check recently completed similar tasks for patterns
2. Analyze existing codebase structure (minimum 3-5 files)
3. Verify architecture documentation
4. Cross-validate task requirements
5. Document patterns with evidence (🟢100 [CONFIRMED])

**NEVER** guess directory structure - always discover with evidence.

## Quality Guarantees

**Zero-Tolerance Completion Requirements**:

- ✅ ALL acceptance criteria checked (100%)
- ✅ ALL validation commands pass
- ✅ ALL tests passing
- ✅ Build succeeds with 0 warnings
- ✅ Files ≤ discovered max size
- ✅ Function complexity ≤ discovered threshold
- ✅ Code duplication = 0
- ✅ SOLID compliance verified
- ✅ YAGNI compliance verified (no unrequested features)

**For UI Tasks**:

- ✅ Genericness score ≤3.0/10
- ✅ Brand DNA alignment verified
- ✅ Design system applied consistently
- ✅ WCAG AA accessibility
- ✅ Pre-delivery audit ≥7/10

**Binary outcome: 100% complete or rejected.**

## Common Pitfalls

**DON'T**:

- ❌ Skip ecosystem/design system discovery
- ❌ Create files without discovering project structure patterns
- ❌ Bypass quality gates or genericness tests
- ❌ Accept "close enough" metrics violations
- ❌ Implement unrequested features (YAGNI violations)
- ❌ Use placeholders or Lorem ipsum
- ❌ Complete tasks with failing tests or linter errors

## Development Philosophy

**Evidence-Based**: All claims require proof (file:line citations, command outputs, measurements)
**Quality-First**: Code violating thresholds creates compounding technical debt
**Anti-Generic**: UI designs must be distinctive, brand-aligned, impossible to confuse with templates
**Systematic**: 12-step reasoning, reliability labeling, conditional interviews
**Token-Efficient**: Load only what's needed when needed

## Integration

This is a Claude Code extension - copy commands/agents/core to your `.claude/` directory and run `/task-init` to begin.
