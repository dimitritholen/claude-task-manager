---
allowed-tools: Read, Write, Edit, Bash, Task
argument-hint: [task-id]
description: Validate task completion with multi-stage verification (22 verify-* agents), run all checks, and archive with learnings
---

Complete and archive task: $ARGUMENTS

**Date Awareness**: Get the current system date so you can use the correct dates in online searches

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-completer` - Zero-tolerance quality gatekeeper with comprehensive validation

**FORBIDDEN:**

- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents

**Why This Matters:**
This workflow's task-completer enforces:

- ALL acceptance criteria must be checked (100%, no exceptions)
- ALL validation commands must pass (0 errors, 0 warnings)
- **Multi-Stage Verification Pipeline** (Phase 3.7):
  - Intelligent selection of verify-* agents (8-12 of 22 agents)
  - 5 progressive stages: Syntax → Execution → Security → Quality → Integration
  - Parallel execution within stages, fail-fast between stages
  - Coverage: security, performance, architecture, complexity, duplication, etc.
- Binary outcome: Complete (100%) or Incomplete (0%)
- Fail-fast protocol (first failure stops validation)
- Comprehensive Definition of Done checklist
- Learning extraction with quality bar

This agent is the FINAL QUALITY GATE with 22 specialized verify-* agents. Global agents do NOT enforce these zero-tolerance standards.

## Purpose

This command delegates completion validation to the specialized task-completer agent that:

1. Verifies ALL acceptance criteria are checked
2. Executes ALL validation commands
3. Runs Multi-Stage Verification Pipeline (Phase 3.7):
   - STAGE 1: verify-syntax, verify-complexity, verify-dependency (ALWAYS)
   - STAGE 2: verify-execution, verify-business-logic, verify-test-quality (conditional)
   - STAGE 3: verify-security, verify-data-privacy (conditional)
   - STAGE 4: verify-quality, verify-performance, verify-architecture, etc. (conditional)
   - STAGE 5: verify-database, verify-integration, verify-regression, etc. (conditional)
4. Enforces Definition of Done checklist
5. Extracts learnings
6. Archives task atomically
7. Reports unblocked downstream tasks

Token budget: ~3,500-4,200 tokens (load task + validation + multi-stage verification + archival)

## Agent Invocation

**MANDATORY**: Use `task-completer` agent via Task tool.

```
Validate completion and archive task: $ARGUMENTS

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).

**Minion Engine Requirements for Validation:**
- **Reliability Labeling MANDATORY**: ALL validation assessments MUST include confidence scores
- **Evidence-Based Claims**: Attach actual command outputs (never claim without proof)
- **Interview Protocol**: Trigger if evidence insufficient or learnings weak
- **Fail-Fast**: First failure with evidence → STOP → REJECT
- **No Speculation**: "Probably works" = REJECT, only 🟢100 [CONFIRMED] accepted

**Your Mission:**
You are the quality gatekeeper. Enforce zero-tolerance completion standards.

**Phase 1: Initial Validation** (~150 tokens)
1. Load .tasks/manifest.json - Verify task status is `in_progress`
2. Load .tasks/tasks/$ARGUMENTS-<name>.md - Parse all sections
3. Extract:
   - All acceptance criteria (checkboxes)
   - All validation commands
   - Progress log
   - Any documented blockers

**Phase 2: Acceptance Criteria Verification** (~500 tokens)
1. Scan for ALL checkboxes: `- [ ]` vs `- [x]`
2. REQUIREMENT: ALL must be `[x]`, ZERO `[ ]` allowed
3. If ANY unchecked: REJECT immediately
4. Spot-check critical criteria for evidence:
   - Security criteria → verify implementation exists
   - Data integrity criteria → verify tests exist
   - Performance criteria → verify benchmarks met

**Phase 3: Validation Command Execution** (~800 tokens)
1. Extract validation commands from task file
2. Execute EACH command sequentially
3. Record: exit code, output, duration
4. FAIL FAST: First failure → stop, report, reject
5. Required pass rate: 100% (no exceptions)

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

Quality bar: Learnings must be specific, honest, quantitative, actionable

**Phase 6: Atomic Completion** (~200 tokens)
If ALL checks pass:
1. Create .tasks/updates/agent_task-completer_<timestamp>.json
2. Update manifest: status → `completed`, actual_tokens, completed_at
3. Copy task file to .tasks/completed/ with completion record
4. Update .tasks/metrics.json with completion data

**Phase 7: Dependency Resolution** (~150 tokens)
1. Find tasks that depend on this one
2. Check if their dependencies are now all complete
3. Report unblocked tasks

**Expected Output - SUCCESS (with Reliability Labels):**
✅ Task $ARGUMENTS Completed Successfully!

Summary:
- All acceptance criteria met: 🟢100 [CONFIRMED] (<count> criteria, all checked)
- All validation commands passed: 🟢100 [CONFIRMED] (<count> commands, exit code 0)
- Definition of Done verified: 🟢95 [CONFIRMED] (all checklist items verified)
- Learnings documented: 🟢90 [CONFIRMED] (substantive, specific, actionable)
- Task archived: 🟢100 [CONFIRMED] (atomic update completed)

Validation Results (Evidence-Based):
✓ Linter: 🟢100 [CONFIRMED]
  Command: ruff check .
  Output: All checks passed!
  Exit code: 0
  Timestamp: 2025-10-13T14:23:45Z

✓ Tests: 🟢100 [CONFIRMED]
  Command: pytest tests/
  Output: 47 passed, 0 failed
  Exit code: 0
  Timestamp: 2025-10-13T14:24:12Z

✓ Build: 🟢100 [CONFIRMED]
  Command: npm run build
  Output: Build succeeded, 0 warnings
  Exit code: 0
  Timestamp: 2025-10-13T14:24:45Z

✓ Type Check: 🟢100 [CONFIRMED]
  Command: tsc --noEmit
  Output: No errors
  Exit code: 0
  Timestamp: 2025-10-13T14:25:03Z

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

**Expected Output - REJECTION:**
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

**Critical Rules:**
- Binary outcome: Complete (100%) or Incomplete (0%) - no middle ground
- Zero tolerance: ANY failure = reject entire completion
- No shortcuts: "90% done" = incomplete
- Enforce standards: Your approval reflects system integrity
- Fail fast: First validation failure → stop and report
- Document everything: Comprehensive audit trail

Begin completion validation now.
```

Use: `subagent_type: "task-completer"`

## Why Use task-completer Agent

- **Quality Gatekeeper**: Enforces zero-tolerance completion standards
- **Comprehensive Validation**: Runs ALL checks automatically
- **Prevents Technical Debt**: Blocks incomplete work from being marked done
- **Consistent Standards**: Same rigorous validation every time
- **Audit Trail**: Complete documentation of what was verified
- **Dependency Management**: Automatically identifies and reports unblocked tasks
- **Metrics Tracking**: Calculates token usage, variance, and updates project metrics

## Philosophy

> Premature completion is worse than no completion. It blocks dependent tasks with broken foundations and creates confusion. Binary outcome: Complete (100%) or Incomplete (0%) - no middle ground.

## Next Steps

After completion:

- Use `/task-next` to find next actionable task
- Or review `/task-status` for overall progress
