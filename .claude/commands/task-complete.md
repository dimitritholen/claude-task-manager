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
- **Directory Setup**: Ensure `.tasks/reports/` and `.tasks/audit/` exist
</critical_setup>

<philosophy>
**BINARY OUTCOME**: Complete (100%) or Incomplete (0%) — **NO MIDDLE GROUND**

**QUALITY GATE**: Premature completion blocks dependent tasks, creates confusion, generates debt.

**YOUR ROLE**: Final gatekeeper orchestrating multi-stage verification. Every approval reflects system integrity.
</philosophy>

<agent_whitelist>

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY authorized:**

- ✅ `verify-*` - 22 specialized verification agents (syntax, security, performance, etc.)
- ✅ `task-completer` - Zero-tolerance quality gatekeeper for final validation

**FORBIDDEN:**

- ❌ **ANY** agent from global ~/.claude/agents/
- ❌ **ANY** agent from other workflows
- ❌ **ANY** general-purpose agents

**Why This Matters:**
This workflow enforces:

- **Multi-Stage Verification Pipeline**: 5 stages with fail-fast execution
- **Intelligent Agent Selection**: 8-12 of 22 verify-* agents based on task analysis
- **Parallel Execution**: Agents run concurrently within each stage
- **Summary Return Pattern**: Concise results (50-150 tokens) + full reports to files
- **Audit Trail**: ALL activity logged to `.tasks/audit/` (JSONL)
- **Zero-Tolerance**: ANY BLOCK = immediate rejection

This is the **FINAL QUALITY GATE** with 22 specialized verify-* agents. Global agents lack these zero-tolerance standards.
</agent_whitelist>

<workflow>
## Complete Workflow

This command orchestrates the multi-stage verification pipeline:

**Phase 0: Setup**

- Get current date
- Create `.tasks/reports/` and `.tasks/audit/` directories
- Load task file

**Phase 1: Task Analysis**

- Extract task metadata (type, files, keywords)
- Read project context
- Determine task characteristics

**Phase 2: Intelligent Agent Selection**

- Apply decision matrix
- Select 8-12 of 22 verify-* agents
- Assign to 5 stages

**Phase 3: Multi-Stage Verification**

- Execute 5 stages sequentially
- Run agents in parallel within each stage
- Fail-fast between stages
- Collect summaries

**Phase 4: Result Aggregation**

- Calculate quality score
- Group issues by severity
- Generate verification summary

**Phase 5: Final Validation**

- IF verification PASS → Launch task-completer agent
- IF verification BLOCK → Reject immediately

**Token budget**: ~2,500-3,000 tokens (analysis + verification + final validation)
</workflow>

<instructions>

## Phase 0: Setup

**Get current date:**

```bash
date -I
```

**Create directories:**

```bash
mkdir -p .tasks/reports .tasks/audit
```

**Load task file:**

```bash
# Find task file
task_file=$(find .tasks/tasks -name "$ARGUMENTS-*.md" | head -1)

# Verify exists
test -f "$task_file" || echo "ERROR: Task $ARGUMENTS not found"
```

---

## Phase 1: Task Analysis

**Read task file** and extract:

1. **Task metadata:**
   - Title
   - Description
   - Tags
   - Type (backend/frontend/database/etc.)

2. **Acceptance criteria:**
   - Count checkboxes: `- \[([ x])\]`
   - Extract keywords (auth, security, performance, database, etc.)

3. **Modified files** (from progress log):
   - Count files
   - Identify locations (controllers/services/models/tests)
   - Detect languages/frameworks

4. **Project context:**
   - Read `.tasks/context/architecture.md` (if exists)
   - Read `.tasks/ecosystem-guidelines.json` (if exists)

**Output:** Task analysis summary for agent selection

---

## Phase 2: Intelligent Agent Selection

**Decision Matrix:**

### STAGE 1 - Fast Checks (ALWAYS)

Run these **ALWAYS** (~30s):

- `verify-syntax` - Compilation, imports, build
- `verify-complexity` - File size, cyclomatic complexity
- `verify-dependency` - Hallucinated packages, version conflicts

### STAGE 2 - Execution & Logic (Conditional)

**ALWAYS:**

- `verify-execution` - Tests actually run

**CONDITIONAL:**

- `verify-business-logic` - IF keywords: calculate, discount, pricing, rule, formula, algorithm
- `verify-test-quality` - IF test files present

### STAGE 3 - Security (Conditional)

Run if ANY keyword matches:

- `verify-security` - IF keywords: auth, password, JWT, token, API, secure, credential, session
- `verify-data-privacy` - IF keywords: PII, GDPR, personal, privacy, data protection, user data

### STAGE 4 - Quality & Architecture (Conditional)

**ALWAYS:**

- `verify-quality` - Code smells, SOLID principles

**CONDITIONAL:**

- `verify-performance` - IF keywords: optimize, cache, query, performance, slow, latency, N+1
- `verify-architecture` - IF new services OR >5 files modified OR keywords: architecture, design pattern, refactor
- `verify-maintainability` - IF complexity >8 OR keywords: refactor, technical debt
- `verify-error-handling` - IF keywords: error, exception, try-catch, handling
- `verify-documentation` - IF API changes OR keywords: API, endpoint, breaking change
- `verify-duplication` - IF >3 files in same module

### STAGE 5 - Integration & Deployment (Conditional)

- `verify-database` - IF keywords: migration, schema, SQL, database, ALTER TABLE
- `verify-integration` - IF keywords: E2E, integration, service, microservice
- `verify-regression` - IF files modified in existing modules (not new features)
- `verify-production` - IF keywords: deploy, infrastructure, docker, kubernetes, production

### Additional Specialized Agents (Rare)

- `verify-compliance` - IF keywords: GDPR, HIPAA, PCI-DSS, compliance, regulatory
- `verify-localization` - IF keywords: i18n, l10n, translation, locale
- `verify-debt` - IF keywords: technical debt, refactoring, cleanup

**Selection Algorithm:**

```python
selected_agents = {
    "stage1": ["verify-syntax", "verify-complexity", "verify-dependency"],  # ALWAYS
    "stage2": ["verify-execution"],  # ALWAYS
    "stage3": [],
    "stage4": ["verify-quality"],  # ALWAYS
    "stage5": []
}

# Add conditional agents based on keywords
keywords_lower = " ".join([title, description, criteria]).lower()

# Security
if any(kw in keywords_lower for kw in ["auth", "password", "jwt", "token", "api", "secure"]):
    selected_agents["stage3"].append("verify-security")
if any(kw in keywords_lower for kw in ["pii", "gdpr", "personal", "privacy", "user data"]):
    selected_agents["stage3"].append("verify-data-privacy")

# Quality/Architecture
if any(kw in keywords_lower for kw in ["optimize", "cache", "performance", "slow"]):
    selected_agents["stage4"].append("verify-performance")
if file_count > 5 or any(kw in keywords_lower for kw in ["architecture", "refactor"]):
    selected_agents["stage4"].append("verify-architecture")
if any(kw in keywords_lower for kw in ["error", "exception", "handling"]):
    selected_agents["stage4"].append("verify-error-handling")
if any(kw in keywords_lower for kw in ["api", "endpoint", "breaking"]):
    selected_agents["stage4"].append("verify-documentation")

# Integration/Deployment
if any(kw in keywords_lower for kw in ["migration", "schema", "sql", "database"]):
    selected_agents["stage5"].append("verify-database")
if any(kw in keywords_lower for kw in ["e2e", "integration", "service"]):
    selected_agents["stage5"].append("verify-integration")
if modifying_existing_files:
    selected_agents["stage5"].append("verify-regression")

# Business Logic
if any(kw in keywords_lower for kw in ["calculate", "discount", "pricing", "formula"]):
    selected_agents["stage2"].append("verify-business-logic")
if test_files_present:
    selected_agents["stage2"].append("verify-test-quality")
```

**Output:** Display selected agents by stage (8-12 total expected)

---

## Phase 3: Multi-Stage Verification

**Execute 5 stages sequentially with fail-fast:**

### Stage Execution Pattern

For each stage (1-5):

1. **Check if stage has agents** - If empty, skip

2. **Launch agents in parallel** using Task tool:

```markdown
FOR EACH agent in stage:
  Launch via Task tool with prompt:

  """
  Analyze task $ARGUMENTS for [syntax/security/performance/etc.] verification.

  **MANDATORY OUTPUT FORMAT:**
  Decision: PASS | BLOCK | WARN
  Score: X/100
  Critical Issues: N
  Issues:
  - [CRITICAL|HIGH|MEDIUM|LOW] file:line - description

  **Report File:** Write full analysis to .tasks/reports/{agent-name}-$ARGUMENTS.md
  **Audit Entry:** Append to .tasks/audit/{date}.jsonl:
  {"timestamp":"ISO-8601","agent":"{agent-name}","task_id":"$ARGUMENTS","stage":N,"result":"PASS|BLOCK|WARN","score":X,"duration_ms":Y,"issues":Z}

  Keep your response to 50-150 tokens. Put ALL details in the report file.
  """

  Use: subagent_type: "{agent-name}"
```

3. **Wait for ALL agents in stage to complete**

4. **Parse results:**
   - Extract Decision (PASS/BLOCK/WARN)
   - Extract Score (0-100)
   - Extract Critical Issues count
   - Verify report file created
   - Verify audit entry appended

5. **Fail-Fast Logic:**

```
IF any agent returns BLOCK:
  Stop immediately
  Skip remaining stages
  Collect all BLOCK/WARN/PASS results from completed stages
  Jump to Phase 4 (Result Aggregation) with FAILURE
ELSE:
  All PASS or WARN → Continue to next stage
```

6. **Stage Progress Display:**

```
[STAGE N] {Stage Name} ({agent_count} agents, ~{time}s)
├─ {agent1}: {PASS/BLOCK/WARN} {icon} (score: {score})
├─ {agent2}: {PASS/BLOCK/WARN} {icon} (score: {score})
└─ {agent3}: {PASS/BLOCK/WARN} {icon} (score: {score})
Stage N: {✓ ALL PASS | ✗ BLOCKED | ⚠ WARNINGS}
```

### Execution Example

```
[STAGE 1] Fast Checks (3 agents, ~30s)
├─ verify-syntax: PASS ✓ (score: 100)
├─ verify-complexity: PASS ✓ (score: 95)
└─ verify-dependency: PASS ✓ (score: 100)
Stage 1: ✓ ALL PASS

[STAGE 2] Execution & Logic (3 agents, ~60s)
├─ verify-execution: PASS ✓ (score: 100)
├─ verify-business-logic: PASS ✓ (score: 92)
└─ verify-test-quality: PASS ✓ (score: 88)
Stage 2: ✓ ALL PASS

[STAGE 3] Security (2 agents, ~90s)
├─ verify-security: BLOCK ✗ (score: 34)
│  ├─ [CRITICAL] SQL injection (auth.py:42)
│  └─ [CRITICAL] Hardcoded secret (config.py:7)
└─ verify-data-privacy: (skipped - fail fast)

❌ VERIFICATION FAILED - Stopping at Stage 3
```

---

## Phase 4: Result Aggregation

**Collect verification results:**

1. **Calculate quality score:**
   - Weighted average of all agent scores
   - STAGE 1 weight: 15%
   - STAGE 2 weight: 25%
   - STAGE 3 weight: 25%
   - STAGE 4 weight: 25%
   - STAGE 5 weight: 10%

2. **Group issues by severity:**
   - CRITICAL: Blocking issues (security, data loss, crashes)
   - HIGH: Major issues (performance, bugs, violations)
   - MEDIUM: Moderate issues (code smells, warnings)
   - LOW: Minor issues (style, suggestions)

3. **Identify blocking conditions:**
   - Any CRITICAL issues → BLOCK
   - Quality score <60 → BLOCK
   - Any agent returned BLOCK → BLOCK

4. **Generate verification summary:**

```json
{
  "verification_summary": {
    "outcome": "PASS" | "BLOCK",
    "stages_completed": "X/5",
    "agents_run": N,
    "quality_score": X,
    "total_duration_ms": Y,
    "issues": {
      "critical": N,
      "high": N,
      "medium": N,
      "low": N
    },
    "blocking_agent": "agent-name" | null,
    "blocking_stage": N | null,
    "reports_dir": ".tasks/reports/",
    "audit_file": ".tasks/audit/{date}.jsonl"
  }
}
```

---

## Phase 5: Final Validation

**Decision Logic:**

### IF Verification BLOCKED

**Display failure report:**

```
❌ VERIFICATION FAILED - Task Completion BLOCKED

Blocking Agent: {agent-name}
Stage: {N}/5 ({stage-name})
Quality Score: {score}/100 (CRITICAL)

Critical Issues ({count}):
1. {severity} {description}
   File: {file}:{line}
   Fix: {recommendation}

Reports: .tasks/reports/
Audit: .tasks/audit/{date}.jsonl

Required Actions:
1. Fix critical issues listed above
2. Address all BLOCK conditions
3. Re-run: /task-complete $ARGUMENTS

Task remains in_progress.
```

**Exit without launching task-completer**

### IF Verification PASSED

**Launch task-completer agent:**

```markdown
Validate completion and archive task: $ARGUMENTS

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).

**Verification Results (PASSED):**
{verification_summary JSON}

**Your Mission:**
Multi-stage verification PASSED. Now perform final validation:

**Phase 1: Acceptance Criteria Verification**
1. Load .tasks/tasks/$ARGUMENTS-<name>.md
2. Scan for ALL checkboxes: `- [ ]` vs `- [x]`
3. REQUIREMENT: ALL must be `[x]`, ZERO `[ ]` allowed
4. If ANY unchecked: REJECT immediately

**Phase 2: Validation Command Execution**
1. Extract validation commands from task file
2. Execute EACH command sequentially
3. Record: exit code, output, duration
4. FAIL FAST: First failure → stop, report, reject
5. Required: linter (0 errors), tests (100% pass), build (success), type check (0 errors)

**Phase 3: Quality Metrics Verification**
1. Load .tasks/ecosystem-guidelines.json (quality baselines)
2. Measure: file size, function complexity, function length, class length, duplication
3. Compare against thresholds
4. Verify SOLID compliance, YAGNI compliance
5. If ANY violation: REJECT

**Phase 4: Definition of Done Checklist**
Verify ALL items:
- Code Quality: No TODOs, no dead code, follows conventions
- Testing: All tests pass, edge cases covered
- Documentation: Comments, docstrings, README updated
- Integration: Works with existing, no breaking changes
- Progress Log: Complete history, decisions documented

**Phase 5: Learning Extraction**
Extract:
1. What worked well
2. What was harder than expected
3. Token usage (estimated vs actual)
4. Recommendations
5. Technical debt created
Quality bar: Specific, honest, quantitative, actionable

**Phase 6: Atomic Completion**
If ALL checks pass:
1. Create .tasks/updates/agent_task-completer_{timestamp}.json
2. Update manifest: status=completed, actual_tokens, completed_at
3. Copy to .tasks/completed/
4. Update .tasks/metrics.json

**Phase 7: Dependency Resolution**
1. Find tasks depending on this one
2. Check if dependencies now complete
3. Report unblocked tasks

**Output Format:**
Include verification summary in final report.

Use: subagent_type: "task-completer"
```

**Display combined results from verification + task-completer**

</instructions>

<output_format>

## Success Format

```
✅ Task $ARGUMENTS Completed Successfully!

**Verification Summary:**
- Stages Completed: 5/5
- Agents Run: 12
- Quality Score: 87/100
- Total Duration: 6m 23s
- Issues: 0 critical, 0 high, 2 medium, 5 low

**Validation Summary:**
- ALL acceptance criteria met: 🟢100 [CONFIRMED] (X criteria)
- ALL validation commands passed: 🟢100 [CONFIRMED] (X commands)
- Quality metrics verified: 🟢95 [CONFIRMED]
- Definition of Done verified: 🟢95 [CONFIRMED]
- Learnings documented: 🟢90 [CONFIRMED]
- Task archived: 🟢100 [CONFIRMED]

**Validation Results (Evidence-Based):**
✓ Linter: 🟢100 [CONFIRMED]
  Command: {command}
  Output: {output}
  Exit: 0 | Time: {timestamp}

✓ Tests: 🟢100 [CONFIRMED]
  Command: {command}
  Output: {output}
  Exit: 0 | Time: {timestamp}

**Reports:** .tasks/reports/
**Audit:** .tasks/audit/{date}.jsonl

**Metrics:**
- Estimated tokens: {est}
- Actual tokens: {actual}
- Variance: {percentage}%
- Duration: {minutes} min

**Impact:**
- Progress: {completed}/{total} tasks ({percentage}%)
- Unblocked: {count} tasks now actionable

**Learnings:** {summary}

**Next:** Use /task-next to find next task
```

## Verification Failure Format

```
❌ VERIFICATION FAILED - Task Completion BLOCKED

**Analysis:**
Task Type: {type}
Modified Files: {count}
Keywords: {keywords}
Selected Agents: {count} of 22

**Verification Results:**
Stages Completed: {N}/5
Agents Run: {count}
Quality Score: {score}/100 (CRITICAL)

Blocking Agent: {agent-name}
Blocking Stage: {N}/5 ({stage-name})

**Stage Results:**
[STAGE 1] Fast Checks: ✓ PASS (3 agents, 28s)
[STAGE 2] Execution & Logic: ✓ PASS (3 agents, 62s)
[STAGE 3] Security: ✗ BLOCKED (1/2 agents, 47s)
[STAGE 4] (skipped - fail fast)
[STAGE 5] (skipped - fail fast)

**Critical Issues ({count}):**
1. [CRITICAL] {description}
   File: {file}:{line}
   Code: {snippet}
   Fix: {recommendation}

2. [CRITICAL] {description}
   File: {file}:{line}
   Fix: {recommendation}

**Reports:** .tasks/reports/{agent-name}-$ARGUMENTS.md
**Audit:** .tasks/audit/{date}.jsonl

**Required Actions:**
1. {specific-fix-with-file-line}
2. {specific-fix-with-file-line}
3. Re-run verification: /task-complete $ARGUMENTS

Task remains in_progress.
```

## Final Validation Failure Format

```
❌ Task $ARGUMENTS Completion REJECTED

**Verification:** ✓ PASSED (all agents)
**Validation:** ✗ FAILED (task-completer rejection)

**Reason:** {primary-failure-reason}

**Issues Found:**
- {detailed-issue-1}
- {detailed-issue-2}

**Failed Validation:**
✗ {command}: EXIT {code}
  {error-output}

**Unchecked Criteria:**
- [ ] {criterion-still-unchecked}

**Required Actions:**
1. {fix-step-1}
2. {fix-step-2}
3. Re-run: {validation-commands}
4. Retry /task-complete $ARGUMENTS

Task remains in_progress.
```

## Critical Rules

- **Binary outcome**: Complete (100%) or Incomplete (0%) - NO middle ground
- **Zero tolerance**: ANY failure = reject entire completion
- **Fail fast**: First BLOCK → stop verification immediately
- **Evidence required**: ALL claims need command outputs or file references
- **Summary return**: Agents return 50-150 tokens, write full reports to files
- **Audit trail**: ALL verification logged to .tasks/audit/{date}.jsonl
- **Parallel execution**: Run agents concurrently within each stage
- **Sequential stages**: Complete one stage before starting next
- **Intelligent selection**: 8-12 of 22 agents based on task analysis

</output_format>

<rationale>
## Why Multi-Stage Verification in Command

**Command vs Agent Responsibilities:**

**Command (has Task tool):**

- Orchestrates multi-stage verification
- Launches verify-* agents in parallel
- Collects and aggregates results
- Makes fail-fast decisions
- Launches task-completer for final validation

**task-completer Agent (lacks Task tool):**

- Verifies acceptance criteria
- Runs validation commands
- Checks quality metrics
- Validates Definition of Done
- Extracts learnings
- Performs atomic archival

**Benefits:**

- **Comprehensive**: 22 specialized verify-* agents catch production issues
- **Efficient**: Parallel execution within stages (~6min vs ~30min sequential)
- **Smart**: Intelligent selection (8-12 agents) based on task analysis
- **Fast**: Fail-fast between stages saves time on early failures
- **Token-efficient**: Summary return pattern (~1200 tokens vs ~6000 tokens)
- **Traceable**: Complete audit trail in JSONL format
- **Actionable**: File:line specifics with fix recommendations
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

- ✅ **100% Complete**: ALL criteria met, ALL tests pass, ALL verification passes, production-ready
- ❌ **0% Complete**: Anything less than 100%

**NO PARTIAL CREDIT**:

- "Verification passed but one criteria unchecked" = **INCOMPLETE**
- "Tests pass but linter failed" = **INCOMPLETE**
- "Everything works but has security issue" = **INCOMPLETE**
- "Good enough for now" = **INCOMPLETE**

**YOUR MANDATE**: Enforce this standard without compromise through multi-stage verification.
</philosophy_deep_dive>

<next_steps>

## Next Steps

After completion:

- Use `/task-next` to find next actionable task
- Or review `/task-status` for overall progress
</next_steps>
