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

<scope_boundaries>

## SCOPE BOUNDARIES — What task-init Does and Does NOT Do

### ✅ WHAT TASK-INIT DOES

**For Existing Projects:**
- Discover project type, language, framework from existing code/config
- Extract documentation from existing files (README, PRD, ARCHITECTURE)
- Identify validation commands (test, build, lint) from package.json, Makefile, etc.
- Create task management structure (.tasks/) based on discovered state

**For New Projects (with PRD):**
- Parse requirements from PRD
- **DELEGATE** architecture decisions to system-architect
- Initialize task structure based on architectural decisions from specialist agents
- Extract context from PRD and architectural outputs

### ❌ WHAT TASK-INIT NEVER DOES

**PROHIBITED — NEVER make these decisions autonomously:**

- ❌ Tech stack selection (languages, frameworks, libraries)
- ❌ Architectural patterns (microservices vs monolith, REST vs GraphQL)
- ❌ Implementation approach (code-based vs no-code, SPA vs SSR)
- ❌ Database choices (SQL vs NoSQL, PostgreSQL vs MongoDB)
- ❌ Infrastructure decisions (cloud provider, deployment strategy)
- ❌ Strategic product decisions (features, scope, priorities without documented requirements)

**When uncertain → MUST:**
1. **First**: Check if system-architect or other specialist should decide
2. **Second**: Ask user with specific options
3. **Never**: Make autonomous strategic decisions

### Decision Tree

```
Is there existing code/config?
├─ YES → Discover what exists, initialize from reality
└─ NO → Is there a PRD/requirements doc?
    ├─ YES → Delegate to system-architect for tech decisions, then initialize
    └─ NO → ASK USER: "What should I initialize from?"
```

</scope_boundaries>

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

**CRITICAL**: Always consult user before making strategic decisions.

**MANDATORY TRIGGERS** (use Conditional Interview Protocol when detected):

### Existing Project Ambiguity
- Multiple languages detected (Python + TypeScript + Rust)
- No clear primary documentation (multiple READMEs, no PRD)
- Ambiguous project structure (monorepo? microservices? single app?)
- Multiple test frameworks found
- Conflicting configuration files

### New Project / Tech Stack Ambiguity
- **No existing code detected** (empty repo or PRD-only)
- **Tech stack not specified in PRD**
- **Architecture approach unclear** (microservices? serverless? traditional?)
- **Multiple valid implementation approaches** (SPA vs SSR, REST vs GraphQL)
- **Infrastructure choices needed** (cloud provider, database type)

### Strategic Decision Required
- **ANY choice that affects the entire architecture**
- **ANY decision about "what kind of project this should be"**
- **ANY implementation approach selection** (code-based vs low-code vs no-code)

**If triggered, MUST ask user OR delegate to specialist:**

### For Tech Stack / Architecture Decisions:
```markdown
⚠️ **Architecture Decision Required**

I detected a new project or unclear tech stack. I cannot make these decisions autonomously.

**Option 1: Delegate to system-architect agent**
Let system-architect analyze requirements and design architecture
[Recommended for complex projects]

**Option 2: You specify tech stack**
Provide: Language, framework, database, deployment approach
[Quick start for projects with clear tech choices]

Which approach do you prefer?
```

### For Existing Project Clarification:
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

**NEVER proceed with autonomous tech-stack assumptions.**

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
- **NEVER** create generic structure without consultation
</error_handling>

<anti_patterns>

## ANTI-PATTERNS — Prohibited Autonomous Decisions

**NEVER make these decisions without user consultation or delegation:**

### ❌ Tech Stack Decisions
```
BAD: "I'll create a no-code prototype using Bubble"
BAD: "Let's use React for the frontend"
BAD: "I'll set this up with PostgreSQL"
GOOD: "I detected no tech stack. Should I delegate to system-architect or would you like to specify?"
```

### ❌ Architecture Patterns
```
BAD: "I'll set up microservices architecture"
BAD: "This should be a serverless application"
BAD: "I'll implement this as a REST API"
GOOD: "Multiple architectures are valid. Which do you prefer, or should system-architect decide?"
```

### ❌ Implementation Approaches
```
BAD: "I'll create tasks for a low-code solution"
BAD: "This should be a single-page application"
BAD: "I'll plan this as a mobile-first PWA"
GOOD: "Implementation approach is unclear. Please specify or I can delegate to system-architect."
```

### ❌ Strategic Product Decisions
```
BAD: "I'll assume MVP scope means just authentication"
BAD: "I'll prioritize features based on what seems important"
BAD: "I'll infer the target platform from similar projects"
GOOD: "Requirements don't specify platform/scope. Please clarify."
```

### ✅ What IS Allowed
```
GOOD: "Found package.json with React, creating tasks for React project"
GOOD: "Detected Django in requirements.txt, discovered test command: pytest"
GOOD: "README specifies Python 3.11 and FastAPI, extracting tech stack"
GOOD: "No code found. Do you want me to delegate to system-architect or specify tech stack yourself?"
```

**KEY PRINCIPLE**: Discovery YES, Decisions NO

</anti_patterns>

<next_steps>

## Post-Initialization

After agent completes initialization:

1. **Check status**: `/task-status`
2. **Find first task**: `/task-next`
3. **Start work**: `/task-start T001`
</next_steps>
