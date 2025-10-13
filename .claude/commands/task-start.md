---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-executor` - TDD-driven implementation specialist with mandatory validation

**FORBIDDEN:**
- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents (developer, coder, etc.)

**Why This Matters:**
This workflow's task-executor enforces:
- Mandatory TDD (tests before code, always)
- Anti-hallucination rules (verify everything)
- Iteration mandate until proven correct
- Meaningful tests (realistic inputs, green+red+edge paths)
- Rigid 60+ item completion gate

Global agents do NOT follow these extreme validation standards.

## Purpose

This command delegates task execution to the specialized task-executor agent that:
1. Validates task is available
2. Claims task atomically
3. Loads full context (~1,650 tokens)
4. Implements with TDD and continuous validation
5. Prepares for completion verification

Token budget: ~1,700 tokens startup, variable implementation

## Agent Invocation

**MANDATORY**: Use `task-executor` agent via Task tool.

```
Execute task: $ARGUMENTS

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Use Conditional Interview Protocol if acceptance criteria vague
- Apply Reliability Labeling to all technical claims
- Never invent API signatures or configuration - verify in source

**Your Mission:**
Implement this task following validation-driven development with zero shortcuts.

**Phase 1: Context Loading and Validation** (~1,650 tokens)
1. Read .tasks/manifest.json - Verify task exists, is pending, dependencies met, not blocked
2. Create atomic claim update in .tasks/updates/agent_<id>_<timestamp>.json
3. Update manifest status to `in_progress`
4. Load full task file from .tasks/tasks/$ARGUMENTS-<name>.md
5. Load project context:
   - context/project.md (business value, goals, constraints)
   - context/architecture.md (tech stack, patterns, design decisions)
   - context/test-scenarios/<feature> (if referenced)

**Phase 2: Implementation Plan**
1. Understand business context and user impact
2. Break down work into incremental steps
3. Identify files to create/modify
4. Plan test-first approach
5. Document plan in progress log

**Phase 3: Incremental Implementation**
1. Implement in small increments
2. Validate after EACH logical unit (tests, linter, build)
3. Check off acceptance criteria as you go (update task file)
4. Log progress and decisions continuously
5. Never mark criteria complete prematurely

**Phase 4: Continuous Validation**
Run validation commands frequently (from task file):
- After every file save: linter, formatter
- After logical unit: unit tests, type check
- After major milestone: full test suite, build
- Never proceed with failing validations

**Phase 5: Completion Preparation**
When ALL acceptance criteria met and ALL validations pass:
1. Update task file with final status
2. Document learnings (what worked, challenges, token usage, recommendations)
3. Report ready for completion verification
4. DO NOT call /task-complete yourself - let orchestrator handle it

**Expected Output:**
🚀 Starting Task: $ARGUMENTS

[Progress updates as you work]
[Validation results after each step]
[Decisions and rationale logged]
[Acceptance criteria checked off progressively]

✅ Ready for Completion:
- All acceptance criteria: ✓
- All validations passed: ✓
- Progress log complete: ✓
- Learnings documented: ✓

Request /task-complete $ARGUMENTS to finalize.

**Critical Rules:**
- Quality over speed - do it right once
- Validate continuously - catch issues early
- Document as you go - don't leave for later
- No shortcuts - all criteria must be met
- Never mark task complete - that's task-completer's job

**Race Condition Handling:**
If another agent is already working on this task:
1. Check manifest status before claiming
2. If status is `in_progress` with recent `started_at`:
   - Report: "Task $ARGUMENTS is already in progress by <agent> since <timestamp>"
   - Suggest: "/task-next to find alternative task"
   - Do NOT proceed with claim
3. If status is `in_progress` but stalled (>24h):
   - Escalate to /task-next for health check and remediation
   - Do NOT claim directly

Begin task execution now.
```

Use: `subagent_type: "task-executor"`

## Why Use task-executor Agent

- **Specialized Expertise**: Designed for validation-driven development
- **Full Context Awareness**: Loads and maintains all relevant context
- **Quality Focused**: Enforces continuous validation and testing
- **Progress Tracking**: Systematic logging and documentation
- **Prevents Shortcuts**: Ensures all acceptance criteria met before completion
- **Token Efficient**: Loads only what's needed (~1,650 tokens vs 12,000+ for all tasks)

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
