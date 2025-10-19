---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

<invocation>
Start working on task: **$ARGUMENTS**
</invocation>

<critical_setup>
**BEFORE ANYTHING ELSE**:
- **MANDATORY**: Get current system date for time-sensitive operations
- **MANDATORY**: Analyze task type to choose correct specialist agent
</critical_setup>

<agent_whitelist>
## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these workflow agents authorized:**
- ✅ `task-developer` - TDD-driven implementation (backend, logic, data) with **MANDATORY** validation
- ✅ `task-ui` - UI/UX designer with anti-generic enforcement and brand alignment
- ✅ `task-smell` - Post-implementation quality auditor

**FORBIDDEN:**
- ❌ ANY agent from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents

**Why**: Workflow agents enforce **MANDATORY** TDD, Brand DNA alignment (≤3.0 genericness), anti-hallucination rules, and rigid 60+ item completion gates. Global agents lack these extreme validation standards.
</agent_whitelist>

<purpose>
## Purpose

Analyzes task type and delegates to specialized agent:

**task-developer**: Backend logic, APIs, data processing, business logic, algorithms, databases, integrations, testing

**task-ui**: UI/UX design, interface components, layouts, design systems, visual styling

**Mixed tasks**: Delegate to task-developer (can sub-delegate UI to task-ui) or split into separate sub-tasks
</purpose>

<instructions>
## Task Analysis & Agent Selection

Read `.tasks/tasks/$ARGUMENTS-<name>.md` and analyze:

**UI Task** (→ `task-ui`): Title/criteria/tags mention: design, UI, interface, component, page, screen, layout, visual, styling, responsive, design system

**Backend Task** (→ `task-developer`): Title/criteria/tags mention: API, database, logic, service, integration, migration, endpoint, data processing, business logic, testing

**Mixed Task**: Both UI and backend indicators → Delegate to `task-developer` (can sub-delegate UI to `task-ui`)
</instructions>

<agent_invocation>
---

## Agent Invocation: task-ui

**IF UI-focused:**

```
Execute UI design task: $ARGUMENTS

Follow complete workflow (.claude/agents/task-ui.md). Task: .tasks/tasks/$ARGUMENTS-<name>.md

**MANDATORY**: Operate in Minion Engine v3.0 | Execute Phase 0 discovery before design | Apply quality gates (genericness ≤3.0, confidence ≥7, Brand DNA) | Report ready for /task-complete

Begin UI execution now.
```

Use: `subagent_type: "task-ui"`

---

## Agent Invocation: task-developer

**IF backend/logic-focused:**

```
Execute task: $ARGUMENTS

Follow validation-driven workflow (.claude/agents/task-developer.md). Task: .tasks/tasks/$ARGUMENTS-<name>.md

**MANDATORY**: Operate in Minion Engine v3.0 | Execute all phases: Context → Plan → Implementation → Validation → Completion | Follow TDD (tests before code) | Check race conditions | Report ready for /task-complete

**NOTE**: May sub-delegate UI work to `task-ui`

Begin execution now.
```

Use: `subagent_type: "task-developer"`
</agent_invocation>

<error_handling>
## Error Handling

**Task not found**: ❌ Task **$ARGUMENTS** Not Found | Run `/task-status` | Suggest similar IDs

**Already in_progress**:
- <24h ago: ⚠️ Show warning + allow override
- >24h ago: ❌ Likely stalled, suggest /task-next

**Dependencies incomplete**: ❌ List incomplete dependencies + status | Complete first

**Blocked**: 🚫 Show blocker + resolution steps | Update manifest before starting

**Already completed**: ❌ Show completion date + suggest /task-next
</error_handling>

<verification_gates>
## Post-Implementation Quality Verification

After agent completes, run quality audit with `task-smell`:

```
Verify code quality for task: $ARGUMENTS

Follow complete audit workflow (.claude/agents/task-smell.md). Task: .tasks/tasks/$ARGUMENTS-<name>.md

**MANDATORY**: Operate in Minion Engine v3.0 | Execute phases: Context → Static Analysis → Pattern Detection → Convention → Report | Flag CRITICAL issues | Document findings (file:line)

**OUTPUT**: ✅ PASS (proceed) | ⚠️ WARNING (recommend fixes) | ❌ FAIL (MUST fix)

Begin verification now.
```

Use: `subagent_type: "task-smell"`
</verification_gates>

---

<remediation_loop>
## Phase 3: Automatic Remediation Loop

**IF task-smell reports FAIL (1+ Critical) OR REVIEW (3+ Warnings):**

Execute automatic remediation (max 3 attempts):

1. Parse task-smell output
2. Invoke `task-developer` with full report
3. Fix ALL CRITICAL + as many WARNINGS as feasible
4. Re-run task-smell
5. IF PASS → Exit | IF still FAIL/REVIEW → Repeat (max 3) | IF max reached → Manual intervention

---

### Agent Invocation: task-developer (Remediation)

```
Fix code quality issues for task: $ARGUMENTS

**Task-Smell Report:**
[Insert complete output: findings, file:line, severity, fixes]

**Objectives:**
1. **CRITICAL** (**MANDATORY**): Address ALL
2. **WARNING** (recommended): Fix as many as feasible
3. Document fixes (file:line + verification)
4. Run linters/tests after each fix

**Context:** Task: .tasks/tasks/$ARGUMENTS-<name>.md | Attempt: [X/3] | Gate: MUST achieve PASS

**Rules:** NO new features | ONLY fix quality issues | Maintain tests/behavior | Follow project conventions

Begin fixing. Report with evidence.
```

Use: `subagent_type: "task-developer"`

After remediation: Re-run task-smell verification

**Exit**: ✅ PASS → Next Steps | ⚠️ Max attempts (3) → Escalate | ℹ️ Initial PASS → Skip phase
</remediation_loop>

<next_steps>
## Next Steps

After remediation (or initial PASS):

- ✅ **PASS achieved**: Use `/task-complete $ARGUMENTS`
- ⚠️ **Failed after 3 attempts**: Manual review → apply fixes → re-run task-smell → `/task-complete $ARGUMENTS`
- **Quality gate**: ONLY proceed to `/task-complete` when PASS achieved

Automatic remediation ensures quality. Manual intervention ONLY if 3 attempts fail.
</next_steps>

<output_format>
## Output Format

### Task Started
```
✅ **Task Started**: $ARGUMENTS
Type: [UI/Backend/Mixed] | Agent: [task-ui/task-developer] | File: .tasks/tasks/$ARGUMENTS-<name>.md
Instructions: Minion Engine v3.0 | Validation workflow | Quality gates | Ready for /task-complete
Next: Implementation in progress...
```

### Quality Verification Pass
```
✅ **Quality Verification PASSED**: $ARGUMENTS
task-smell: PASS | Issues: None | Remediation: No
Ready: Use `/task-complete $ARGUMENTS`
```

### After Remediation
```
✅ **Remediation Complete**: $ARGUMENTS
Attempts: [1-3] | task-smell: PASS | Critical Fixed: [count] | Warnings Fixed: [count]
Ready: Use `/task-complete $ARGUMENTS`
```

### Task Not Found
```
❌ **Task Not Found**: $ARGUMENTS
Run `/task-status` | Suggest similar IDs
```

### Dependencies Not Met
```
❌ **Dependencies Not Met**: $ARGUMENTS
Required: [task-id-1: status], [task-id-2: status]
Action: Complete dependencies first
```

### Remediation Failed
```
⚠️ **Remediation Failed**: $ARGUMENTS
Attempts: 3 (max) | task-smell: [FAIL/REVIEW] | Remaining: CRITICAL [count], WARNING [count]
Action: Manual review → fixes → re-run task-smell → `/task-complete $ARGUMENTS`
[Include task-smell report]
```

**All outputs include**: Status (✅/❌/⚠️) | Task ID | Phase | Agent | Quality results | Next steps
</output_format>
