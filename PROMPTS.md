# Prompt Engineering Guidelines for Claude Code

The most effective prompt engineering techniques for Claude Code center around structured instructions, the use of sub-agents, emphasis styling (bold/uppercase), and optimal placement of instructions for code commands and workflows. These strategies give the highest-quality AI responses and reliable automation in Claude Code environments.[1][2][3][4]

## Structured Prompt Writing

- Use a clear, organized format with instructions separated from context, often via XML-style tags (e.g., `<instructions>`, `<example>`, `<context>`) to help Claude distinguish different prompt elements.[3][1]
- Place primary instructions and context near the beginning of the `.md` command file or within the dedicated `CLAUDE.md` file in your project directory, as these are loaded first by Claude agents at session start.[5][6]

## Bold and Uppercase Emphasis

- For emphasis, Claude Code responds well to Markdown bold (`**word**`) for short, critical terms or instructions—especially where a decision or action is required.[1]
- UPPERCASE is recognized and useful for acronyms, warnings, and strongly prioritized instructions, but should be used sparingly to avoid dilution of urgency or meaning.
- Combine bold and uppercase only for highly important keywords (example: `**WARNING: DO NOT DEPLOY**`) for maximum model attention in generated responses.[1]

## Claude Code Sub-Agents Best Practices

- Sub-agents should have their own markdown/YAML frontmatter, including name, description, and (optionally) allowed tool lists, stored in `.claude/agents/` for modular and discoverable workflows.[4]
- Assign sub-agents explicit system prompts defining their role (e.g., "Implementer," "Tester," "Architect"), context window limits, and step outputs to achieve task separation and reproducibility.
- Use hooks and chaining to pass outputs between agents; this ensures governance, separation of concerns, and parallelism, enhancing reliability across software pipelines.[6][4]

## Instruction Location in Files

- Place key instructions in `CLAUDE.md` for project-wide context and in each `.md` command or agent file for command-specific info; this enables Claude to load relevant information at runtime and support both individual and team workflows.[5]
- You may also reference other files using `@filename` syntax to dynamically pull in contextual instructions or standards as needed.[5]

## Iterative Refinement and Output Formatting

- Request a specific output format (e.g., Markdown, JSON, table) in your prompt to control Claude Code's response structure.[2]
- Iterate: Start with general instructions, review results, and refine progressively for complex automation tasks, leveraging chain-of-thought and chaining techniques to increase clarity and depth in reasoning.[3]

## Summary Table

| Technique                    | Details                                                 | Placement/Syntax                    |
|------------------------------|--------------------------------------------------------|-------------------------------------|
| Structured Prompts           | XML/Markdown tags; chain-of-thought reasoning          | `<instructions>`, `<context>`, or top of `.md` file [1][3]      |
| Bold/Uppercase               | Use Markdown for key terms, UPPERCASE for urgency      | `**IMPORTANT**`, `WARNING`          |
| Sub-Agent Role Definition    | Distinct agents, YAML/Markdown frontmatter             | `.claude/agents/` subdirectory      |
| Hooks/Chaining               | Connect agent outputs via hooks, scheduler, permissions| `.claude/settings.json`/`/hooks` command [6]      |
| Instruction Location         | `CLAUDE.md` for global, `.md` for specific commands    | Project root or relevant directory  |
| Iterative Refinement         | Review-refine loop, conversation-based improvements    | Adjust sequentially in session      |

Applying these practices systematically gives you clearer, more reliable Claude Code output and ensures teams or solo developers reap consistent automation benefits.[7][2][4][6][3][1][5]

[1](https://www.vellum.ai/blog/prompt-engineering-tips-for-claude)
[2](https://claudecode.io/guides/prompt-engineering)
[3](https://www.walturn.com/insights/mastering-prompt-engineering-for-claude)
[4](https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/)
[5](https://www.linkedin.com/pulse/claude-code-best-practices-newbies-guide-learning-from-rafael-knuth-l9zzf)
[6](https://www.builder.io/blog/claude-code)
[7](https://www.siddharthbharath.com/claude-code-the-complete-guide/)
[8](https://www.anthropic.com/engineering/claude-code-best-practices)
[9](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)
[10](https://docs.claude.com/en/docs/build-with-claude/prompt-engineering/overview)
