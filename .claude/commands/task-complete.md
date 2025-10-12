---
allowed-tools: Read, Write, Edit, Bash, Task
argument-hint: [task-id]
description: Validate task completion, run checks, and archive with learnings
---

Complete and archive task: $ARGUMENTS

**What This Command Does:**

1. **Load and Validate** (~1,650 tokens)
   - Read manifest and verify task is `in_progress`
   - Load task file
   - Check all acceptance criteria are checked `[x]`
   - Verify no `[ ]` criteria remain

2. **Run Validation Commands**
   - Execute all validation commands from task file
   - Tests must pass
   - Build must succeed
   - Linting must pass
   - All checks must complete successfully

3. **Verify Completion Checklist**
   ```markdown
   Required checks:
   ✓ All acceptance criteria checked
   ✓ All validation commands passed
   ✓ Tests written and passing
   ✓ Code review passed (if required)
   ✓ Documentation updated
   ✓ No linting errors
   ✓ No TODO/FIXME remaining
   ```

4. **Prompt for Learnings**
   - What worked well?
   - What was harder than expected?
   - Token usage (estimated vs actual)
   - Recommendations for similar tasks

5. **Complete Task Atomically**
   - Create `.tasks/updates/agent_<id>_<timestamp>.json`:
     ```json
     {
       "agent_id": "<agent-id>",
       "timestamp": "<ISO-8601>",
       "action": "complete",
       "task_id": "$ARGUMENTS",
       "new_status": "completed",
       "actual_tokens": <calculated>
     }
     ```
   - Update manifest: status → `completed`, actual_tokens
   - Update stats.completed counter

6. **Archive Task**
   - Copy `.tasks/tasks/T00X-<name>.md` to `.tasks/completed/`
   - Fill learnings section with captured insights
   - Calculate token variance

7. **Update Metrics**
   - Update `.tasks/metrics.json`:
     ```json
     {
       "total_tasks_completed": <increment>,
       "total_tokens_used": <add-actual>,
       "last_completed": {
         "task_id": "$ARGUMENTS",
         "timestamp": "<ISO-8601>",
         "tokens": <actual>,
         "duration_minutes": <calculated>
       }
     }
     ```

**If Task Cannot Be Completed:**

Display clear error with remaining work:
```
❌ Task $ARGUMENTS cannot be completed:

Incomplete Acceptance Criteria:
- [ ] <criterion-still-unchecked>

Failed Validation:
✗ <validation-command> (exit code: X)
  <error-output>

Remaining Checklist Items:
- [ ] <incomplete-item>

Fix these issues before marking complete.
```

**Definition of Done:**

Task is ONLY complete when:
- ✅ All acceptance criteria checked
- ✅ All validation commands pass
- ✅ All tests passing
- ✅ Documentation updated
- ✅ No linting errors
- ✅ Learnings documented

**Premature Completion is Technical Debt:**

Never mark a task complete until ALL criteria are met. This blocks dependent tasks and creates confusion.

**Success Output:**

```
✅ Task $ARGUMENTS Completed Successfully!

Summary:
- Accepted all criteria: ✓
- Validation passed: ✓
- Tests passing: ✓
- Archived with learnings: ✓

Metrics:
- Estimated tokens: <est>
- Actual tokens: <actual>
- Variance: <percentage>%
- Duration: <minutes> minutes

Next Steps:
- Use /task-next to find next task
- Use /task-status for overview
```

**Dependent Tasks Unblocked:**

If other tasks depend on this one, they become actionable:
```
🔓 Unblocked Tasks:
- T00X: <title> (now pending)
- T00Y: <title> (now pending)
```
