---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

**Date Awareness**: Get the current system date so you can use the correct dates in online searches

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-developer` - TDD-driven implementation specialist with mandatory validation (backend, logic, data)
- ✅ `task-ui` - Expert UI/UX designer with anti-generic enforcement and brand alignment (UI, design, interface)
- ✅ `task-smell` - Post-implementation code quality auditor detecting code smells and anti-patterns (quality verification)

**FORBIDDEN:**

- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents (developer, coder, frontend-developer, etc.)

**Why This Matters:**

**task-developer** enforces:

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

**task-developer** for:

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

- Delegate to task-developer which can sub-delegate UI portions to task-ui
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

**Backend Task Indicators** (delegate to `task-developer`):

- Title contains: "API", "database", "logic", "service", "integration", "migration"
- Acceptance criteria mention: "endpoint", "data processing", "business logic", "database", "testing"
- Description focuses on: backend logic, data operations, API development, system integration
- Tags include: "backend", "api", "database", "logic", "testing"

**Mixed Task Indicators**:

- Both UI and backend indicators present
- Action: Delegate to `task-developer` with note to sub-delegate UI work to `task-ui` if needed

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
- Execute Phase 0 discovery sequence completely before creating designs from scratch
- Apply all mandatory quality gates (genericness ≤3.0, confidence ≥7, Brand DNA alignment)
- Report ready for /task-complete when all criteria met

Begin UI design execution now.
```

Use: `subagent_type: "task-ui"`

---

## Agent Invocation: task-developer

**IF task is backend/logic-focused, use `task-developer` agent:**

```
Execute task: $ARGUMENTS

Follow your complete validation-driven workflow as defined in your agent configuration (.claude/agents/task-developer.md).

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

Use: `subagent_type: "task-developer"`

---

## Why Use Specialized Agents

**task-developer Agent:**

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

## Post-Implementation Quality Verification

After agent completes work, run immediate code quality audit:

**Use `task-smell` agent for quality verification:**

```
Verify code quality for task: $ARGUMENTS

Follow your complete quality audit workflow as defined in your agent configuration (.claude/agents/task-smell.md).

Task file location: .tasks/tasks/$ARGUMENTS-<name>.md

**IMPORTANT**:
- Operate within Minion Engine v3.0 framework
- Execute all phases: Context Loading → Static Analysis → Code Pattern Detection → Convention Verification → Report Generation
- Provide immediate, actionable feedback on code quality issues
- Flag Critical issues that must be fixed before /task-complete
- Document all findings with file:line references

**OUTPUT EXPECTATIONS**:
- ✅ PASS: Brief confirmation, proceed to /task-complete
- ⚠️  WARNING: Issues found, recommend fixes before completion
- ❌ FAIL: Critical issues, must fix before /task-complete

Begin quality verification now.
```

Use: `subagent_type: "task-smell"`

---

## Phase 3: Automatic Remediation Loop

**IF task-smell reports FAIL or REVIEW status with issues:**

Execute automatic remediation (max 3 attempts):

**Remediation Iteration:**

1. **Parse task-smell output** to determine status (PASS/REVIEW/FAIL)
2. **IF FAIL** (1+ Critical) **OR REVIEW** (3+ Warnings):
   - Invoke `task-developer` agent with remediation instructions
   - Provide full task-smell report as context
   - task-developer addresses ALL CRITICAL issues, as many WARNINGS as feasible
3. **Re-run task-smell** after fixes complete
4. **IF PASS achieved** → Exit loop, proceed to Next Steps
5. **IF still FAIL/REVIEW** → Increment attempt counter, repeat (max 3 total)
6. **IF max attempts reached** without PASS → Report to user, request manual intervention

---

### Agent Invocation: task-developer (Remediation Mode)

**Use `task-developer` agent to fix code quality issues:**

```
Fix code quality issues found for task: $ARGUMENTS

**Task-Smell Quality Report:**

[Insert complete task-smell output here - all findings with file:line references, severity classifications, and recommended fixes]

**Your Remediation Objectives:**

1. **CRITICAL Issues** (MANDATORY): Address ALL critical issues identified
2. **WARNING Issues** (STRONGLY RECOMMENDED): Fix as many warning issues as feasible
3. **Follow Standards**: Apply your LEVEL 0-2 validation standards
4. **Provide Evidence**: Document all fixes with file:line changes and verification outputs
5. **Verify Fixes**: Run relevant linters, tests, and validation commands after each fix

**Context:**

- Task file location: .tasks/tasks/$ARGUMENTS-<name>.md
- Original implementation by: [task-ui or task-developer - specify which]
- Remediation attempt: [X of 3]
- Quality gate: Must achieve PASS status to proceed to /task-complete

**IMPORTANT:**

- Do NOT add new features or change functionality
- Focus ONLY on addressing identified code quality issues
- Maintain all existing tests and behavior
- Follow discovered project conventions and patterns

Begin fixing issues now. Report completion with evidence.
```

Use: `subagent_type: "task-developer"`

**After task-developer completes remediation:**

Re-run task-smell verification (repeat task-smell agent invocation from Phase 2) to validate fixes.

**Iteration Control:**

- Attempt 1: First remediation pass
- Attempt 2: If still FAIL/REVIEW after attempt 1
- Attempt 3: Final remediation attempt if still FAIL/REVIEW after attempt 2

**Exit Conditions:**

- ✅ **Success**: task-smell returns PASS → proceed to Next Steps
- ⚠️ **Max Attempts**: 3 attempts exhausted, still FAIL/REVIEW → escalate to user
- ℹ️ **Initial Pass**: If task-smell returns PASS on first run, skip this phase entirely

---

## Next Steps

After automatic remediation completes (or if initial task-smell returned PASS):

- **If ✅ PASS achieved**: Use `/task-complete $ARGUMENTS` to validate and archive task
- **If remediation failed after 3 attempts**: Review remaining issues manually, apply fixes, re-run task-smell until PASS, then `/task-complete $ARGUMENTS`
- **Quality gate**: Only proceed to `/task-complete` when task-smell returns PASS status

**Note**: The automatic remediation loop (Phase 3) ensures code quality issues are addressed before completion. Manual intervention is only required if automatic fixes fail after 3 attempts.
