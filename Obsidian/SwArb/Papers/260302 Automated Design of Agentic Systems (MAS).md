Hu et al. (15 Aug 2024 | 02 Mar 2026) | [arXiv:2408.08435](https://arxiv.org/abs/2408.08435) | [GitHub](https://github.com/ShengranHu/ADAS)

**Short Summary**: proposes a new research area *Automated Design of Agentic Systems* where the automatic creation of agentic system design, including the invention of new or combination of existing building blocks.
presents *Meta Agent Search* as a proof of concept within this new research area, consisting of a *meta agent* that creates new and interesting agents, which are then added to an archive, helping future agent creation
"position Automated Design of Agentic Systems in both the first and second pillars: meta-learning agentic architectures and  leveraging in-context learning to “learn to learn”"

**ADAS** consists of
- *Search Space* defines which agentic systems can be represented and discovered determined by the components which are provided for mutation, i.e. the baseline agent and the target evolution component
- *Search Algorithm* defines how the search space is explored, should ideally be fast, discover high-performance system while not getting stuck in a local optimum
- *Evaluation Function* defines the objective to optimize such as performance, cost, latency or safety of agents

**Meta Agent Search (MAS)** builds an archive of agents after x maximum iterations and consists of
- the *meta agent* which programs new agents based on
- an *archive* of previously discovered agents
	- optionally initialized with a baseline agent
	- archives agent and its evaluation metric
- evaluation via *validation data* from the target domain
- *self-reflection* to ensure the novelty of the new agent
![[Pasted image 20261106135404.png]]

Case Study via ARC challenge
![[Pasted image 20261106135426.png]]
![[Pasted image 20261106135504.png]]

- authors hypothesize that if an FM does not have sufficient knowledge to solve a problem, then improvement via optimization of the agentic system is limited
- futhermore, FM has sufficient knowledge for Reading Comp and Math, so errors could stem from hallucinations or calculation mistakes -> can be mitigated via MAS
- discovered agents have a certain degree of transferability which outperforms hand-designed baselines but cannot match agents specifically designed for the domain



