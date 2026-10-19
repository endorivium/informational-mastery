Fang et al.
[Research Paper](file:///D:/Users/Julia%20Ihrenberger\Documents/1_Studium_Informatik/informational-mastery/SwArb/finished/FangEtAl_ComprehensiveSurveySelfEvolvingAIAgents.pdf)

**Short Summary**: defines self-evolving AI agents, describes their anatomy and proposes a framework for multi-agent self-evolving


- typical AI agent consists of several components with a "**foundation model** (e.g. an LLM) [as] the core, responsible for interpreting goals, making plans, and executing actions"
- **multi-agent systems (MAS)** consist of multiple agents that collaborate to solve complex problems, allowing for functional specialisation of the individual agents (e.g. for specific subtask or domain of expertise)

Definition of Self-evolving AI agents:
	`"Self-evolving AI agents are autonomous systems that continuously and systematically optimise their internal components through interaction with environments, with the goal of adapting to changing tasks, contexts and resources while preserving safety and enhancing performance."`

**Anatomy of an AI Agent**
- *Foundation Model*: most commonly an LLM, central reasoning engine responsible for interpreting instructions, generating plans, and producing actionable responses
- *Perception Module*: acquiring and interpreting information from the environment (citing)
- *Planning Module*: decompose complex tasks into actionable sub-tasks or sequence of operations, guide execution
- *Memory Module*: retain and recall past experience, enabling context-aware reasoning and long-term consistency; short-term (specific to current task) and long-term memory (across multiple tasks)
- *Tool Use*: key factor for AI agents to effectively operate in real-world scenarios

- defines, inspired by Asimov's three laws of robotics, three laws of SE-AI agents:
	I. **Endure** (Safety Adaptation)
	Self-evolving AI agents must *maintain safety and stability* during any modification;
	II. **Excel** (Performance Preservation)
	Subject to the First law, self-evolving AI agents must *preserve or enhance existing task performance*;
	III. **Evolve** (Autonomous Evolution)
	Subject to the First and Second law, self-evolving AI agents must be able to *autonomously optimise their internal components* in response to changing tasks, environments, or resources.

- **Multi-Agent Self-Evolving** (MASE): lifelong, self-evolving loop where a population of agents continually refines their prompts, memory, tool-use strategies and even their interaction patterns based on environmental feedback and meta-rewards (citing arXiv:2506.13131)

**Conceptual Framework of MASE**
- four core components:
	- ***System Inputs***: contextual information and data provided to the optimisation process, define the problem setting for the agent system and determine the scope of optimisation
		- *Task-Level Optimisation*: task-specific improvement of the agent system's performance
		- *Instance-Level Optimisation*: (being explored) more fine-grained setting, instance-specific enhancement/improvement
	- ***Agent System***: core component in feedback loop subject to optimisation, defines decision-making process and functionality of the agent(s) in response to given inputs
		- can be further decomposed into e.g. underlying LLM, prompting strategy, memory module, tool-use policy
	- ***Environment***: external context in which agent sys operates and generates outputs, receives inputs from environ, sys executes actions, receives corresponding outcomes
		- generates feedback signals that inform and guide optimisation process
	- ***Optimiser***: core comp of self-evolving feedback loop, responsible fo refining agent sys based on performance feedback from environ
		- two core components: *search space* (set of agent configs that can be explored and optimised), *optimisation algo* (specifies strategy used to explore search space and select/generate agent candidate configs)
