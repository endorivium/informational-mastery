# Agent Harness
[LangChain Overview](https://docs.langchain.com/oss/python/langchain/overview?ref=blog.langchain.com) defines a harness as "*everything around the model loop: the prompt, tools, and any middleware that shapes behavior*".

[Vivek Trivedy](https://www.langchain.com/blog/the-anatomy-of-an-agent-harness) (leading Applied Research at LangChain Labs) from LangChain defines a harnes as "*every piece of code, configuration, and execution logic that isn't the model itself*". An LLM by itself is not an agent and only becomes one with a harness which "*gives it things like state, tool execution, feedback loops, and enforceable contraints*".
LangChain defines "*Agent = Model + Harness*".
# Agent Skill
**251016 Agent Skill - Anthropic**
- defines it as "*organized folders of instructions, scripts, and resources that agents can discover and load dynamically to perform better at specific tasks.*"
- purpose: transform **general purpose agent into specialized** one while not overloading the context
- consists of **SKILL.md** file with name and description 
- makes use of **progressive disclosure** to keep context window clutter free
	- *first level*: meta data which provides info on skill usage
	- *second level*: body is fully loaded into context window
	- *third level* and beyond: skill is further split into sub skills that link to additional files within the skill directory

# Anatomy of an AI Agent
from [[250831 Fang Survey of SEAI Agents]]
- *Foundation Model*: most commonly an LLM, central reasoning engine responsible for interpreting instructions, generating plans, and producing actionable responses
- *Perception Module*: acquiring and interpreting information from the environment (citing)
- *Planning Module*: decompose complex tasks into actionable sub-tasks or sequence of operations, guide execution
- *Memory Module*: retain and recall past experience, enabling context-aware reasoning and long-term consistency; short-term (specific to current task) and long-term memory (across multiple tasks)
- *Tool Use*: key factor for AI agents to effectively operate in real-world scenarios

# Context Window
[Claude](https://platform.claude.com/docs/en/build-with-claude/context-windows) defines a context window as "*all the text a language model can reference when generating a response, including the response itself (...) (representing) a "working memory" for the model*". It **progressively accumulates tokens** (user messages, assistant response) during its **input-output loop** where all previous conversation history constitutes the input and the generated response is the output which turn becomes part of the input again.
