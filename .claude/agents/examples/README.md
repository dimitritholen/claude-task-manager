# Task Management System - Structural Examples

This directory contains **structural templates** with placeholders showing **format and structure** of task management files, not project-specific content.

## Purpose

These templates demonstrate:
- **File structures** - Required sections and fields
- **Placeholder conventions** - Dynamic content indicators
- **Token budgets** - Target sizes per file type
- **Relationships** - Inter-file references

**NOT project-specific.** The agent fills in actual content based on your project's language, framework, documentation style, testing approach, build system, and structure.

## Files in This Directory

### `manifest.json`

**Purpose**: Ultra-lightweight task index structure

**Key Points**:
- Status values: pending, in_progress, blocked, completed
- Task dependencies reference task IDs
- Blocked_by describes blockers (not task IDs)
- Tracks estimated and actual tokens
- **Token Budget**: ≤ 200 tokens

### `T002-example-task.md`

**Purpose**: Comprehensive task file structure

**Key Sections**:
- Frontmatter metadata (YAML)
- Context and documentation references
- Acceptance criteria checklist
- Test scenarios
- Technical implementation details
- Progress log
- Completion checklist
- Post-completion learnings

**Token Budget**: 400-800 tokens

### `context-project.md`

**Purpose**: High-level project context structure

**Sections**: Vision and goals, target users, success metrics, constraints, non-negotiables, development timeline

**Token Budget**: ≤ 300 tokens

### `example-test-scenario.feature`

**Purpose**: Gherkin format for test scenarios

**Key Points**:
- Feature description with user story
- Background for common preconditions
- Multiple scenario types (happy path, edge cases, errors, performance)
- Given/When/Then structure

**Format**: Gherkin (adapts to project's testing style)

## How to Use These Templates

1. **Don't copy files directly** - They contain placeholders, not real content

2. **Let task-manager agent discover your project**
   - Identifies language, framework, and structure
   - Finds documentation (or works without)
   - Detects testing approach

3. **Agent creates project-specific versions**
   - Fills actual requirements
   - Uses your validation commands
   - Matches your conventions

## Placeholder Conventions

Template placeholders:
- `<placeholder>` - Single value
- `<feature-name>` - Feature identifier
- `<ISO-8601-timestamp>` - ISO 8601 timestamp
- `<description>` - Multi-word description

## Token Efficiency

Fractal architecture:

```
Status Check (Frequent)
├── manifest.json (~150 tokens)
└── Decision: which task

Task Execution
├── manifest.json (~150 tokens)
├── task file (~600 tokens)
├── context files (~900 tokens)
└── Total: ~1,650 tokens

vs. Monolithic: ~12,000+ tokens

Savings: 85%+ reduction
```

## Adaptation Examples

Agent adapts to project types:

**Python**: Detects pyproject.toml/requirements.txt → Uses pytest, mypy, black, ruff

**TypeScript**: Detects package.json/tsconfig.json → Uses vitest/jest, tsc, eslint, prettier

**Rust**: Detects Cargo.toml → Uses cargo test/build/clippy, rustfmt

**Any Project**: Discovers existing setup, adapts to conventions, works with minimal/no documentation

## File Organization

When initialized, the task system creates:

```
.tasks/
├── manifest.json                    # Lightweight index
├── tasks/                           # Individual task files
│   ├── T001-<feature>.md
│   └── T002-<feature>.md
├── context/                         # Session-loaded context
│   ├── project.md
│   ├── architecture.md
│   ├── acceptance-templates.md
│   └── test-scenarios/
│       └── <feature>.feature
├── completed/                       # Archive with learnings
│   └── T001-<feature>.md
├── updates/                         # Concurrent agent coordination
│   └── agent_<id>_<timestamp>.json
└── metrics.json                     # Performance tracking
```

## Getting Started

1. **Read task-manager.md agent role** (`.claude/agents/task-manager.md`) - Pure instructions, no hardcoded examples

2. **Invoke task-manager agent** - Discovers project type, finds documentation, creates project-specific structure

3. **Work with tasks**:
   - Check status: Read `.tasks/manifest.json`
   - Work on task: Load task file + context
   - Complete: Validate, archive, document learnings

## Key Principles

1. **Discovery Over Assumption** - Discovers structure, finds documentation (or works without), detects validation tools

2. **Lazy Loading** - Manifest for status (150 tokens), full context when executing (1,650 tokens)

3. **Project Agnostic** - Any language, framework, platform, documentation style

4. **Token Efficient** - 85%+ reduction vs monolithic, fast status checks, comprehensive context when needed

---

**Template Version**: 2.0.0
**Last Updated**: 2025-10-11
**For**: Universal Task Management System
