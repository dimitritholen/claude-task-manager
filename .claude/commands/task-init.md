---
allowed-tools: Read, Write, Glob, Grep, Bash, Task
description: Initialize token-efficient task management system in current project
---

Initialize the fractal task management system for this project.

## MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT

**ONLY these agents from this workflow are authorized:**

- ✅ `task-initializer` - Project structure discovery and task system setup specialist

**FORBIDDEN:**
- ❌ ANY agent with same name from global ~/.claude/agents/
- ❌ ANY agent from other workflows
- ❌ ANY general-purpose agents
- ❌ ANY agent not explicitly listed above

**Enforcement:**
Before invoking Task tool with `subagent_type: "task-initializer"`, verify this specific agent exists in THIS workflow's agents.
This workflow's task-initializer is specifically designed to:
- Discover project structure (mono-repos, multi-language)
- Parse requirements from any format
- Generate comprehensive task files matching this workflow's standards
- Create context files with acceptance templates
- Set up atomic update system

**Why This Matters:**
Global agents do NOT know this task system's file structure, manifest schema, context layout, or atomic update patterns. Using them would create incompatible task structures.

**Task Management System Overview:**
- 85%+ token reduction vs monolithic task files
- Status checks: ~150 tokens (manifest only)
- Task execution: ~1,650 tokens (manifest + task + context)
- Works with any language, framework, platform
- Supports mono-repos, multi-language projects, and migration from existing systems

**Pre-Initialization Check:**
If `.tasks/` directory already exists, prompts for:
- **Reinitialize**: Backup existing, create fresh system
- **Migrate**: Preserve existing tasks, upgrade structure
- **Abort**: Cancel initialization

**What This Command Does:**

1. **Pre-Flight Checks**
   - Check if `.tasks/` exists (migration vs fresh init)
   - Detect mono-repo structure (multiple package.json, Cargo.toml, etc.)
   - Identify existing task management systems (TODO.md, TASKS.md, Jira references)

2. **Discover Project Structure**
   - Identify language/framework from config files
   - Detect project type and structure (mono-repo, multi-language, microservices)
   - Find testing and validation tools
   - Map workspace structure for mono-repos

3. **Find Documentation**
   - Search for requirements docs (PRD.md, REQUIREMENTS.md, README.md, specs/, etc.)
   - Search for architecture docs (ARCHITECTURE.md, DESIGN.md, TECHNICAL.md, etc.)
   - Search for test scenarios (*.feature, test plans, etc.)
   - Discover existing task lists (TODO.md, TASKS.md, GitHub Issues exports)
   - Work with whatever exists, or create minimal structure

4. **Extract Project Context**
   - Create `context/project.md` with vision, goals, constraints
   - Create `context/architecture.md` with tech decisions
   - Create `context/acceptance-templates.md` with validation patterns
   - Extract test scenarios to `context/test-scenarios/`
   - Import existing tasks if migration mode

5. **Generate Initial Tasks**
   - Parse requirements from discovered documentation
   - Import tasks from existing systems (if found)
   - Create task files with acceptance criteria
   - Establish dependencies
   - Populate manifest.json

6. **Create Directory Structure**
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

**Pre-Flight:**
1. Check if .tasks/ exists → if yes, prompt for: Reinitialize | Migrate | Abort
2. Detect mono-repo structure → if yes, map workspace locations
3. Scan for existing task systems → if found, offer migration

**Your Mission:**
1. Discover project type and structure (including mono-repos)
2. Find and parse all documentation (requirements, architecture, test scenarios)
3. Import existing tasks from TODO.md, TASKS.md, or similar (if migration mode)
4. Extract context into structured files (project.md, architecture.md, acceptance-templates.md)
5. Generate initial task structure from requirements
6. Post-initialization validation

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
✓ Post-init validation passes

**Post-Initialization Validation:**
Run these checks automatically:
1. JSON validation: `jq . .tasks/manifest.json`
2. Directory structure: verify all expected dirs exist
3. Context files: verify non-empty and parseable
4. Task files: verify at least one valid task
5. Dependencies: verify no circular deps in manifest

Begin initialization now.
```

**Migration Support:**

If existing task system detected (TODO.md, TASKS.md, etc.):
```
📋 Existing Task System Detected

Found: <file-path>
Format: <detected-format>

Migration Options:
1. **Import**: Convert existing tasks to .tasks/ format
   - Preserves task history
   - Attempts to infer structure
   - Manual review recommended

2. **Fresh Start**: Create new system, archive old
   - Old tasks moved to .tasks/legacy/
   - Start with clean slate
   - Reference old tasks as needed

3. **Parallel**: Keep both systems
   - Not recommended (divergence risk)

Recommended: Import for active projects, Fresh Start for legacy
```

**Mono-Repo Handling:**

If mono-repo detected:
```
🏗️  Mono-Repo Structure Detected

Workspaces found:
- packages/frontend/ (React)
- packages/backend/ (Node.js)
- packages/shared/ (TypeScript)

Initialization Strategy:
1. **Unified**: Single .tasks/ at root (recommended)
   - Tags differentiate workspace tasks
   - Central dependency management
   - Single source of truth

2. **Distributed**: .tasks/ in each workspace
   - Workspace autonomy
   - Potential dependency complexity
   - Multiple manifests to manage

Recommended: Unified for most cases
```

**Success Criteria:**
- .tasks/ directory created with all subdirectories
- manifest.json exists and is valid JSON
- context/ files created with project-specific content
- At least one task file created from requirements
- All task files have required sections
- metrics.json initialized
- Post-initialization validation passes (all checks green)

**Post-Initialization Commands:**
- `/task-status` - Check task overview
- `/task-next` - Find next task to work on
- `/task-start [id]` - Start working on a specific task
- `/task-health` - Run comprehensive health check
