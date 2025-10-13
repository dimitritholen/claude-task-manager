---
allowed-tools: Read, Task
description: Add new tasks to the existing task management system with full comprehensiveness
---

Add new feature tasks to the project incrementally while maintaining the same quality and structure as the initial task system setup.

**When to Use:**
- Adding new features during development
- Breaking down user requests into tracked tasks
- Creating tasks from requirements or user stories
- Maintaining agile workflow after initialization

**Task Quality Guarantee:**
Every task created will include:
- Complete acceptance criteria (8+ specific, testable criteria)
- Test scenarios (6+ cases covering success, edge cases, errors)
- Technical implementation details
- Validation commands
- Design decisions with rationale
- Risk analysis with mitigations
- Dependency analysis
- Token estimates

**Usage:**

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

**Instructions:**

**MANDATORY**: This command MUST use the `task-creator` agent via the Task tool.

Invoke the agent with the following structured prompt:

```
Create comprehensive task(s) for the following feature request:

**Feature Request:**
{user_input}

**Your Mission:**
1. Load existing context (project.md, architecture.md, acceptance-templates.md)
2. Read manifest.json to understand current tasks and dependencies
3. Analyze dependencies (what existing tasks does this depend on?)
4. Determine if feature should be split into multiple tasks
5. Generate comprehensive task file(s) matching task-initializer quality
6. Update manifest.json atomically (tasks, stats, dependency_graph, critical_path)
7. Create atomic update record in .tasks/updates/
8. Provide detailed report

**Quality Requirements:**
- Each task must have ALL sections (description, business context, acceptance criteria, test scenarios, technical implementation, dependencies, design decisions, risks, progress log, completion checklist)
- Minimum 8 acceptance criteria per task
- Minimum 6 test scenarios per task
- Accurate dependency analysis
- Realistic token estimates
- Appropriate priority assignment (1-5 based on critical path)
- Design decisions must explain "why"
- Risk analysis must have real mitigations

**Expected Output:**
Provide a comprehensive report showing:
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

**Parameter Handling:**

Replace `{user_input}` with:
- If argument is a file path (ends with .md or .txt): Read the file and use its content
- Otherwise: Use the argument as the feature description directly

**Success Criteria:**
- New task file(s) created in .tasks/tasks/ with comprehensive content
- manifest.json updated with new tasks, dependencies, and stats
- Update record created in .tasks/updates/
- All task files have required sections and pass quality checks
- Dependencies are accurate and reference existing tasks
- Report shows clear next steps

**Example Workflow:**

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

**What Gets Created:**

1. **Task File** (`.tasks/tasks/T00X-feature-slug.md`)
   - YAML frontmatter (id, title, status, priority, dependencies, tags, context_refs, docs_refs, est_tokens)
   - Description
   - Business Context
   - Acceptance Criteria (8+ items)
   - Test Scenarios (6+ cases)
   - Technical Implementation
   - Dependencies
   - Design Decisions
   - Risks & Mitigations
   - Progress Log
   - Completion Checklist

2. **Updated Manifest** (`.tasks/manifest.json`)
   - New task(s) in tasks array
   - Updated stats (total_tasks, pending)
   - Updated dependency_graph
   - Updated critical_path (if Priority 1)
   - Updated total_estimated_tokens

3. **Update Record** (`.tasks/updates/task-creator_YYYYMMDD_HHMMSS.json`)
   - Timestamp
   - Agent name
   - Action taken
   - Tasks added
   - Summary

**Notes:**
- The task-creator agent maintains the same quality standards as task-initializer
- Large features will automatically be broken into multiple manageable tasks
- Dependencies are analyzed intelligently based on existing project structure
- Duplicate detection prevents creating tasks that already exist
- All validation commands are inherited from the project's existing context

After adding tasks, use:
- `/task-status` - Check updated task overview
- `/task-next` - Find next actionable task
- `/task-start T00X` - Start working on the new task
