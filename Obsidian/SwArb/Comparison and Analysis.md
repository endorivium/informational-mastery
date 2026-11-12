The goal is to **analyze popular architectures for such agents** (e.g., the Darwin Gödel Machine and A-Evolve) and identify the <mark style="background: #ABF7F7A6;">key components that recur across them, what state gets modified</mark> (source code vs. persistent artifacts like tools/knowledge/tests), <mark style="background: #ABF7F7A6;">what proposes a change,</mark> and what decides whether a <mark style="background: #ABF7F7A6;">proposed change is kept or discarded.</mark>

# Notes
- no unified naming for components, so hard to equate components
	- source code different from agent harness?
	- difference skill and tool
	- meta agent different from sub-agent?
- should answer these questions for each model individually and then congegrate them into one unified version
- instead of focusing on source code vs. harness, it might make more sense to differentiate between real self-evolving agents (i.e. the agents actively evolve parts of their own behaviour) and self-evolving frameworks (i.e. there is a evolver or similar that is not the agent itself and which does not evolve)
- mention that this work differentiate itself from survey by not actually being a survey and instead reviewing and analysing two specific architectures with some additional architectures that are go into the same conceptual direction and thus augment the differentiation between the two
- when the agent is deployed, when do you actually run these loops to make it self-evolve?
- is there a threshold (benchmark result) for "failed/bad" agents?

# Frameworks (In Depth Analysis)
## Darwin Gödel Machine (DGM)
[[250529 Darwin Gödel Machine (DGM)]]
- "*A key assumption is that an increase in performance on coding benchmarks indicates better coding capabilities, and hence better ability to self-modify and self-improve.*"
- two phase loop:
	- **self-modification phase**: selected coding agents (parent) generate modified version of themselves (child) based on own benchmark evaluation logs
	- **evaluation phase**: each modified agent is tested on a coding benchmark (SWE-bench, Polyglot), only agents with benchmark success and retained edit ability are kept
- further characteristics:
	- **open-ended exploration** where all agents retain a non-zero selection probability
	- **archive** of all previous agents
- best discovered agent changed the following (biggest contributions to improvement): *coding_agent.py, tools/edit.py, llm_withtools.py*
- DGM opens the whole agent repository for improvement to the agent
- within the text DGM refer to this as the *source code*

### Huxley Gödel Machine (HGM)
[[251029 Huxley-Gödel Machine (HGM)]]
- improves on the DGM by *modifying the search and evaluation policy* of new and existing agents: **selection** (evolve or evaluate?), **expansion** (which agent to evolve?), **evaluation** (which agent to test?)
- argue for the occurance of **Metaproductivity Performance Mismatch** where an agent's self-improvement potential mismatches its coding benchmark performance
- uses **Clade-Metaproductivity** to determine how successful the parent agent but especially its descendant are
- else, same architecture as DGM
### Mendel Gödel Machine (MGM)
[[260807 Mendel Goedel Machine (MGM)]]
- further improves on DGM/ HGM by *expanding the self-modification process*
- differentiates between **clonal mutation** (one agent, one trajectory), **reaction-norm mutation** (one agent, multiple trajectories) and **cross-lineage hybridization** (multiple agents, same unsolved task)
- else, same architecture as DGM
## Self-Improving Coding Agent (SICA)
[[250421 Self-Improving Coding Agent (SICA)]]
- while implementation might look like multi agent system, sub-agents do not exhibit enough autonomous behaviour to qualify as their own agents
- same loop as [[260302 Automated Design of Agentic Systems (ADAS, MAS)]], keeping an archive of previous agents and becnhmark results, but meta agent (i.e. agent that finds and implements improvement) comes from archive and is not separate, then evaluating the new agent on benchmarks
-  "*our self-improving coding agent is fully self-improving (i.e. there is no distinction between the meta and target agent), and it operates over the agent's full Python codebase*"

## A-Evolve (AEv)
[[260313 Agentic Evolution (A-Evolve, AEv)]]
- Lin et al. argue that *purely static models inevitably degrade or fail under prolonged deployment* leading to a **train-deploy environment gap** that needs to be overcome via **evolution** which they define as *continual learning for LLM systems during deployment*
	- in their survey, *Gama et al.* talk about **concept drift** where the underlying relationship between a machine learning model's input feature and target variable changes over time, leading to degradation in that model's accuracy:
	- *real concept drift refers to changes in the conditional distribution of the output (i.e., target variable) given the input (input features), while the distribution of the input may stay unchanged.* 
- incorporate an **explicit evolver agent** which diagnoses what to change and when, collaboratively synthesize composable updates and improve both the parametric backbone and the persistent artifact state
- **only changes persistent artifact state** (pg 12) of the target agent, does not evolve the evolver agent
## Meta Agent Search (ADAS, MAS)
[[260302 Automated Design of Agentic Systems (ADAS, MAS)]]
- MAS is split into Design - Evaluation - Update steps, involving a meta agent and an archive of designed agents
	- designs a new agent via a high-level description of a new idea for an agentic system
	- then implements it
	- undergoes two self-reflection steps and ensures the agent's novelty
	- agent is evaluated on target domain (and re-designed up to five times if it fails)
	- agent is added to archive
	- return final archive of designed agents
## Evo Harness (EH)
[[260815 Evo-Harness (EH)]]
- specifically split solver, evolver, feedback source and initial harness state
- 



# Comparison Summary
- do it high level (basic loop) and if possible, then in detail (cf. SICA implementation with sub-agents)

|      | Baseline Loop | Implemen-tation | Comp-onents | Bench-marks | Effective-ness | Code                                                                     |
| ---- | ------------- | --------------- | ----------- | ----------- | -------------- | ------------------------------------------------------------------------ |
| SICA |               |                 |             |             |                | [GitHub](https://github.com/MaximeRobeyns/self_improving_coding_agent)   |
| MAS  |               |                 |             |             |                | [GitHub](https://github.com/ShengranHu/ADAS)                             |
| EH   |               |                 |             |             |                | [GitHub](https://github.com/A-EVO-Lab/a-evolve/tree/release/evo-harness) |
| AEv  |               |                 |             |             |                | [GitHub](https://github.com/A-EVO-Lab/a-evolve)                          |
| DGM  |               |                 |             |             |                | [GitHub](https://github.com/jennyzzt/dgm)                                |
| HGM  |               |                 |             |             |                | [GitHub](https://github.com/metauto-ai/HGM)                              |
| MGM  |               |                 |             |             |                | [GitHub](https://github.com/RealLcz/MGM)                                 |

