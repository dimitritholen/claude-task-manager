---
allowed-tools: Task
description: Initialize token-efficient task management system in current project
---

<invocation>
**Command**: `/task-init`

Initializes the task management system for this project with **FULL AUTOMATION**.
</invocation>

<critical_setup>
**MANDATORY**: Before starting ANY work:

1. Get today's date: `date`
2. Verify project root directory
3. Check for existing `.tasks/` directory
</critical_setup>

<purpose>
Initialize the task management system for this project with **FULL AUTOMATION**.

**GUARANTEED OUTCOME**: Working task system regardless of documentation quality or project state.

**UNIVERSAL COMPATIBILITY**: Works with ANY project, ANY language, ANY documentation state.

**NO FAILURE MODE**: Adapts to what exists, creates what's missing, never gives up.
</purpose>

<system_structure>

## System Structure

Creates `.tasks/` directory structure with:

- **Project context** (vision, architecture)
- **Initial tasks** from requirements
- **Validation commands**
- **Token-efficient manifest**

Works with ANY project, any language, any documentation state.
</system_structure>

<agent_whitelist>

## MANDATORY Agent Whitelist

**ONLY** this agent is authorized:

- `task-initializer` - Full initialization specialist
</agent_whitelist>

<agent_invocation>

## Agent Invocation

Delegates all initialization to `task-initializer` agent:

```
Initialize task management system for this project.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](..core/minion-engine.md).
- Use Conditional Interview Protocol if project structure ambiguous
- Apply Reliability Labeling to all discoveries
- **NEVER** invent file paths or configurations

**Your Mission:**
1. Discover project type and structure
2. Find and parse documentation (requirements, architecture, tests)
3. Extract context into structured files
4. Generate initial tasks from requirements
5. Create complete .tasks/ directory structure
6. Validate setup
```

</agent_invocation>

<interview_protocol>

## Interview Protocol

**TRIGGERS** (use Conditional Interview Protocol when detected):

- Multiple languages detected (Python + TypeScript + Rust)
- No clear primary documentation (multiple READMEs, no PRD)
- Ambiguous project structure (monorepo? microservices? single app?)
- Multiple test frameworks found

**If triggered, ask:**

```markdown
🔍 **Project Structure Clarification**

I detected complexity requiring clarification:

**Question 1: Primary Language**
Found: Python, TypeScript, Rust
Which is primary for task management?
  - [ ] Python
  - [ ] TypeScript
  - [ ] Rust
  - [ ] Other: ___

**Question 2: Documentation**
Found multiple docs. Which contains requirements?
  - [ ] README.md
  - [ ] docs/PRD.md
  - [ ] SPEC.md
  - [ ] Other: ___

**Question 3: Project Type**
  - [ ] Monorepo (multiple projects)
  - [ ] Microservices
  - [ ] Single application
  - [ ] Library/Package
```

</interview_protocol>

<output_format>

## Output Format

### Success Format

Comprehensive initialization report with:

**Project Discovery**

- Project type detected
- Primary language
- Documentation found
- Validation strategy detected

**Files Created**

- Context files (with token counts)
- Tasks generated (with dependency graph)
- Manifest and metrics

**Quality Metrics**

- Token efficiency metrics
- Coverage analysis

**Next Steps**

- Recommended first task
- Validation commands

### Success Criteria (ALL MUST PASS)

- ✓ All directories created
- ✓ `manifest.json` valid
- ✓ At least one task file
- ✓ Context files complete
- ✓ Validation commands discovered
- ✓ `metrics.json` initialized
- ✓ Post-init validation passes
</output_format>

<error_handling>

## Error Handling

**If `.tasks/` already exists:**

- Agent will prompt for: **Reinitialize** | **Migrate** | **Abort**

**If minimal documentation found:**

- Agent will create basic structure
- Suggest documentation tasks

**If project type unclear:**

- Agent will ask for clarification
- Or create generic structure
</error_handling>

<next_steps>

## Post-Initialization

After agent completes initialization:

1. **Check status**: `/task-status`
2. **Find first task**: `/task-next`
3. **Start work**: `/task-start T001`
</next_steps>
