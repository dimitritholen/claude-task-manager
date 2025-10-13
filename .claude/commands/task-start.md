---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-executor` - Validation-driven development specialist with mandatory TDD, continuous validation, and zero-tolerance quality standards

**FORBIDDEN:**
- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents (developer, coder, etc.)
- ❌ ANY agent not explicitly listed above

**Enforcement:**
Before invoking Task tool with `subagent_type: "task-executor"`, verify this specific agent exists in THIS workflow's agents.
This workflow's task-executor is specifically designed with:
- Mandatory TDD (no exceptions)
- Anti-hallucination rules
- Iteration mandate until proven
- Meaningful tests only (realistic inputs, green+red+edge paths)
- Rigid 60+ item completion gate

**Why This Matters:**
Global agents (even named "developer" or "task-executor") do NOT follow this workflow's extreme skepticism and validation standards. Using them would bypass the quality gates this system enforces.

**MANDATORY**: This command MUST use the `task-executor` agent via the Task tool for full task execution with validation-driven development.

**Token Budget Breakdown:**
- Context loading: ~1,650 tokens total
  - Manifest read: ~150 tokens
  - Task file: ~600 tokens
  - Project context: ~300 tokens
  - Architecture context: ~300 tokens
  - Test scenarios: ~300 tokens
- Task claiming overhead: ~50 tokens
- **Total startup cost: ~1,700 tokens** (vs 12,000+ for loading all tasks)

**Invoke the task-executor agent with:**

```
Execute task: $ARGUMENTS

**Your Mission:**
You are responsible for implementing this task following validation-driven development with zero shortcuts.

**Phase 1: Context Loading and Validation** (~1,650 tokens)
1. Read `.tasks/manifest.json` - Verify task exists, is pending, dependencies met, not blocked
2. Create atomic claim update in `.tasks/updates/agent_<id>_<timestamp>.json`:
   ```json
   {
     "agent_id": "task-executor",
     "timestamp": "<ISO-8601>",
     "action": "claim",
     "task_id": "$ARGUMENTS",
     "new_status": "in_progress"
   }
   ```
3. Update manifest status to `in_progress`
4. Load full task file from `.tasks/tasks/$ARGUMENTS-<name>.md`
5. Load project context:
   - `context/project.md` (business value, goals, constraints)
   - `context/architecture.md` (tech stack, patterns, design decisions)
   - `context/test-scenarios/<feature>` (if referenced)

**Phase 2: Implementation Plan**
1. Understand business context and user impact
2. Break down work into incremental steps
3. Identify files to create/modify
4. Plan test-first approach where applicable
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
When ALL acceptance criteria are met and ALL validations pass:
1. Update task file with final status
2. Document learnings (what worked, challenges, token usage, recommendations)
3. Report ready for completion verification
4. DO NOT call /task-complete yourself - let orchestrator handle it

**Expected Output During Execution:**
```
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
```

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

**Concurrent Execution Safety:**
- Always read manifest before updating
- Use atomic update file in .tasks/updates/
- Include timestamp and agent ID in claim
- Verify claim succeeded by re-reading manifest

Begin task execution now.
```

**Why Use task-executor Agent:**

- **Specialized Expertise**: Designed for validation-driven development
- **Full Context Awareness**: Loads and maintains all relevant context
- **Quality Focused**: Enforces continuous validation and testing
- **Progress Tracking**: Systematic logging and documentation
- **Prevents Shortcuts**: Ensures all acceptance criteria met before completion
- **Token Efficient**: Loads only what's needed (~1,650 tokens vs 12,000+ for all tasks)

**Agent Will Handle:**
✓ Task validation and claiming
✓ Context loading (project, architecture, tests)
✓ Implementation planning and execution
✓ Continuous validation (tests, linting, build)
✓ Progress logging and decision documentation
✓ Acceptance criteria tracking
✓ Completion preparation and learnings

**You Will NOT Need To:**
✗ Manually load context files
✗ Track validation separately
✗ Manage progress logs
✗ Call /task-complete (agent signals when ready)

**Fallback Behavior:**

If task-executor agent invocation fails:

```
⚠️  Agent Invocation Failed

Error: task-executor agent could not be started
Reason: <specific-error>

Fallback Options:
1. Retry with explicit agent configuration
2. Use direct execution mode (less structured, not recommended)
3. Report issue and use /task-next to select different task

Recommended: Fix agent configuration before proceeding.
```

**When to Use Direct Execution vs Agent:**
- **Always prefer agent** for standard tasks (comprehensive, validated)
- **Direct mode only if**:
  - Agent system is unavailable
  - Task is trivial (< 1,000 tokens)
  - Emergency hotfix required
- **Never use direct mode** for tasks with dependencies or complex validation

**Troubleshooting:**

| Issue | Cause | Solution |
|-------|-------|----------|
| "Task not found" | Invalid task ID | Check /task-status for valid IDs |
| "Already in progress" | Concurrent claim | Use /task-next instead |
| "Dependencies not met" | Prereqs incomplete | Complete dependencies first |
| "Task is blocked" | Documented blocker | Resolve blocker, update manifest |
| "Agent failed to start" | Config issue | Check agent configuration |
