---
allowed-tools: Task
description: Initialize token-efficient task management system in current project
---

Initialize the task management system for this project.

## Purpose

Creates `.tasks/` directory structure with:
- Project context (vision, architecture)
- Initial tasks from requirements
- Validation commands
- Token-efficient manifest

Works with ANY project, any language, any documentation state.

## Agent Invocation

Delegates all initialization to `task-initializer` agent:

```
Initialize task management system for this project.

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](..core/minion-engine.md).
- Use Conditional Interview Protocol if project structure ambiguous
- Apply Reliability Labeling to all discoveries
- Never invent file paths or configurations

**Your Mission:**
1. Discover project type and structure
2. Find and parse documentation (requirements, architecture, tests)
3. Extract context into structured files
4. Generate initial tasks from requirements
5. Create complete .tasks/ directory structure
6. Validate setup

**Interview Protocol Triggers:**
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

**Expected Output:**
Comprehensive initialization report with:
- Project discovery results
- Documentation found
- Validation strategy detected
- Context files created (with token counts)
- Tasks generated (with dependency graph)
- Token efficiency metrics
- Next steps

**Success Criteria:**
✓ All directories created
✓ manifest.json valid
✓ At least one task file
✓ Context files complete
✓ Validation commands discovered
✓ metrics.json initialized
✓ Post-init validation passes

Begin initialization now.
```

## Post-Initialization

After agent completes:
1. Check status: `/task-status`
2. Find first task: `/task-next`
3. Start work: `/task-start T001`

## Error Handling

If `.tasks/` already exists:
- Agent will prompt for: Reinitialize | Migrate | Abort

If minimal documentation found:
- Agent will create basic structure
- Suggest documentation tasks

If project type unclear:
- Agent will ask for clarification
- Or create generic structure
