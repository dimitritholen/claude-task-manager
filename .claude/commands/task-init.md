---
allowed-tools: Task
description: Initialize token-efficient task management system in current project
---

<invocation>
**Command**: `/task-init`

Initializes task management with **FULL AUTOMATION**.
</invocation>

<critical_setup>
**MANDATORY** before starting:

1. Get today's date: `date`
2. Verify project root
3. Check for `.tasks/` directory
</critical_setup>

<scope_boundaries>

## SCOPE BOUNDARIES

### ✅ DOES

**Existing Projects:**
- Discover project type, language, framework from code/config
- Extract docs (README, PRD, ARCHITECTURE)
- Identify validation commands (package.json, Makefile, etc.)
- Create `.tasks/` from discovered state

**New Projects (with PRD):**
- Parse PRD requirements
- **DELEGATE** architecture to system-architect
- Initialize from architectural decisions
- Extract context from PRD/outputs

### ❌ NEVER DOES

**PROHIBITED autonomous decisions:**

- ❌ Tech stack (languages, frameworks, libraries)
- ❌ Architecture (microservices/monolith, REST/GraphQL)
- ❌ Implementation (code-based/no-code, SPA/SSR)
- ❌ Database (SQL/NoSQL, PostgreSQL/MongoDB)
- ❌ Infrastructure (cloud, deployment)
- ❌ Strategic product (features, scope, priorities without docs)

**When uncertain:**
1. Check if specialist should decide
2. Ask user with options
3. Never make autonomous strategic decisions

### Decision Tree

```
Existing code/config?
├─ YES → Discover, initialize from reality
└─ NO → PRD/requirements?
    ├─ YES → Delegate to system-architect, initialize
    └─ NO → ASK USER
```

</scope_boundaries>

<purpose>
Initialize task management with **FULL AUTOMATION**.

**GUARANTEED**: Working system regardless of docs/project state.

**UNIVERSAL**: Works with ANY project, language, docs.

**NO FAILURE**: Adapts to existing, creates missing, never gives up.
</purpose>

<system_structure>

## System Structure

Creates `.tasks/` with:

- Project context (vision, architecture)
- Initial tasks from requirements
- Validation commands
- Token-efficient manifest

</system_structure>

<agent_whitelist>

## MANDATORY Agent Whitelist

**ONLY**: `task-initializer` - Full initialization specialist
</agent_whitelist>

<agent_invocation>

## Agent Invocation

Delegate to `task-initializer`:

```
Initialize task management system.

**IMPORTANT**: Operate within [Minion Engine v3.0](..core/minion-engine.md).
- Use Conditional Interview if structure ambiguous
- Apply Reliability Labeling
- **NEVER** invent paths/configs

**Mission:**
1. Discover project type/structure
2. Find/parse docs (requirements, architecture, tests)
3. Extract context to structured files
4. Generate tasks from requirements
5. Create `.tasks/` structure
6. Validate setup
```

</agent_invocation>

<interview_protocol>

## Interview Protocol

**CRITICAL**: Consult user before strategic decisions.

**MANDATORY TRIGGERS** (Conditional Interview when detected):

### Existing Project Ambiguity
- Multiple languages (Python + TypeScript + Rust)
- No clear primary docs (multiple READMEs, no PRD)
- Ambiguous structure (monorepo/microservices/single app)
- Multiple test frameworks
- Conflicting configs

### New Project / Tech Stack Ambiguity
- No code (empty repo/PRD-only)
- Tech stack not in PRD
- Architecture unclear (microservices/serverless/traditional)
- Multiple valid approaches (SPA/SSR, REST/GraphQL)
- Infrastructure choices needed (cloud, database)

### Strategic Decision Required
- ANY choice affecting entire architecture
- ANY decision about "what kind of project"
- ANY implementation approach (code/low-code/no-code)

**If triggered, ask user OR delegate:**

### Tech Stack / Architecture:
```markdown
⚠️ **Architecture Decision Required**

New project/unclear tech stack. Cannot decide autonomously.

**Option 1: Delegate to system-architect**
Analyze requirements, design architecture
[Complex projects]

**Option 2: Specify tech stack**
Provide: Language, framework, database, deployment
[Quick start with clear choices]

Which?
```

### Existing Project Clarification:
```markdown
🔍 **Project Structure Clarification**

Complexity requires clarification:

**Q1: Primary Language**
Found: Python, TypeScript, Rust
Primary for tasks?
  - [ ] Python / TypeScript / Rust / Other: ___

**Q2: Documentation**
Multiple docs found. Requirements location?
  - [ ] README.md / docs/PRD.md / SPEC.md / Other: ___

**Q3: Project Type**
  - [ ] Monorepo / Microservices / Single app / Library
```

**NEVER proceed with autonomous tech assumptions.**

</interview_protocol>

<output_format>

## Output Format

### Success Report

**Project Discovery**
- Type, language, docs, validation strategy

**Files Created**
- Context files (token counts)
- Tasks (dependency graph)
- Manifest, metrics

**Quality Metrics**
- Token efficiency
- Coverage

**Next Steps**
- First task recommendation
- Validation commands

### Success Criteria (ALL REQUIRED)

- ✓ Directories created
- ✓ `manifest.json` valid
- ✓ ≥1 task file
- ✓ Context complete
- ✓ Validation commands found
- ✓ `metrics.json` initialized
- ✓ Post-init validation passes
</output_format>

<error_handling>

## Error Handling

**`.tasks/` exists:** Prompt: **Reinitialize** | **Migrate** | **Abort**

**Minimal docs:** Create basic structure, suggest doc tasks

**Unclear type:** Ask clarification, **NEVER** create generic structure without consultation
</error_handling>

<anti_patterns>

## ANTI-PATTERNS

**NEVER without user/delegation:**

### ❌ Tech Stack
```
BAD: "I'll create no-code prototype using Bubble"
BAD: "Let's use React"
BAD: "I'll use PostgreSQL"
GOOD: "No tech stack. Delegate to system-architect or specify?"
```

### ❌ Architecture
```
BAD: "I'll set up microservices"
BAD: "This should be serverless"
BAD: "I'll implement REST API"
GOOD: "Multiple architectures valid. Prefer one or system-architect decides?"
```

### ❌ Implementation
```
BAD: "I'll create low-code tasks"
BAD: "This should be SPA"
BAD: "I'll plan mobile-first PWA"
GOOD: "Implementation unclear. Specify or delegate to system-architect."
```

### ❌ Strategic Product
```
BAD: "MVP scope = just auth"
BAD: "I'll prioritize important features"
BAD: "I'll infer platform from similar projects"
GOOD: "Requirements missing platform/scope. Clarify."
```

### ✅ Allowed
```
GOOD: "package.json has React, creating React tasks"
GOOD: "requirements.txt has Django, test: pytest"
GOOD: "README: Python 3.11/FastAPI, extracting stack"
GOOD: "No code. Delegate to system-architect or specify?"
```

**KEY**: Discovery YES, Decisions NO

</anti_patterns>

<next_steps>

## Post-Initialization

After completion:

1. Check status: `/task-status`
2. Find first: `/task-next`
3. Start work: `/task-start T001`
</next_steps>
