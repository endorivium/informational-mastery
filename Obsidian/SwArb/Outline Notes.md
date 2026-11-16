The goal is to **analyze popular architectures for such agents** (e.g., the Darwin Gödel Machine and A-Evolve) and identify the <mark style="background: #ABF7F7A6;">key components that recur across them, what state gets modified</mark> (source code vs. persistent artifacts like tools/knowledge/tests), <mark style="background: #ABF7F7A6;">what proposes a change,</mark> and what decides whether a <mark style="background: #ABF7F7A6;">proposed change is kept or discarded.</mark>

**notes**:
- clearly establish boundary of paper as analysis and comparison of specifically two architectures with other architecures as supporting examples
- highlight the problem of non-unified technical terms within this research field
- no unified naming for components, so hard to equate components
	- source code different from agent harness?
	- difference skill and tool
	- meta agent different from sub-agent?
- should answer these questions for each model individually and then congegrate them into one unified version
- instead of focusing on source code vs. harness, it might make more sense to differentiate between real self-evolving agents (i.e. the agents actively evolve parts of their own behaviour) and self-evolving frameworks (i.e. there is a evolver or similar that is not the agent itself and which does not evolve)
- mention that this work differentiate itself from survey by not actually being a survey and instead reviewing and analysing two specific architectures with some additional architectures that are go into the same conceptual direction and thus augment the differentiation between the two
- when the agent is deployed, when do you actually run these loops to make it self-evolve?
- is there a threshold (benchmark result) for "failed/bad" agents?
- section about selection of architectures: why were they chosen, what separates them, etc
- small note about validity of benchmarks as measurement
- don't follow template structure, add summary
- DGM means agent harness when referring to source code, crossreference if all other papers also mean agent harness/ what exactly they are changing

- *what proposes a change and what decides whether a proposed change is kept or discarded* is not really applicable to these architectures but could be subject of future research

**literature review**
- should define the modules of an agents which can later be evolved
- mention existing surveys and establish paper boundary
- take over definitions based on surveys if possible
- give definitions for harness vs source code

**architectures**
- do it high level (basic loop) and if possible, then in detail (cf. SICA implementation with sub-agents)

**components of an SE agent**
- summarise self-evolve loop (as demonstrated in DGM and AEv)
- discuss how the main difference between the two is the evolution of the meta agent itself as opposed to just evolving the main agent itself

1. **Introduction**
	- percentage of developers using coding agents
	- train deploy environment gap 
2. **Literature Review**
	1. *Existing Surveys*
		- `Fang Survey`: provides definitions and conceptual framework for multi-agent self-evolving systems
		- `Zhou Survey`: on self-evolving coding agents and how they adapt and improve across tasks using executable feedback, establishes taxonomy that separates SE coding agents from static coding assistant and general SE agents
		- `Gao Survey`: split their survey into what, when, how, where and evaluation
	2. *Definitions*
		- give definition of a self-evolving (coding) agent and its components
		- discuss problem of non-unified technical terms for concepts that are the same
		- discuss source code vs harness; for clarity, this paper will instead differentiate between split and fused self-evolving agents
3. **Architectures**
	1. *Split Self-Evolving Agents*
		- architectures that keep the meta agent separate from the agent being involved
		1. `A-Evolve`
			- solve-evolve phases, evolve phase split into diagnose-plan-update-verify, keeps a cumulative evidence buffer that is accumulated during solve and consumed during evolve
		2. `Meta-Harness`
			- outsources evolution to coding agent (here: Claude Code with Opus-4.6) with full access to whole harness filesystem
		3. `Evo-Harness`
			- select harness, inject into task (out: exec context), reflect on context (out: memory), filter and merge candidate memories, evolve harness
	2. *Fused Self-Evolving Agents*
		- architectures where the meta agent and the agent being evolved are the same
		1. `Self-Improving Coding Agent`
			- takes best performing agent, indentifies improvement based on whole archive, implements the improvement
		2. `Darwin Gödel Machine`
			- self-modification and eval phases with open-ended exploration (any previous agent can be chosen), generates modified version of self based on benchmark eval logs
		3. `Huxley Gödel Machine`
			- based on DGM but decouples expansion from evaluation by splitting it into selection (expand or eval?), expansion (select parent and self-modify) and evaluation (select agent and evaluate)
			- evaluation is modified to include benchmarks of all descendants (Clade-Metaproductivity) to evaluate long-term improvement with given agent as the seed
				- prioritizes well-performing clades since they demonstrate high long-term potential for better agents
		4. `Mendel Gödel Machine`
			- based on DGM and HGM by splitting expansion into three subtypes depending on available agents and task trajectories
4. **Components of a Self-Evolving Agent**
	1. `Self-Evolve Loop`
	2. `Evolving the Meta Agent`
	3. `When to Evolve`
5. **Further Discussion**
	-  [[261016 SE Agents Failure Repair Generalization]] tested Evo-Harness and hypothesize if truly self-evolving agents (such as DGM) would overcome this gap
	- safety concerns of unified self-evolving agents
6. **Conclusion**