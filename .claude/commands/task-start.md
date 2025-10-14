---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-executor` - TDD-driven implementation specialist with mandatory validation (backend, logic, data)
- ✅ `task-ui` - Expert UI/UX designer with anti-generic enforcement and brand alignment (UI, design, interface)

**FORBIDDEN:**

- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents (developer, coder, frontend-developer, etc.)

**Why This Matters:**

**task-executor** enforces:

- Mandatory TDD (tests before code, always)
- Anti-hallucination rules (verify everything)
- Iteration mandate until proven correct
- Meaningful tests (realistic inputs, green+red+edge paths)
- Rigid 60+ item completion gate

**task-ui** enforces:

- Mandatory Brand DNA alignment (every decision justified)
- Anti-generic enforcement (genericness test ≤3.0 required)
- Design system consistency (create once, reuse everywhere)
- Sophisticated design choices (no junior/template patterns)
- Rigid quality gates (11 anti-patterns, accessibility, pre-delivery audit)

Global agents do NOT follow these extreme validation standards.

## Purpose

This command analyzes the task type and delegates to the appropriate specialized agent:

**task-executor** for:

- Backend logic, APIs, data processing
- Business logic, algorithms
- Database operations, migrations
- System integrations
- Testing infrastructure

**task-ui** for:

- UI/UX design and implementation
- Interface components
- Page layouts, screens
- Design systems
- Visual design, styling

**Mixed tasks** (both backend and UI):

- Delegate to task-executor which can sub-delegate UI portions to task-ui
- Or split into separate UI and backend sub-tasks

Token budget: ~1,700 tokens startup, variable implementation

## Task Analysis & Agent Selection

**Step 1: Load and Analyze Task**

Read `.tasks/tasks/$ARGUMENTS-<name>.md` and analyze:

**UI Task Indicators** (delegate to `task-ui`):

- Title contains: "design", "UI", "interface", "component", "page", "screen", "layout", "visual", "styling"
- Acceptance criteria mention: "user interface", "design system", "visual design", "layout", "responsive", "styling"
- Description focuses on: UI/UX, visual design, interface creation, component design
- Tags include: "ui", "design", "interface", "frontend-ui"

**Backend Task Indicators** (delegate to `task-executor`):

- Title contains: "API", "database", "logic", "service", "integration", "migration"
- Acceptance criteria mention: "endpoint", "data processing", "business logic", "database", "testing"
- Description focuses on: backend logic, data operations, API development, system integration
- Tags include: "backend", "api", "database", "logic", "testing"

**Mixed Task Indicators**:

- Both UI and backend indicators present
- Action: Delegate to `task-executor` with note to sub-delegate UI work to `task-ui` if needed

**Step 2: Select Agent**

Based on analysis above, choose appropriate agent and proceed with invocation.

---

## Agent Invocation: task-ui

**IF task is UI-focused, use `task-ui` agent:**

```
Execute UI design task: $ARGUMENTS

Follow your complete workflow as defined in your agent configuration (.claude/agents/task-ui.md).

Task file location: .tasks/tasks/$ARGUMENTS-<name>.md

**IMPORTANT**:
- Operate within Minion Engine v3.0 framework
- Execute all phases: Design System Discovery → Context Loading → Concept Generation → Selection → Specification → Genericness Test → Implementation → Pre-Delivery Audit → Completion
- Apply all mandatory quality gates (genericness ≤3.0, confidence ≥7, Brand DNA alignment)
- Report ready for /task-complete when all criteria met

Begin UI design execution now.
```

Use: `subagent_type: "task-ui"`

---

## Agent Invocation: task-executor

**IF task is backend/logic-focused, use `task-executor` agent:**

```
Execute task: $ARGUMENTS

Follow your complete validation-driven workflow as defined in your agent configuration (.claude/agents/task-executor.md).

Task file location: .tasks/tasks/$ARGUMENTS-<name>.md

**IMPORTANT**:
- Operate within Minion Engine v3.0 framework
- Execute all phases: Context Loading → Implementation Plan → Incremental Implementation → Continuous Validation → Completion
- Follow TDD: tests before code, validate after each unit
- Check race conditions before claiming task
- Report ready for /task-complete when all criteria met

**NOTE**: If this task includes UI work, you may sub-delegate to `task-ui` agent for design portions

Begin task execution now.
```

Use: `subagent_type: "task-executor"`

---

## Why Use Specialized Agents

**task-executor Agent:**

- **Specialized Expertise**: Validation-driven development with TDD
- **Full Context Awareness**: Loads and maintains all relevant context
- **Quality Focused**: Enforces continuous validation and testing
- **Progress Tracking**: Systematic logging and documentation
- **Prevents Shortcuts**: All acceptance criteria met before completion
- **Token Efficient**: Loads only needed context (~1,650 tokens)

**task-ui Agent:**

- **Design Expertise**: 10+ years equivalent UI/UX design experience
- **Brand Alignment**: Mandatory Brand DNA analysis and application
- **Anti-Generic Enforcement**: Genericness test ≤3.0 required
- **Design System**: Creates reusable system on first run, applies consistently
- **Quality Gates**: 11 anti-patterns checked, accessibility required, pre-delivery audit
- **Research-Backed**: Trend research with strategic synthesis, not blind following

## Error Handling

**If task not found:**

```
❌ Task $ARGUMENTS not found in manifest

Check /task-status for valid task IDs
```

**If task already in progress:**

```
⚠️  Task $ARGUMENTS is already in progress

Started by: <agent>
Started at: <timestamp>

Use /task-next to find alternative task
```

**If dependencies not met:**

```
❌ Task $ARGUMENTS has incomplete dependencies

Required: <list-of-tasks>
Status: <completion-status-of-each>

Complete dependencies first
```

**If task is blocked:**

```
🚫 Task $ARGUMENTS is blocked

Blocker: <description>

Resolve blocker and update manifest before starting
```

## Next Steps

After agent completes work:

- Use `/task-complete $ARGUMENTS` to validate and archive task
- Or continue working if not yet ready for completion
