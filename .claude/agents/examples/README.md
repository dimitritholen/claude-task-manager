# Task Management System - Structural Examples

This directory contains **structural templates** with placeholders. These examples show the **format and structure** of task management files, not actual project-specific content.

## Purpose

These templates demonstrate:
- **File structures** - What sections and fields are required
- **Placeholder conventions** - How to indicate dynamic content
- **Token budgets** - Target sizes for each file type
- **Relationships** - How files reference each other

**These are NOT project-specific examples.** The agent will fill in actual content based on your project's:
- Language and framework
- Documentation style
- Testing approach
- Build system
- Project structure

## Files in This Directory

### `manifest.json`

**Purpose**: Shows the structure of the ultra-lightweight task index

**Key Points**:
- Status values: pending, in_progress, blocked, completed
- Task dependencies reference other task IDs
- Blocked_by describes the blocker, not a task ID
- Token tracking: estimated and actual
- **Token Budget**: ≤ 200 tokens

### `T002-example-task.md`

**Purpose**: Shows the comprehensive structure of a task file

**Key Sections**:
- Frontmatter with metadata (YAML)
- Context and documentation references
- Acceptance criteria checklist
- Test scenarios
- Technical implementation details
- Progress log
- Completion checklist
- Learnings (post-completion)

**Token Budget**: 400-800 tokens

### `context-project.md`

**Purpose**: Shows the structure for high-level project context

**Key Sections**:
- Vision and goals
- Target users
- Success metrics
- Constraints
- Non-negotiables
- Development timeline

**Token Budget**: ≤ 300 tokens

### `example-test-scenario.feature`

**Purpose**: Shows Gherkin format for test scenarios

**Key Points**:
- Feature description with user story
- Background for common preconditions
- Multiple scenario types (happy path, edge cases, errors, performance)
- Given/When/Then structure

**Format**: Gherkin (but can be adapted to project's testing style)

## How to Use These Templates

1. **Don't copy these files directly into your project**
   - They contain placeholders, not real content

2. **Let the task-manager agent discover your project**
   - It will identify your language, framework, and structure
   - It will find your documentation (or work without it)
   - It will detect your testing approach

3. **The agent will create project-specific versions**
   - Filled with your project's actual requirements
   - Using your project's validation commands
   - Matching your project's conventions

## Placeholder Conventions

In these templates, placeholders use this format:

- `<placeholder>` - Single value to be filled in
- `<feature-name>` - Specific feature identifier
- `<ISO-8601-timestamp>` - Timestamp in ISO 8601 format
- `<description>` - Multi-word description

## Token Efficiency

The fractal architecture works like this:

```
Status Check (Frequent)
├── Read: manifest.json (~150 tokens)
└── Decision made - which task to work on

Task Execution (When working)
├── Read: manifest.json (~150 tokens)
├── Read: specific task file (~600 tokens)
├── Read: context files (~900 tokens)
└── Total: ~1,650 tokens

vs. Monolithic Approach
└── Read: one giant file (~12,000+ tokens)

Savings: 85%+ reduction in token usage
```

## Adaptation Examples

The agent adapts to different project types:

**Python Project**:
- Detects: pyproject.toml, requirements.txt
- Uses: pytest, mypy, black, ruff
- Creates: Test scenarios matching pytest conventions

**TypeScript Project**:
- Detects: package.json, tsconfig.json
- Uses: vitest/jest, tsc, eslint, prettier
- Creates: Test scenarios matching vitest/jest conventions

**Rust Project**:
- Detects: Cargo.toml
- Uses: cargo test, cargo build, cargo clippy, rustfmt
- Creates: Test scenarios matching Rust conventions

**Any Project**:
- Discovers what exists
- Adapts to project conventions
- Works with minimal or no documentation

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

1. **Read the task-manager.md agent role**:
   - Located at: `.claude/agents/task-manager.md`
   - Pure instructions, no hardcoded examples

2. **Invoke the task-manager agent**:
   - It will discover your project type
   - It will find your documentation
   - It will create project-specific task structure

3. **Start working with tasks**:
   - Check status: Read `.tasks/manifest.json`
   - Work on task: Load specific task file + context
   - Complete task: Validate, archive, document learnings

## Key Principles

1. **Discovery Over Assumption**
   - Agent discovers project structure
   - Agent finds documentation (or works without)
   - Agent detects validation tools

2. **Lazy Loading**
   - Only load what you need
   - Manifest for status checks (150 tokens)
   - Full context only when executing (1,650 tokens)

3. **Project Agnostic**
   - Works with any language
   - Works with any framework
   - Works with any platform
   - Works with any documentation style

4. **Token Efficient**
   - 85%+ reduction vs monolithic
   - Fast status checks
   - Comprehensive context when needed

---

**Template Version**: 2.0.0
**Last Updated**: 2025-10-11
**For**: Universal Task Management System
