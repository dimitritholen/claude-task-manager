---
allowed-tools: Read, Task
description: Add new tasks to the existing task management system with full comprehensiveness
---

<purpose>
Add feature tasks incrementally while maintaining task-initializer quality standards—no shortcuts, no compromises.
</purpose>

<critical_setup>
**REQUIREMENTS**:
- 8+ acceptance criteria (specific, testable)
- 6+ test scenarios (success, edge, error cases)
- ALL required sections (description, context, technical impl, risks, dependencies)
- Accurate dependencies (verified in manifest.json, NEVER guessed)
- FORBIDDEN: Incomplete tasks, guessed dependencies, missing sections
</critical_setup>

<agent_whitelist>
**ONLY AUTHORIZED AGENT**: `task-creator` from this workflow

**FORBIDDEN**: Any agent from ~/.claude/agents/, other workflows, or general-purpose agents

**Why**: This workflow's task-creator generates tasks with ALL required sections, analyzes dependencies against manifest, matches task-initializer quality, creates update records, and updates manifest with bidirectional dependency graph. Global agents lack this workflow's comprehensive structure and standards.
</agent_whitelist>

<invocation>
## Command Invocation

Delegates to task-creator agent:
1. Load context (project, architecture, acceptance templates)
2. Read manifest for current tasks and dependencies
3. Analyze dependencies
4. Determine task splitting if needed
5. Generate comprehensive task file(s)
6. Update manifest atomically
7. Create update record

**Token budget**: ~800 tokens/task
</invocation>

<usage>
## Usage

```bash
/task-add "implement email notifications with SendGrid"
/task-add path/to/requirement.md
/task-add "As a user, I want to export my data to CSV"
/task-add "Add authentication system with OAuth, 2FA, password reset"  # Split into multiple tasks
```
</usage>

<agent_invocation>
## Agent Invocation

Use `task-creator` agent via Task tool.

**Agent Prompt:**

```
Create comprehensive task(s) for: {user_input}

Operate within [Minion Engine v3.0 framework](../core/minion-engine.md):
- Use Conditional Interview Protocol if request is vague
- Apply Reliability Labeling to dependencies and estimates
- NEVER guess dependencies - verify in manifest.json

**Steps:**
1. Load context (project.md, architecture.md, acceptance-templates.md)
2. Read manifest.json for current tasks and dependencies
3. Analyze dependencies
4. Determine if splitting into multiple tasks needed
5. Generate comprehensive task file(s) matching task-initializer quality
6. Update manifest.json atomically (tasks, stats, dependency_graph, critical_path)
7. Create update record in .tasks/updates/
8. Provide report

**Interview Protocol Triggers:** Vague scope, unclear dependencies, ambiguous priority, missing acceptance criteria guidance

**Quality Requirements:**
- ALL sections: description, business context, acceptance criteria, test scenarios, technical implementation, dependencies, design decisions, risks, progress log, completion checklist
- Min 8 acceptance criteria/task
- Min 6 test scenarios/task
- Accurate dependency analysis
- Realistic token estimates
- Appropriate priority (1-5 based on critical path)
- Design decisions explain "why"
- Risk analysis has real mitigations

**Report Must Include:**
- Tasks created (IDs, titles, priorities)
- Dependency analysis (prerequisites, enables)
- Task breakdown rationale
- Files created
- Manifest updates (stats, dependency graph, tokens)
- Next steps

**Success Criteria:** All task files complete, manifest.json valid, dependency graph bidirectional, update record created, no duplicates, dependencies reference existing tasks, realistic token estimates, task-initializer quality

**Special Cases:** Vague input → ask questions; Similar tasks → suggest enhancement; Large feature (>20k tokens) → split; Missing dependencies → create prerequisites; Missing context → infer but flag

Begin task creation.
```

**Agent Type**: `subagent_type: "task-creator"`

**Parameter Handling:** Replace `{user_input}` with file content (if .md/.txt path) or feature description directly.
</agent_invocation>

<artifacts>
## Created Files

**1. Task File** (`.tasks/tasks/T00X-feature-slug.md`): YAML frontmatter, description, business context, 8+ acceptance criteria, 6+ test scenarios, technical implementation, dependencies, design decisions, risks & mitigations, progress log, completion checklist

**2. Updated Manifest** (`.tasks/manifest.json`): New task(s), updated stats, dependency_graph, critical_path, total_estimated_tokens

**3. Update Record** (`.tasks/updates/task-creator_YYYYMMDD_HHMMSS.json`): Timestamp, agent, action, tasks added, summary
</artifacts>

<examples>
## Example

```bash
/task-add "implement email notifications with SendGrid integration"

# Output:
# ✅ T006: Email Notification System with SendGrid
# - Priority: 2 (important feature, not critical path)
# - Depends on: T002 (Database schema for notification preferences)
# - Estimated tokens: ~10,000
# - Files: T006-email-notifications-sendgrid.md, update record, manifest.json
# - Next: /task-start T006 (T002 complete)
```
</examples>

<output_format>
## Output Format

**Success:**
```
✅ [Task ID]: [Title]
- Priority: [1-5] ([rationale])
- Depends on: [Dependencies with IDs]
- Estimated tokens: ~[number]
- Files: [task-file].md, update record, manifest.json
- Next: /task-start [Task ID] ([dependency status])
```

**Error:**
```
❌ Task Creation Failed
Reason: [error]
Action: [what to fix]
```

**Required Elements:** Task IDs/titles, priority/rationale, dependency analysis, breakdown rationale (if multiple), files created, manifest updates, next steps
</output_format>

<next_steps>
After adding tasks: `/task-status` (overview), `/task-next` (find actionable), `/task-start T00X` (begin work)
</next_steps>
