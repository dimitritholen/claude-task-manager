---
allowed-tools: Read, Write, Edit, Bash, Task
argument-hint: [task-id]
description: Validate task completion with multi-stage verification (22 verify-* agents), run all checks, and archive with learnings
---

<invocation>
Complete and archive task: **$ARGUMENTS**
</invocation>

<critical_setup>
**MANDATORY PRE-FLIGHT**:
- **Date Awareness**: Get current system date
- **Zero-Tolerance Mode**: **ANY** failure = **IMMEDIATE** rejection
</critical_setup>

<philosophy>
**BINARY OUTCOME**: Complete (100%) or Incomplete (0%) — **NO MIDDLE GROUND**

**QUALITY GATE**: Premature completion blocks dependent tasks, creates confusion, generates debt.

**YOUR ROLE**: Final gatekeeper. Every approval reflects system integrity.
</philosophy>

<agent_whitelist>

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY authorized:**
- ✅ `task-completer` - Zero-tolerance quality gatekeeper with comprehensive validation

**FORBIDDEN:**
- ❌ **ANY** agent from global ~/.claude/agents/
- ❌ **ANY** agent from other workflows
- ❌ **ANY** general-purpose agents

**Why This Matters:**
This workflow's task-completer enforces:
- **ALL** acceptance criteria checked (100%, **NO** exceptions)
- **ALL** validation commands pass (0 errors, 0 warnings)
- **Multi-Stage Verification Pipeline** (Phase 3.7):
  - Intelligent selection of verify-* agents (8-12 of 22 total)
  - 5 stages: Syntax → Execution → Security → Quality → Integration
  - Parallel execution within stages, fail-fast between stages
  - Summary return pattern: concise results + full reports to files
  - Audit trail: **ALL** activity logged to `.tasks/audit/` (JSONL)
  - Coverage: security, performance, architecture, complexity, duplication
- **Binary outcome**: Complete (100%) or Incomplete (0%)
- **Fail-fast protocol**: first failure stops validation
- Comprehensive Definition of Done checklist
- Learning extraction with quality bar

This is the **FINAL QUALITY GATE** with 22 specialized verify-* agents. Global agents lack these zero-tolerance standards.
</agent_whitelist>

<purpose>
## Purpose

Delegates completion validation to task-completer agent that:

1. Verifies **ALL** acceptance criteria checked
2. Executes **ALL** validation commands
3. Runs **Multi-Stage Verification Pipeline** (Phase 3.7):
   - **STAGE 1**: verify-syntax, verify-complexity, verify-dependency (**ALWAYS**)
   - **STAGE 2**: verify-execution, verify-business-logic, verify-test-quality (conditional)
   - **STAGE 3**: verify-security, verify-data-privacy (conditional)
   - **STAGE 4**: verify-quality, verify-performance, verify-architecture (conditional)
   - **STAGE 5**: verify-database, verify-integration, verify-regression (conditional)
4. Enforces **Definition of Done** checklist
5. Extracts learnings
6. Archives task atomically
7. Reports unblocked downstream tasks

**Token budget**: ~2,500-3,000 tokens (load + validation + multi-stage verification + archival)

**PubNub summary return pattern** (-50% verification tokens):
- Agents return concise summaries (50-150 tokens)
- Full reports written to `.tasks/reports/` (zero token cost)
- Audit trail logged to `.tasks/audit/` (JSONL)
</purpose>

<agent_invocation>

## Agent Invocation

**MANDATORY**: Use `task-completer` agent via Task tool.

```
Validate completion and archive task: $ARGUMENTS

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).

**Minion Engine Requirements for Validation:**
- **Reliability Labeling MANDATORY**: **ALL** validation assessments **MUST** include confidence scores
- **Evidence-Based Claims**: Attach actual command outputs (**NEVER** claim without proof)
- **Interview Protocol**: Trigger if evidence insufficient or learnings weak
- **Fail-Fast**: First failure with evidence → **STOP** → **REJECT**
- **No Speculation**: "Probably works" = **REJECT**, only 🟢100 [CONFIRMED] accepted

**Your Mission:**
You are the quality gatekeeper. Enforce zero-tolerance completion standards.

**Phase 1: Initial Validation** (~150 tokens)
1. Load .tasks/manifest.json - Verify task status `in_progress`
2. Load .tasks/tasks/$ARGUMENTS-<name>.md - Parse **ALL** sections
3. Extract:
   - **ALL** acceptance criteria (checkboxes)
   - **ALL** validation commands
   - Progress log
   - Documented blockers

**Phase 2: Acceptance Criteria Verification** (~500 tokens)
1. Scan for **ALL** checkboxes: `- [ ]` vs `- [x]`
2. **REQUIREMENT**: **ALL** must be `[x]`, **ZERO** `[ ]` allowed
3. If **ANY** unchecked: **REJECT** immediately
4. Spot-check critical criteria for evidence:
   - Security criteria → verify implementation exists
   - Data integrity criteria → verify tests exist
   - Performance criteria → verify benchmarks met

**Phase 3: Validation Command Execution** (~800 tokens)
1. Extract validation commands from task file
2. Execute **EACH** command sequentially
3. Record: exit code, output, duration
4. **FAIL FAST**: First failure → stop, report, reject
5. **Required pass rate**: 100% (**NO** exceptions)

Validation **MUST** include:
- **Linter**: 0 errors, 0 warnings
- **Tests**: 100% pass rate
- **Build**: Success, 0 warnings
- **Type checker**: 0 errors (if applicable)
- Custom validation from task file

**Phase 4: Definition of Done Checklist** (~300 tokens)
Verify **EVERY** item:

**Code Quality:**
- [ ] **ALL** acceptance criteria checked
- [ ] **NO** TODO/FIXME/HACK comments
- [ ] Code follows project conventions
- [ ] **NO** dead/commented code
- [ ] **NO** debug artifacts

**Testing:**
- [ ] **ALL** tests pass
- [ ] New tests for new functionality
- [ ] Edge cases covered
- [ ] Error handling tested

**Documentation:**
- [ ] Code comments where necessary
- [ ] Function/class docstrings
- [ ] README updated (if applicable)
- [ ] Architecture docs updated (if applicable)

**Integration:**
- [ ] Works with existing components
- [ ] **NO** breaking changes (or documented)
- [ ] Performance acceptable
- [ ] Security reviewed

**Phase 5: Learning Extraction** (~400 tokens)
Extract or prompt for:
1. What worked well
2. What was harder than expected
3. Token usage (estimated vs actual, variance)
4. Recommendations for similar tasks
5. Technical debt created (if any)

**Quality bar**: Learnings **MUST** be specific, honest, quantitative, actionable

**Phase 6: Atomic Completion** (~200 tokens)
If **ALL** checks pass:
1. Create .tasks/updates/agent_task-completer_<timestamp>.json
2. Update manifest: status → `completed`, actual_tokens, completed_at
3. Copy task file to .tasks/completed/ with completion record
4. Update .tasks/metrics.json with completion data

**Phase 7: Dependency Resolution** (~150 tokens)
1. Find tasks that depend on this one
2. Check if their dependencies are now **ALL** complete
3. Report unblocked tasks

```

Use: `subagent_type: "task-completer"`
</agent_invocation>

<output_format>

## Success Format

✅ Task $ARGUMENTS Completed Successfully!

**Summary:**

- **ALL** acceptance criteria met: 🟢100 [CONFIRMED] (<count> criteria, **ALL** checked)
- **ALL** validation commands passed: 🟢100 [CONFIRMED] (<count> commands, exit code 0)
- **Definition of Done** verified: 🟢95 [CONFIRMED] (**ALL** checklist items verified)
- Learnings documented: 🟢90 [CONFIRMED] (substantive, specific, actionable)
- Task archived: 🟢100 [CONFIRMED] (atomic update completed)

**Validation Results (Evidence-Based):**
✓ Linter: 🟢100 [CONFIRMED]
  Command: ruff check .
  Output: All checks passed!
  Exit: 0 | Time: 2025-10-13T14:23:45Z

✓ Tests: 🟢100 [CONFIRMED]
  Command: pytest tests/
  Output: 47 passed, 0 failed
  Exit: 0 | Time: 2025-10-13T14:24:12Z

✓ Build: 🟢100 [CONFIRMED]
  Command: npm run build
  Output: Build succeeded, 0 warnings
  Exit: 0 | Time: 2025-10-13T14:24:45Z

✓ Type Check: 🟢100 [CONFIRMED]
  Command: tsc --noEmit
  Output: No errors
  Exit: 0 | Time: 2025-10-13T14:25:03Z

**Metrics:**
- Estimated tokens: <est>
- Actual tokens: <actual>
- Variance: <percentage>%
- Duration: <minutes> min

**Impact:**
- Progress: <completed>/<total> tasks (<percentage>%)
- Unblocked: <count> tasks now actionable

**Learnings:** [summary]

**Next:** Use /task-next to find next task

## Error Format

❌ Task $ARGUMENTS Completion **REJECTED**

**Reason:** <primary-failure-reason>

**Issues Found:**

- <detailed-issue-1>
- <detailed-issue-2>

**Failed Validation:**
✗ <command>: EXIT <code>
  <error-output>

**Unchecked Criteria:**

- [ ] <criterion-still-unchecked>

**Required Actions:**

1. <fix-step-1>
2. <fix-step-2>
3. Re-run: <validation-commands>
4. Retry /task-complete $ARGUMENTS

Task remains `in_progress`.

## Critical Rules

- **Binary outcome**: Complete (100%) or Incomplete (0%) - **NO** middle ground
- **Zero tolerance**: **ANY** failure = reject entire completion
- **No shortcuts**: "90% done" = incomplete
- **Enforce standards**: Your approval reflects system integrity
- **Fail fast**: First validation failure → stop and report
- **Document everything**: Comprehensive audit trail
</output_format>

<rationale>
## Why Use task-completer Agent

- **Quality Gatekeeper**: Enforces zero-tolerance completion standards
- **Comprehensive Validation**: Runs **ALL** checks automatically
- **Prevents Technical Debt**: Blocks incomplete work from being marked done
- **Consistent Standards**: Same rigorous validation every time
- **Audit Trail**: Complete documentation of verification
- **Dependency Management**: Identifies and reports unblocked tasks
- **Metrics Tracking**: Calculates token usage, variance, updates project metrics
</rationale>

<philosophy_deep_dive>

## Quality Philosophy

**CRITICAL INSIGHT**: Premature completion is worse than no completion.

**WHY THIS MATTERS**:
1. **Blocks downstream work** with broken foundations
2. **Creates confusion** about what's actually done
3. **Generates technical debt** that compounds
4. **Erodes trust** in the task system
5. **Wastes time** in rework and debugging

**THE STANDARD**: Binary outcome only.
- ✅ **100% Complete**: **ALL** criteria met, **ALL** tests pass, production-ready
- ❌ **0% Complete**: Anything less than 100%

**NO PARTIAL CREDIT**:
- "90% done" = **INCOMPLETE**
- "Just this one test failing" = **INCOMPLETE**
- "Will fix linter later" = **INCOMPLETE**
- "Good enough for now" = **INCOMPLETE**

**YOUR MANDATE**: Enforce this standard without compromise.
</philosophy_deep_dive>

<next_steps>

## Next Steps

After completion:
- Use `/task-next` to find next actionable task
- Or review `/task-status` for overall progress
</next_steps>
