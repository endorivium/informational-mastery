# AI Agents Explained (Video)
[Video](https://youtu.be/ZvDkJsKE80k?si=YWPapJd9V4N5utZs)
- *chat bot*: talks (responds to input via prediction), LLM
- *agent*: can take actions in real world (**tool-calling**), can keep going on its own (**loop**) until task completion

- **tool-calling**: generates text that tells whatever software it's working inside of to call a tool
	- e.g. agent makes web search request which is code running the model reads, executes and then sends the output back to the agent
- **Model**: decides what to do
- **Code**: runs the model and what's actually doing the commands, triggering the search tool, etc
- **Context**
	- **Context Window** (short-term working memory): everything the agent can see at one time (e.g. instructions, tool calls, etc), has limited space
		- **Context Engineering**: deciding what to put in the context window at one time to optimize space usage
	- **System Prompt**: sets the rules; who the agent is and how it should behave (e.g. "you are a lab assistant working on...")
	- **User Messages/ Assistant Messages (Message Roles)**: input from person/system (user) vs response from model (assistant)
	- **Vector Database**/ **RAG**: storage of embeddings based on documents/data which the model can query, allows the storage of more data than can fit in the context window
- **Think-Act-Observe-ThinkAgain (agentic loop)**:
	- thinks about system prompt and goal
	- decides to use tool and sends action
	- code runs tool and returns result, model observes result
	- model looks at results and decides what to do next

**How to build an Agent** (according to video, four levels)
- based on four decisions:
	- platform (for the framework)
	- model (e.g. GPT, Claude)
	- context (what info to give, possible access to data base)
	- control flow (decision tree, types of tools available to agent)
- *No Code*: creation of a custom agent via an agent builder (e.g. Lindi, Gumloop), general agent
- *Low Code*: higher customisation but does not run in an IDE (e.g. n8n, Flowise), drag'n'drop editor, allows customisation of workflow etc
- *Agent Harness*: install complete agent and customise it (e.g. OpenClaw, Hermes), agentic loop already exists
- *Full Code*: implement the full loop in e.g. LangGraph, Python

# What is an AI Coding Agent? (Article)
[Article](https://www.mindstudio.ai/blog/what-are-ai-coding-agents)
- underlying model is always an LLM which handles **reasoning, planning** and **code generation**
- **Tool Use**: in coding context, e.g. file system access (read-write), terminal execution (shell cmds, install pckgs, exec scripts), web search, code execution, browser control, external APIs
- **planning layer**: task decomposition, dependency identification, sequence of steps
- **execution loop**: write/modify code, run code/tests on code, read output, evaluate

# Agent Harness vs Agent Framework
[Article](https://www.truefoundry.com/blog/agent-harness-vs-agent-framework-whats-actually-different)

An **agent framework** gives you the primitives to build an agent: nodes, edges, state, and roles. You write the control flow. An **agent harness** is the finished runtime: the loop already works, and it handles context, sandboxing, approvals, and session state for you.

The simplest way to think about it:
• **Frameworks are for building agents.** You define the flow and assemble the pieces.
• **Harnesses are for running them.** The core loop and operational machinery are already built in.
# Agent Skills vs Tools
[Article](https://atlan.com/know/ai-agent/ai-agent-skills/agent-skills-vs-tools/)

A **tool** is a *single, deterministic function call*: one input, one output, no judgment involved. An **agent skill** is composed *procedural knowledge that decides which tools to call, in what order, and why*, the layer that manages a tool catalog whose every schema loads into context on every turn. Atlan's own MCP server is one concrete tool surface a skill's sequencing logic calls into, but neither a tool's schema nor a skill's instructions certify that what comes back is current or trustworthy, that check happens one layer down, in the context layer underneath both.

Core Components:
1. Tool: a single, deterministic function call with one input and one output
2. Skill: composed procedural knowledge that decides which tools to call, in what order, and why
3. Token cost: every available tool loads its full schema each turn; a skill loads its body only when triggered
4. Shared gap: neither a tool schema nor skill instructions certify that returned data is current

further articles: [Distinction](https://www.arcade.dev/blog/what-are-agent-skills-and-tools/) 
