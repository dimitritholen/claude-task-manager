---
allowed-tools: Read, Write, Task
argument-hint: [task-id]
description: Claim task and load full context to begin work
---

Start working on task: $ARGUMENTS

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-executor` - TDD-driven implementation specialist with mandatory validation (backend, logic, data)
- ✅ `task-ui` - Expert UI/UX designer with anti-generic enforcement and brand alignment (UI, design, interface)

**FORBIDDEN:**

- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents (developer, coder, frontend-developer, etc.)

**Why This Matters:**

**task-executor** enforces:
- Mandatory TDD (tests before code, always)
- Anti-hallucination rules (verify everything)
- Iteration mandate until proven correct
- Meaningful tests (realistic inputs, green+red+edge paths)
- Rigid 60+ item completion gate

**task-ui** enforces:
- Mandatory Brand DNA alignment (every decision justified)
- Anti-generic enforcement (genericness test ≤3.0 required)
- Design system consistency (create once, reuse everywhere)
- Sophisticated design choices (no junior/template patterns)
- Rigid quality gates (11 anti-patterns, accessibility, pre-delivery audit)

Global agents do NOT follow these extreme validation standards.

## Purpose

This command analyzes the task type and delegates to the appropriate specialized agent:

**task-executor** for:
- Backend logic, APIs, data processing
- Business logic, algorithms
- Database operations, migrations
- System integrations
- Testing infrastructure

**task-ui** for:
- UI/UX design and implementation
- Interface components
- Page layouts, screens
- Design systems
- Visual design, styling

**Mixed tasks** (both backend and UI):
- Delegate to task-executor which can sub-delegate UI portions to task-ui
- Or split into separate UI and backend sub-tasks

Token budget: ~1,700 tokens startup, variable implementation

## Task Analysis & Agent Selection

**Step 1: Load and Analyze Task**

Read `.tasks/tasks/$ARGUMENTS-<name>.md` and analyze:

**UI Task Indicators** (delegate to `task-ui`):
- Title contains: "design", "UI", "interface", "component", "page", "screen", "layout", "visual", "styling"
- Acceptance criteria mention: "user interface", "design system", "visual design", "layout", "responsive", "styling"
- Description focuses on: UI/UX, visual design, interface creation, component design
- Tags include: "ui", "design", "interface", "frontend-ui"

**Backend Task Indicators** (delegate to `task-executor`):
- Title contains: "API", "database", "logic", "service", "integration", "migration"
- Acceptance criteria mention: "endpoint", "data processing", "business logic", "database", "testing"
- Description focuses on: backend logic, data operations, API development, system integration
- Tags include: "backend", "api", "database", "logic", "testing"

**Mixed Task Indicators**:
- Both UI and backend indicators present
- Action: Delegate to `task-executor` with note to sub-delegate UI work to `task-ui` if needed

**Step 2: Select Agent**

Based on analysis above, choose appropriate agent and proceed with invocation.

---

## Agent Invocation: task-ui

**IF task is UI-focused, use `task-ui` agent:**

```
Execute UI design task: $ARGUMENTS

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Use Conditional Interview Protocol if design requirements vague
- Apply Reliability Labeling to all design decisions
- Apply Anti-Generic Enforcement (genericness test ≤3.0 required)
- Never skip Brand DNA analysis or quality gates

**Your Mission:**
Design and implement sophisticated, brand-specific UI following rigorous design workflow.

**Phase 0: Design System Discovery**
1. Check if .tasks/design-system/system.json exists
2. IF NO (first UI task):
   - Extract Brand DNA from context/project.md (6 sections)
   - Research current design trends (WebSearch with date filters)
   - Create comprehensive design system (colors, typography, spacing, effects, layout, components)
   - Save to .tasks/design-system/ directory
3. IF YES (subsequent UI tasks):
   - Load existing design system
   - Apply consistently without deviation
   - Reference brand-dna.md for all decisions

**Phase 1: Context Loading & Task Analysis**
1. Read .tasks/manifest.json - Verify task exists, is pending, dependencies met
2. Create atomic claim update in .tasks/updates/agent_<id>_<timestamp>.json
3. Update manifest status to `in_progress`
4. Load full task file from .tasks/tasks/$ARGUMENTS-<name>.md
5. Load project context:
   - context/project.md (brand, values, audience)
   - context/architecture.md (tech stack for implementation)
6. Analyze page type requirements (landing/blog/product/dashboard/form/pricing/component)

**Phase 2: Concept Generation**
1. Generate EXACTLY 3 distinct design concepts
2. Concepts must differ in ≥4 dimensions (layout, color, typography, density, motion, style)
3. Map each concept to Brand DNA attributes
4. Reference trend research strategically
5. Score concept similarity (all pairs must be <4)
6. Justify why each is NOT generic

**Phase 3: Concept Selection**
1. Score all concepts (Brand DNA, trends, non-generic, page fit, distinctive, feasible)
2. Create decision matrix
3. Select highest-scoring concept
4. Write 4-5 sentence justification with Brand DNA and trend references

**Phase 4: Design Specification**
1. Verify all 11 anti-patterns avoided (centered hero, 3-col grid, lorem ipsum, etc.)
2. Specify layout structure with Brand DNA connections
3. Apply design system colors/typography consistently
4. Design component inventory with signature elements
5. Define responsive strategy (mobile, tablet, desktop)

**Phase 5: Genericness Test (MANDATORY)**
1. Score 15 generic indicators (1-10 each)
2. Calculate genericness score (sum ÷ 15)
3. MUST be ≤3.0 to proceed
4. IF >3.0: Redesign highest-scoring elements

**Phase 6: Code Implementation**
1. Generate complete, functional code (HTML/React/Vue + Tailwind/CSS)
2. No placeholders or truncation
3. Semantic HTML5 with accessibility (WCAG AA)
4. All interaction states (hover, active, focus, disabled)
5. Responsive across breakpoints
6. Brand-appropriate content (no Lorem ipsum)

**Phase 7: Pre-Delivery Audit (MANDATORY)**
1. Answer 10 self-critique questions honestly
2. Map all design decisions to Brand DNA
3. Identify signature elements
4. Re-score top 5 generic indicators
5. Confidence score must be ≥7
6. IF <7: Improve problem areas

**Phase 8: Completion Preparation**
1. Update task file with checked acceptance criteria
2. Document design system applied, implementation notes, accessibility compliance
3. Record quality scores (genericness, confidence, Brand DNA alignment)
4. Document learnings and recommendations
5. Report ready for completion verification
6. DO NOT call /task-complete yourself

**Expected Output:**
🎨 Starting UI Design Task: $ARGUMENTS

[Design system status: loaded/created]
[Brand DNA analysis complete]
[Trend research findings]
[3 concepts generated and scored]
[Concept selected with justification]
[Design specification with anti-pattern verification]
[Genericness Test: X/10 ✅ PASS]
[Code implementation complete]
[Pre-Delivery Audit: Confidence Y/10 ✅ PASS]

✅ Ready for Completion:
- All acceptance criteria: ✓
- Design system applied: ✓
- Genericness test passed (≤3.0): ✓
- Pre-delivery audit passed (≥7): ✓
- Brand DNA alignment verified: ✓
- Documentation complete: ✓

Request /task-complete $ARGUMENTS to finalize.

**Critical Rules:**
- NEVER skip Brand DNA analysis (Phase 0)
- NEVER skip Genericness Test (must be ≤3.0)
- NEVER skip Pre-Delivery Audit (confidence ≥7)
- NEVER produce generic/template-like designs
- ALWAYS connect decisions to Brand DNA
- ALWAYS apply design system consistently
- Quality over speed - sophisticated designs take time

**Race Condition Handling:**
[Same as task-executor - check manifest, avoid claiming if in progress]

Begin UI design execution now.
```

Use: `subagent_type: "task-ui"`

---

## Agent Invocation: task-executor

**IF task is backend/logic-focused, use `task-executor` agent:**

```
Execute task: $ARGUMENTS

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Use Conditional Interview Protocol if acceptance criteria vague
- Apply Reliability Labeling to all technical claims
- Never invent API signatures or configuration - verify in source

**NOTE**: If this task includes UI work, you may sub-delegate to `task-ui` agent for design portions

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

---

## Why Use Specialized Agents

**task-executor Agent:**
- **Specialized Expertise**: Validation-driven development with TDD
- **Full Context Awareness**: Loads and maintains all relevant context
- **Quality Focused**: Enforces continuous validation and testing
- **Progress Tracking**: Systematic logging and documentation
- **Prevents Shortcuts**: All acceptance criteria met before completion
- **Token Efficient**: Loads only needed context (~1,650 tokens)

**task-ui Agent:**
- **Design Expertise**: 10+ years equivalent UI/UX design experience
- **Brand Alignment**: Mandatory Brand DNA analysis and application
- **Anti-Generic Enforcement**: Genericness test ≤3.0 required
- **Design System**: Creates reusable system on first run, applies consistently
- **Quality Gates**: 11 anti-patterns checked, accessibility required, pre-delivery audit
- **Research-Backed**: Trend research with strategic synthesis, not blind following

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
