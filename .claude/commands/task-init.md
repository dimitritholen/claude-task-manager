---
allowed-tools: Read, Write, Glob, Grep, Bash, Task
description: Initialize token-efficient task management system in current project
---

Initialize the fractal task management system for this project.

**Task Management System Overview:**
- 85%+ token reduction vs monolithic task files
- Status checks: ~150 tokens (manifest only)
- Task execution: ~1,650 tokens (manifest + task + context)
- Works with any language, framework, platform

**What This Command Does:**

1. **Discover Project Structure**
   - Identify language/framework from config files
   - Detect project type and structure
   - Find testing and validation tools

2. **Find Documentation**
   - Search for requirements docs (PRD.md, REQUIREMENTS.md, README.md, specs/, etc.)
   - Search for architecture docs (ARCHITECTURE.md, DESIGN.md, TECHNICAL.md, etc.)
   - Search for test scenarios (*.feature, test plans, etc.)
   - Work with whatever exists, or create minimal structure

3. **Extract Project Context**
   - Create `context/project.md` with vision, goals, constraints
   - Create `context/architecture.md` with tech decisions
   - Create `context/acceptance-templates.md` with validation patterns
   - Extract test scenarios to `context/test-scenarios/`

4. **Generate Initial Tasks**
   - Parse requirements from discovered documentation
   - Create task files with acceptance criteria
   - Establish dependencies
   - Populate manifest.json

5. **Create Directory Structure**
   ```
   .tasks/
   ├── manifest.json              # Lightweight index
   ├── tasks/                     # Individual task files
   ├── context/                   # Session-loaded context
   │   ├── project.md
   │   ├── architecture.md
   │   ├── acceptance-templates.md
   │   └── test-scenarios/
   ├── completed/                 # Archive
   ├── updates/                   # Atomic updates
   └── metrics.json               # Performance tracking
   ```

**Instructions:**

**MANDATORY**: This command MUST use the `task-initializer` agent via the Task tool.

Invoke the agent with the following structured prompt:

```
Initialize the token-efficient task management system for this project.

**Your Mission:**
1. Discover project type and structure
2. Find and parse all documentation (requirements, architecture, test scenarios)
3. Extract context into structured files (project.md, architecture.md, acceptance-templates.md)
4. Generate initial task structure from requirements
5. Validate complete setup

**Expected Directory Structure:**
.tasks/
├── manifest.json              # Lightweight index
├── tasks/                     # Individual task files
├── context/                   # Session-loaded context
│   ├── project.md
│   ├── architecture.md
│   ├── acceptance-templates.md
│   └── test-scenarios/
├── completed/                 # Archive
├── updates/                   # Atomic updates
└── metrics.json               # Performance tracking

**Expected Output:**
Provide a comprehensive initialization report showing:
- Project discovery results (type, language, framework)
- Documentation found and extracted
- Validation strategy detected (test framework, build commands)
- Context files created with token counts
- Tasks generated with dependency graph
- Token efficiency metrics vs monolithic approach
- Next steps for using the system

**Success Criteria:**
✓ All directories created
✓ manifest.json valid and populated
✓ At least one task file created
✓ Context files present with project-specific content
✓ Validation commands discovered or inferred
✓ metrics.json initialized

Begin initialization now.
```

**Success Criteria:**
- .tasks/ directory created with all subdirectories
- manifest.json exists and is valid JSON
- context/ files created with project-specific content
- At least one task file created from requirements
- All task files have required sections
- metrics.json initialized

After initialization, use:
- `/task-status` - Check task overview
- `/task-next` - Find next task to work on
- `/task-start [id]` - Start working on a specific task
