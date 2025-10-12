---
id: T002
title: <Task Title - Brief Description>
status: in_progress
priority: 1
agent: <agent-type>
dependencies: [T001]
blocked_by: []
created: <ISO-8601-timestamp>
updated: <ISO-8601-timestamp>
tags: [<tag1>, <tag2>, <tag3>]

# Context References (lazy-loaded when task is active)
context_refs:
  - context/project.md
  - context/architecture.md
  - context/test-scenarios/<feature-name>.feature

# Documentation References (file:line format for quick navigation)
docs_refs:
  - <path/to/doc.md>:<line-start>-<line-end> (<Brief description of what's there>)
  - <path/to/another-doc.md>:<line-start>-<line-end> (<Brief description>)

# Token Tracking
est_tokens: 8000
actual_tokens: null
---

# <Task Title - Detailed Description>

## Description

<Clear, detailed description of what needs to be done. Be specific about the scope and boundaries of this task.>

## Business Context

<Explain why this task matters:>
- What problem does it solve?
- What does it unblock?
- Is it on the critical path?
- What's the impact if not done?

**User Story**: "<As a [user type], I want [goal], so that [benefit]>"

## Acceptance Criteria

- [ ] <Specific, measurable criterion 1>
- [ ] <Specific, measurable criterion 2>
- [ ] <Specific, measurable criterion 3>
- [ ] <Specific, measurable criterion 4>
- [ ] <Specific, measurable criterion 5>

## Test Scenarios

<Reference to test scenarios in context directory>

See: `context/test-scenarios/<feature-name>.feature`

**Key Scenarios for This Task**:
- "<Scenario name>" (lines X-Y)
- "<Scenario name>" (lines A-B)

<Or inline test cases if no separate file>

**Test Case 1**: <Name>
- Given: <precondition>
- When: <action>
- Then: <expected result>

**Test Case 2**: <Name>
- Given: <precondition>
- When: <action>
- Then: <expected result>

## Technical Implementation

### Required Components

<List what needs to be built, modified, or integrated>

1. <Component/file/module 1>
2. <Component/file/module 2>
3. <Component/file/module 3>

### Validation Commands

<Commands to validate the implementation - discovered from project structure>

<Command to run tests>
<Command to run build>
<Command to run linter>
<Command to check types>
<Command to verify functionality>

## Dependencies

**Hard Dependencies** (must be completed first):

- [T001] <Description of dependency and why it's required>
- <External dependency if any>

**Soft Dependencies** (can proceed without):

- <Description of nice-to-have but not required>

## Design Decisions

### <Decision 1 Title>

<Description of the decision>

**Rationale**: <Why this approach was chosen>

**Alternatives Considered**: <What else was considered and why it was rejected>

### <Decision 2 Title>

<Description of the decision>

**Rationale**: <Why this approach was chosen>

## Risks & Mitigations

| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|------------|
| <Risk description> | High/Medium/Low | High/Medium/Low | <How to mitigate> |
| <Risk description> | High/Medium/Low | High/Medium/Low | <How to mitigate> |

## Progress Log

```
<ISO-8601-timestamp> - Task created from <source>
<ISO-8601-timestamp> - Started implementation
<ISO-8601-timestamp> - <Progress update>
<ISO-8601-timestamp> - <Progress update>
```

## Completion Checklist

Before marking this task complete:

- [ ] All acceptance criteria checked and passing
- [ ] All validation commands executed successfully
- [ ] All tests written and passing
- [ ] Code review passed (if required)
- [ ] Documentation updated
- [ ] No linting errors or warnings
- [ ] No TODO/FIXME comments remaining
- [ ] Performance is acceptable
- [ ] Security considerations addressed

**Definition of Done**: <Specific, measurable definition of when this task is truly complete>

---

## Learnings (Post-Completion)

_This section is filled after task completion for knowledge retention._

### What Worked Well

- <Item that went smoothly>
- <Item that went smoothly>

### What Was Harder Than Expected

- <Item that was challenging>
- <Item that was challenging>

### Token Usage Analysis

- Estimated: <tokens> tokens
- Actual: <tokens> tokens
- Variance: <percentage>%
- <Analysis of why variance occurred>

### Recommendations for Similar Tasks

- <Recommendation for next time>
- <Recommendation for next time>
- <Pattern or approach to reuse>
