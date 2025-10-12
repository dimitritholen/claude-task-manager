---
allowed-tools: Read, Write, Edit, Bash, Task
argument-hint: [task-id]
description: Validate task completion, run checks, and archive with learnings
---

Complete and archive task: $ARGUMENTS

**MANDATORY**: This command MUST use the `task-completer` agent via the Task tool for zero-tolerance quality gate enforcement.

**Invoke the task-completer agent with:**

```
Validate completion and archive task: $ARGUMENTS

**Your Mission:**
You are the quality gatekeeper. Enforce zero-tolerance completion standards.

**Phase 1: Initial Validation** (~150 tokens)
1. Load `.tasks/manifest.json` - Verify task status is `in_progress`
2. Load `.tasks/tasks/$ARGUMENTS-<name>.md` - Parse all sections
3. Extract:
   - All acceptance criteria (checkboxes)
   - All validation commands
   - Progress log
   - Any documented blockers

**Phase 2: Acceptance Criteria Verification** (~500 tokens)
1. Scan for ALL checkboxes: `- [ ]` vs `- [x]`
2. **REQUIREMENT**: ALL must be `[x]`, ZERO `[ ]` allowed
3. If ANY unchecked: **REJECT immediately**
4. Spot-check critical criteria for evidence:
   - Security criteria → verify implementation exists
   - Data integrity criteria → verify tests exist
   - Performance criteria → verify benchmarks met

**Phase 3: Validation Command Execution** (~800 tokens)
1. Extract validation commands from task file
2. Execute EACH command sequentially
3. Record: exit code, output, duration
4. **FAIL FAST**: First failure → stop, report, reject
5. Required pass rate: **100%** (no exceptions)

Validation must include:
- Linter: 0 errors, 0 warnings
- Tests: 100% pass rate
- Build: Success with 0 warnings
- Type checker: 0 errors (if applicable)
- Any custom validation from task file

**Phase 4: Definition of Done Checklist** (~300 tokens)
Verify EVERY item:

Code Quality:
- [ ] All acceptance criteria checked
- [ ] No TODO/FIXME/HACK comments
- [ ] Code follows project conventions
- [ ] No dead/commented code
- [ ] No debug artifacts

Testing:
- [ ] All tests pass
- [ ] New tests for new functionality
- [ ] Edge cases covered
- [ ] Error handling tested

Documentation:
- [ ] Code comments where necessary
- [ ] Function/class docstrings
- [ ] README updated (if applicable)
- [ ] Architecture docs updated (if applicable)

Integration:
- [ ] Works with existing components
- [ ] No breaking changes (or documented)
- [ ] Performance acceptable
- [ ] Security reviewed

**Phase 5: Learning Extraction** (~400 tokens)
Extract or prompt for:
1. What worked well
2. What was harder than expected
3. Token usage (estimated vs actual with variance)
4. Recommendations for similar tasks
5. Technical debt created (if any)

**Quality bar**: Learnings must be specific, honest, quantitative, actionable

**Phase 6: Atomic Completion** (~200 tokens)
If ALL checks pass:
1. Create `.tasks/updates/agent_task-completer_<timestamp>.json`:
   ```json
   {
     "agent_id": "task-completer",
     "timestamp": "<ISO-8601>",
     "action": "complete",
     "task_id": "$ARGUMENTS",
     "new_status": "completed",
     "actual_tokens": <calculated>,
     "completion_validated": true
   }
   ```
2. Update manifest: status → `completed`, actual_tokens, completed_at
3. Copy task file to `.tasks/completed/` with completion record
4. Update `.tasks/metrics.json` with completion data

**Phase 7: Dependency Resolution** (~150 tokens)
1. Find tasks that depend on this one
2. Check if their dependencies are now all complete
3. Report unblocked tasks

**Expected Output - SUCCESS:**
```
✅ Task $ARGUMENTS Completed Successfully!

Summary:
- All acceptance criteria met: ✓ (<count> criteria)
- All validation commands passed: ✓ (<count> commands)
- Definition of Done verified: ✓
- Learnings documented: ✓
- Task archived: ✓

Validation Results:
✓ Linter: PASS
✓ Tests: PASS (<count> tests)
✓ Build: PASS
✓ Type Check: PASS

Metrics:
- Estimated tokens: <est>
- Actual tokens: <actual>
- Variance: <percentage>%
- Duration: <minutes> minutes

Impact:
- Progress: <completed>/<total> tasks (<percentage>%)
- Unblocked: <count> tasks now actionable

Learnings: [summary]

Next: Use /task-next to find next task
```

**Expected Output - REJECTION:**
```
❌ Task $ARGUMENTS Completion REJECTED

Reason: <primary-failure-reason>

Issues Found:
- <detailed-issue-1>
- <detailed-issue-2>

Failed Validation:
✗ <command>: EXIT <code>
  <error-output>

Unchecked Criteria:
- [ ] <criterion-still-unchecked>

Required Actions:
1. <fix-step-1>
2. <fix-step-2>
3. Re-run: <validation-commands>
4. Retry /task-complete $ARGUMENTS

Task remains `in_progress`.
```

**Critical Rules:**
- **Binary outcome**: Complete (100%) or Incomplete (0%) - no middle ground
- **Zero tolerance**: ANY failure = reject entire completion
- **No shortcuts**: "90% done" = incomplete
- **Enforce standards**: Your approval reflects system integrity
- **Fail fast**: First validation failure → stop and report
- **Document everything**: Comprehensive audit trail

Begin completion validation now.
```

**Why Use task-completer Agent:**

- **Quality Gatekeeper**: Enforces zero-tolerance completion standards
- **Comprehensive Validation**: Runs ALL checks automatically
- **Prevents Technical Debt**: Blocks incomplete work from being marked done
- **Consistent Standards**: Same rigorous validation every time
- **Audit Trail**: Complete documentation of what was verified
- **Dependency Management**: Automatically identifies and reports unblocked tasks
- **Metrics Tracking**: Calculates token usage, variance, and updates project metrics

**Agent Will Enforce:**
✓ ALL acceptance criteria checked (100%, no exceptions)
✓ ALL validation commands pass (linter, tests, build, type check)
✓ Definition of Done checklist verified
✓ Learnings documented with quality bar
✓ No TODO/FIXME/HACK comments
✓ No failing tests or build errors
✓ Progress log complete with decisions

**Agent Will NOT Allow:**
✗ "90% done" or partial completion
✗ Skipping validation commands
✗ Unchecked acceptance criteria
✗ Failing tests with promises to "fix later"
✗ Minimal or generic learnings
✗ Technical debt shortcuts

**Philosophy:**
> Premature completion is worse than no completion.
> It blocks dependent tasks with broken foundations and creates confusion.
> Binary outcome: Complete (100%) or Incomplete (0%) - no middle ground.
