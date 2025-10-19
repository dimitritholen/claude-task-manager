# Prompt Optimization Plan - Based on PROMPTS.md Best Practices

## Executive Summary

Analysis of 40+ prompt files revealed systematic issues violating PROMPTS.md best practices:

1. **Inconsistent XML Tagging**: Large sections lack semantic XML tags
2. **Missing Emphasis**: Critical requirements not bolded/uppercased
3. **Poor Instruction Placement**: Critical info buried mid-file
4. **No Output Format Specs**: Missing explicit `<output_format>` sections

## Optimization Requirements (Apply to ALL Files)

### 1. XML Tag Structure (MANDATORY)

**Problem**: Large portions of text exist WITHOUT XML tags, defeating their purpose.

**Solution**: Wrap ALL meaningful sections in semantic XML tags.

**Tag Taxonomy by File Type**:

#### Commands (task-*.md)
- `<purpose>` - What this command does
- `<invocation>` - How command is called
- `<critical_setup>` - Immediate pre-flight requirements
- `<agent_whitelist>` - Authorized agents
- `<agent_invocation>` - Instructions for calling agent
- `<error_handling>` - Error scenarios and responses
- `<next_steps>` - What to do after completion
- `<output_format>` - Expected output structure

#### Task Agents (task-developer.md, task-ui.md, task-*.md)
- `<agent_identity>` - Who you are, expertise, values
- `<role_definition>` - Core responsibility
- `<capabilities>` - What you can do
- `<methodology>` - How you work (OODA, TDD, etc.)
- `<instructions>` - Step-by-step workflow (wrap ALL levels/phases)
- `<verification_gates>` - Quality checkpoints
- `<coordination_rules>` - Working with other agents
- `<output_format>` - Deliverable structure

#### Verify Agents (verify-*.md)
- `<role>` - Verification specialty
- `<responsibilities>` - What you verify
- `<approach>` - Verification methodology
- `<blocking_criteria>` - What causes BLOCK
- `<output_format>` - Report structure
- `<quality_gates>` - Pass/fail thresholds

**Rule**: NO meaningful content should float outside XML tags.

### 2. Bold/Uppercase Emphasis (CRITICAL)

**Use Bold (**text**)** for:
- Decision points requiring action
- Critical requirements (MANDATORY, REQUIRED, MUST)
- Blocking criteria
- Quality gate thresholds
- Verification requirements

**Use UPPERCASE** for:
- Acronyms (TDD, OODA, WCAG)
- Warnings (WARNING, DANGER, CRITICAL)
- Strong priorities (NEVER, ALWAYS, BLOCKS)

**Combine Both (**WARNING: TEXT**)** for:
- Maximum attention keywords
- Absolute requirements
- Blocking conditions

**Examples**:
- "**MANDATORY**: All tests must pass" ✓
- "**BLOCKS** on ANY test failure" ✓
- "**LEVEL 0: ABSOLUTE CONSTRAINTS (BLOCKING)**" ✓
- "Rule A1" → "**Rule A1**" ✓

### 3. Instruction Placement (OPTIMAL ORDER)

**Principle**: Critical instructions at TOP (loaded first by Claude).

**Optimal Structure**:
1. YAML frontmatter
2. `<invocation>` - What we're doing
3. `<critical_setup>` - IMMEDIATE must-dos (date awareness, etc.)
4. `<role>` or `<agent_identity>` - Who you are
5. `<requirements>` or `<constraints>` - WHAT MUST BE FOLLOWED
6. `<instructions>` - HOW to do it (step-by-step)
7. `<examples>` - Demonstrations
8. `<output_format>` - Expected deliverable format
9. `<quality_gates>` - Acceptance criteria
10. `<next_steps>` - What happens after

**Rule**: Don't bury critical requirements deep in file.

### 4. Output Format Specification (ADD TO ALL)

**Problem**: Files show example outputs but lack explicit `<output_format>` sections.

**Solution**: Add `<output_format>` section to EVERY file.

**For Commands**:
```xml
<output_format>
## Success Format
[Exact structure user will see]

## Error Format
[Exact structure for failures]

## Report Elements
- [List what must be included]
</output_format>
```

**For Task Agents**:
```xml
<output_format>
## Deliverable Structure
1. [Implementation plan format]
2. [Code documentation format]
3. [Test results format]
4. [Completion report format]

## Quality Requirements
- [Specific formatting standards]
</output_format>
```

**For Verify Agents**:
```xml
<output_format>
## Report Structure
```markdown
## [Agent Name] - STAGE [X]

### [Category]: ❌ FAIL / ✅ PASS / ⚠️ WARNING
- [Specific findings]

### Recommendation: BLOCK / PASS / REVIEW
```

## Blocking Criteria
- [Specific conditions that cause BLOCK]
</output_format>
```

## File-Specific Optimization Strategies

### Command Files
1. Wrap "MANDATORY AGENT WHITELIST" in `<agent_whitelist>` tags
2. Wrap "Purpose" in `<purpose>` tags
3. Wrap "Agent Invocation" in `<agent_invocation>` tags
4. Wrap "Why Use X Agent" in `<rationale>` tags
5. Wrap "Next Steps" in `<next_steps>` tags
6. Bold all "**MANDATORY**", "**FORBIDDEN**", "**IMPORTANT**" keywords
7. Add explicit `<output_format>` section
8. Move critical setup to top (after invocation)

### Task Agent Files
1. Wrap all LEVEL sections (LEVEL 0-4) in `<instructions>` tags
2. Keep `<agent_identity>`, `<role_definition>`, `<capabilities>` at top
3. Bold all rule names: "**Rule A1**", "**Rule C1**", etc.
4. Bold level headers: "**LEVEL 0: ABSOLUTE CONSTRAINTS (BLOCKING)**"
5. Wrap verification gates in `<verification_gates>` tags
6. Add explicit `<output_format>` section showing deliverable structure
7. Ensure all checklists use bold for critical items

### Verify Agent Files
1. Add complete XML tag structure (many have almost none)
2. Wrap "Responsibilities" in `<responsibilities>` tags
3. Wrap "Approach" in `<approach>` tags
4. Wrap "Blocking Criteria" in `<blocking_criteria>` tags
5. Bold all BLOCK conditions: "**BLOCKS** on ANY test failure"
6. Add `<output_format>` section with explicit report structure
7. Bold pass/fail thresholds

## Verification Checklist (Apply to EACH File)

After optimization, verify:

- [ ] ALL meaningful sections wrapped in semantic XML tags
- [ ] NO large untagged portions of text
- [ ] Critical requirements bolded (**MANDATORY**, **BLOCKS**, etc.)
- [ ] Uppercase used for warnings and strong priorities
- [ ] Critical instructions near top of file
- [ ] Explicit `<output_format>` section added
- [ ] Examples wrapped in `<examples>` tags
- [ ] Quality gates wrapped in `<quality_gates>` tags
- [ ] File follows optimal structure order
- [ ] All rule names bolded (if applicable)

## Expected Impact

1. **Clarity**: Claude can distinguish instructions from context from examples
2. **Consistency**: All files follow same structural pattern
3. **Effectiveness**: Critical requirements receive proper emphasis
4. **Predictability**: Explicit output formats ensure consistent responses
5. **Maintainability**: Semantic tags make files easier to update

## Sources

- PROMPTS.md (project root)
- PubNub Best Practices: https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/
- Vellum AI Tips: https://www.vellum.ai/blog/prompt-engineering-tips-for-claude
- Builder.io Guide: https://www.builder.io/blog/claude-code
