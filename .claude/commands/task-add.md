---
allowed-tools: Read, Task
description: Add new tasks to the existing task management system with full comprehensiveness
---

<purpose>
Add new feature tasks to the project incrementally while **MAINTAINING QUALITY STANDARDS**.

**QUALITY GUARANTEE**: Every task matches `task-initializer` quality—no shortcuts, no compromises.
</purpose>

<critical_setup>
**MANDATORY PRE-FLIGHT REQUIREMENTS**:

- ✅ **8+ acceptance criteria** (specific, testable)
- ✅ **6+ test scenarios** (success, edge, error cases)
- ✅ **ALL required sections** (description, context, technical impl, risks, dependencies)
- ✅ **Accurate dependencies** (verified in manifest.json, **NEVER** guessed)
- ❌ **FORBIDDEN**: Incomplete tasks, guessed dependencies, missing sections
</critical_setup>

<agent_whitelist>

## **MANDATORY AGENT WHITELIST — STRICT ENFORCEMENT**

**ONLY these agents from this workflow are authorized:**

- ✅ `task-creator` - Comprehensive task generation specialist matching task-initializer quality

**FORBIDDEN:**

- ❌ **ANY** agent with same name from global ~/.claude/agents/
- ❌ **ANY** agent from other workflows
- ❌ **ANY** general-purpose agents
</agent_whitelist>

<rationale>
**Why This Matters:**
This workflow's task-creator is specifically designed to:

- Generate tasks with **ALL** required sections (8+ acceptance criteria, 6+ test scenarios)
- Analyze dependencies against existing manifest
- Match task-initializer quality standards
- Create atomic update records
- Update manifest with bidirectional dependency graph

Global agents do **NOT** know this workflow's comprehensive task structure or standards.
</rationale>

<invocation>
## Command Invocation

This command delegates task creation to the specialized task-creator agent that:

1. Loads existing context (project, architecture, acceptance templates)
2. Reads manifest to understand current tasks and dependencies
3. Analyzes dependencies
4. Determines if feature should be split into multiple tasks
5. Generates comprehensive task file(s)
6. Updates manifest atomically
7. Creates update record

**Token budget**: ~800 tokens per task created
</invocation>

<usage>
## Usage Examples

```bash
# Add task from description
/task-add "implement email notifications with SendGrid"

# Add task from file
/task-add path/to/requirement.md

# Add task from user story
/task-add "As a user, I want to export my data to CSV format"

# Add complex feature (will be broken into multiple tasks)
/task-add "Add complete user authentication system with OAuth, 2FA, and password reset"
```

</usage>

<agent_invocation>

## Agent Invocation

**MANDATORY**: Use `task-creator` agent via Task tool.

**Agent Prompt:**

```
Create comprehensive task(s) for the following feature request:

**Feature Request:**
{user_input}

**IMPORTANT**: Operate within [Minion Engine v3.0 framework](../core/minion-engine.md).
- Use Conditional Interview Protocol if feature request vague
- Apply Reliability Labeling to dependency analysis and estimates
- **NEVER** guess dependencies - verify in manifest.json

**Your Mission:**
1. Load existing context (project.md, architecture.md, acceptance-templates.md)
2. Read manifest.json to understand current tasks and dependencies
3. Analyze dependencies (what existing tasks does this depend on?)
4. Determine if feature should be split into multiple tasks
5. Generate comprehensive task file(s) matching task-initializer quality
6. Update manifest.json atomically (tasks, stats, dependency_graph, critical_path)
7. Create atomic update record in .tasks/updates/
8. Provide detailed report

**Interview Protocol Triggers:**
- Vague feature scope ("add user management" - what's included?)
- Unclear dependencies ("might need auth")
- Ambiguous priority/urgency
- Missing acceptance criteria guidance

**If triggered, use Minion Engine Interview Protocol** (see agent instructions)

**Quality Requirements:**
- Each task **MUST** have **ALL** sections (description, business context, acceptance criteria, test scenarios, technical implementation, dependencies, design decisions, risks, progress log, completion checklist)
- **MINIMUM** 8 acceptance criteria per task
- **MINIMUM** 6 test scenarios per task
- **ACCURATE** dependency analysis
- **REALISTIC** token estimates
- **APPROPRIATE** priority assignment (1-5 based on critical path)
- Design decisions **MUST** explain "why"
- Risk analysis **MUST** have real mitigations

**Expected Output:**
Provide comprehensive report showing:
- Tasks created (IDs, titles, priorities)
- Dependency analysis (prerequisites, what this enables)
- Task breakdown rationale (if multiple tasks)
- Files created
- Manifest updates (stats, dependency graph, tokens)
- Next steps (when task can be started)

**Success Criteria:**
✓ All task files created with complete sections
✓ manifest.json updated and valid JSON
✓ Dependency graph updated with bidirectional relationships
✓ Update record created in .tasks/updates/
✓ No duplicate tasks created
✓ All dependencies reference existing tasks
✓ Token estimates are realistic
✓ Quality matches task-initializer standard

**Special Cases:**
- If input is too vague, ask clarifying questions before creating tasks
- If similar tasks exist, detect and suggest enhancement instead
- If feature is too large (>20,000 tokens), break into multiple dependent tasks
- If dependencies don't exist yet, create prerequisite tasks first
- If context is missing, infer from existing tasks but flag for review

Begin task creation now.
```

**Agent Type**: `subagent_type: "task-creator"`

**Parameter Handling:**

Replace `{user_input}` with:

- If argument is a file path (ends with .md or .txt): Read the file and use its content
- Otherwise: Use the argument as the feature description directly
</agent_invocation>

<artifacts>
## What Gets Created

### **1. Task File (`.tasks/tasks/T00X-feature-slug.md`)**

- YAML frontmatter (id, title, status, priority, dependencies, tags, est_tokens)
- Description
- Business Context
- Acceptance Criteria (**8+ items**)
- Test Scenarios (**6+ cases**)
- Technical Implementation
- Dependencies
- Design Decisions
- Risks & Mitigations
- Progress Log
- Completion Checklist

### **2. Updated Manifest (`.tasks/manifest.json`)**

- New task(s) in tasks array
- Updated stats (total_tasks, pending)
- Updated dependency_graph
- Updated critical_path (if Priority 1)
- Updated total_estimated_tokens

### **3. Update Record (`.tasks/updates/task-creator_YYYYMMDD_HHMMSS.json`)**

- Timestamp
- Agent name
- Action taken
- Tasks added
- Summary
</artifacts>

<examples>
## Example Workflow

```bash
# User wants to add email notifications
/task-add "implement email notifications with SendGrid integration"

# Agent output:
# ✅ Task(s) Created Successfully
#
# T006: Email Notification System with SendGrid
# - Priority: 2 (important feature, not critical path)
# - Depends on: T002 (Database schema for notification preferences)
# - Estimated tokens: ~10,000
# - Status: pending
#
# Files Created:
# ✓ .tasks/tasks/T006-email-notifications-sendgrid.md
# ✓ .tasks/updates/task-creator_20251012_143022.json
# ✓ .tasks/manifest.json (updated)
#
# Next Steps:
# 1. Review task: Check .tasks/tasks/T006-email-notifications-sendgrid.md
# 2. Start work: /task-start T006 (T002 is already complete)

# Check task status
/task-status

# Start working on new task
/task-start T006
```

</examples>

<output_format>

## Expected Output Format

### **Success Report**

```
✅ Task(s) Created Successfully

[Task ID]: [Task Title]
- Priority: [1-5] ([rationale])
- Depends on: [Dependencies with IDs and descriptions]
- Estimated tokens: ~[number]
- Status: pending

Files Created:
✓ .tasks/tasks/[task-file].md
✓ .tasks/updates/task-creator_[timestamp].json
✓ .tasks/manifest.json (updated)

Next Steps:
1. Review task: Check .tasks/tasks/[task-file].md
2. Start work: /task-start [Task ID] ([dependency status])
```

### **Error Report**

```
❌ Task Creation Failed

Reason: [Specific error explanation]

Required Action:
- [What user needs to provide or fix]
```

### **Report Elements (MANDATORY)**

- Task IDs and titles
- Priority with rationale
- Dependency analysis (prerequisites, what this enables)
- Task breakdown rationale (if multiple tasks created)
- Files created/modified
- Manifest updates (stats, dependency graph, tokens)
- Next actionable steps
</output_format>

<rationale>
## Why Use task-creator Agent

- **Specialized Expertise**: Designed for comprehensive task generation
- **Quality Standards**: Maintains task-initializer quality levels
- **Intelligent Splitting**: Breaks large features into manageable tasks
- **Dependency Analysis**: Analyzes and links to existing tasks
- **Duplicate Detection**: Prevents creating tasks that already exist
- **Consistent Structure**: All tasks follow same comprehensive format
- **Atomic Updates**: Creates update records for audit trail
</rationale>

<next_steps>

## Next Steps

After adding tasks:

- `/task-status` - Check updated task overview
- `/task-next` - Find next actionable task
- `/task-start T00X` - Start working on the new task
</next_steps>
