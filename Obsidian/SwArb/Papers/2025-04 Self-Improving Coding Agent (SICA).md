Robeyns et al. (21 April 2025 | 16 May 2025) | [arXiv:2504.15228v2](https://arxiv.org/abs/2504.15228v2)

- **agent systems**: code that orchestrates LLM calls and provides them with tools
- **meta agent**: agent which improves the target agent
- **target agent**: agent which is used for a given task and needs to be improved

**Short Summary**: SICA is a multi-agent system that 


**Architecture**
- *SWE Bench Verified* as benchmark for improvement
- multi agent system
- *initial agent* has the following:
	- *main agent* which is just the delegator, router and orchestator
	- *tool set* (file management, shell commands, calculator tool, basic validation tools via a benchmark roblem)
	- *sub-agents* that accepts and execute an input argument and return a string value, three different agents (coding agent, problem-solver agent, reasoning agent)
	- *asynchronous overseer* which is an LLM running periodically in a concurrent thread and intervenes if the currently running agent shows deviations from the task
- *archive* of previous agents and their benchmark result
- 'best' performing agent is defined via a utility function
- improvement run has timelimit
- **Meta Agent Loop**
	- take best performing agent from archive
	- look at archive and identify possible improvement (e.g. via code or tool weaknesses)
	- implement improvement
- in practice, this looks as follows:
	- (invoked via main agent) archive explorer agent analyses archive via comparison of different iterations (best perfomring to understand success cases, worst performing to find failure modes)
	- two reasoning agents reason over the found information and return a recommendation to main agent
	- main agent invokes software developer agent to implement the recommended feature, test it and document it on success
	- implementation is verified via second software developer agent
- *improvements* of file management tools (efficiency, speed), code interaction, token usage 

