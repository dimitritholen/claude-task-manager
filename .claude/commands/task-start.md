---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

**MANDATORY**: This command MUST use the `task-executor` agent via the Task tool for full task execution with validation-driven development.

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
