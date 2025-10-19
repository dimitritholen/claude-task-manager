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

# Context References (lazy-loaded)
context_refs:
  - context/project.md
  - context/architecture.md
  - context/test-scenarios/<feature-name>.feature

# Documentation References (file:line)
docs_refs:
  - <path/to/doc.md>:<line-start>-<line-end> (<description>)
  - <path/to/another-doc.md>:<line-start>-<line-end> (<description>)

# Token Tracking
est_tokens: 8000
actual_tokens: null
---

# <Task Title - Detailed Description>

## Description

<Detailed description of what needs to be done. Specify scope and boundaries.>

## Business Context

<Why this matters:>
- Problem solved?
- What does it unblock?
- Critical path?
- Impact if not done?

**User Story**: "<As [user type], I want [goal], so that [benefit]>"

## Acceptance Criteria

- [ ] <Specific, measurable criterion 1>
- [ ] <Specific, measurable criterion 2>
- [ ] <Specific, measurable criterion 3>
- [ ] <Specific, measurable criterion 4>
- [ ] <Specific, measurable criterion 5>

## Test Scenarios

See: `context/test-scenarios/<feature-name>.feature`

**Key Scenarios**:
- "<Scenario name>" (lines X-Y)
- "<Scenario name>" (lines A-B)

<Or inline if no separate file>

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

<What to build, modify, or integrate>

1. <Component/file/module 1>
2. <Component/file/module 2>
3. <Component/file/module 3>

### Validation Commands

<Commands to validate implementation>

<Run tests>
<Run build>
<Run linter>
<Check types>
<Verify functionality>

## Dependencies

**Hard Dependencies** (must complete first):

- [T001] <Dependency description and why required>
- <External dependency if any>

**Soft Dependencies** (optional):

- <Nice-to-have but not required>

## Design Decisions

### <Decision 1 Title>

<Decision description>

**Rationale**: <Why chosen>

**Alternatives Considered**: <What else considered and why rejected>

### <Decision 2 Title>

<Decision description>

**Rationale**: <Why chosen>

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

Before marking complete:

- [ ] All acceptance criteria passing
- [ ] All validation commands successful
- [ ] All tests written and passing
- [ ] Code review passed (if required)
- [ ] Documentation updated
- [ ] No linting errors/warnings
- [ ] No TODO/FIXME comments
- [ ] Performance acceptable
- [ ] Security addressed

**Definition of Done**: <Measurable definition of when truly complete>

---

## Learnings (Post-Completion)

_Fill after completion for knowledge retention._

### What Worked Well

- <What went smoothly>
- <What went smoothly>

### What Was Harder Than Expected

- <What was challenging>
- <What was challenging>

### Token Usage Analysis

- Estimated: <tokens> tokens
- Actual: <tokens> tokens
- Variance: <percentage>%
- <Analysis of why variance occurred>

### Recommendations for Similar Tasks

- <Next time recommendation>
- <Next time recommendation>
- <Pattern/approach to reuse>
