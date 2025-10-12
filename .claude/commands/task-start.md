---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

**What This Command Does:**

1. **Validate Task** (~150 tokens)
   - Read `.tasks/manifest.json`
   - Verify task ID exists
   - Check status is `pending` (not already in progress)
   - Verify all dependencies are completed
   - Check task is not blocked

2. **Claim Task Atomically**
   - Create `.tasks/updates/agent_<id>_<timestamp>.json` with:
     ```json
     {
       "agent_id": "<agent-id>",
       "timestamp": "<ISO-8601>",
       "action": "claim",
       "task_id": "$ARGUMENTS",
       "new_status": "in_progress"
     }
     ```
   - Update manifest status to `in_progress`

3. **Load Full Context** (~1,650 tokens total)
   - Load specific task file (~600 tokens)
   - Load referenced context files (~900 tokens):
     - `context/project.md`
     - `context/architecture.md`
     - `context/test-scenarios/<feature>.feature`

4. **Display Task Details**
   ```
   🚀 Starting Task: $ARGUMENTS

   Title: <task-title>
   Status: in_progress
   Priority: <1-5>

   Description:
   <full-description>

   Acceptance Criteria:
   - [ ] <criterion-1>
   - [ ] <criterion-2>

   Test Scenarios:
   <scenarios>

   Dependencies:
   <dependencies-status>

   Validation Commands:
   <validation-commands>

   Project Context Loaded:
   ✓ context/project.md
   ✓ context/architecture.md
   ✓ context/test-scenarios/<feature>

   Ready to work on this task!
   ```

**If Task Cannot Be Started:**

Display clear error:
- "Task T00X not found in manifest"
- "Task T00X is already in_progress"
- "Task T00X has incomplete dependencies: [list]"
- "Task T00X is blocked by: [blocker-description]"

**Working on the Task:**

With full context loaded, you can now:
- Implement according to acceptance criteria
- Reference test scenarios for expected behavior
- Run validation commands to verify
- Log progress in task file

**During Work:**
- Update progress: Edit `.tasks/tasks/T00X-<name>.md` progress log
- Add notes about decisions, blockers discovered
- Check off acceptance criteria as you complete them

**When Done:**
Use `/task-complete $ARGUMENTS` to validate and finalize.

**Token Usage:**
- Validation: ~150 tokens (manifest only)
- Full load: ~1,650 tokens (manifest + task + context)
- Much more efficient than loading all tasks (12,000+ tokens)
