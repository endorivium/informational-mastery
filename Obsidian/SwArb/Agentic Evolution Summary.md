[[General Glossary]]

<span style="color:rgb(146, 208, 80)">Evolution</span>: `continual learning for LLM systems during deployment`
<span style="color:rgb(146, 208, 80)">Evolution Scaling Hypothesis</span>: `the capacity for adaptation—the achievable performance frontier of evolution—scales with the compute allocated to the evolution process`

Short Summary: The train deploy environment gap necessitates an evolution of the LLM during deployment or it will become obsolete with time and fail at its tasks. Previous evolution methods are too static and heuristic, agentic evolution proposes the usage of agents within the evolutionary process via an explicit evolver agent, a goal-directed optimizer who diagnoses necessary changes, autonomously plans those changes and creates updates to both the parametric backbone and the persistent artifact state.

- the behaviour of an LLM is determined by a<span style="color:rgb(146, 208, 80)"> composite policy π = (πθ , πS ) </span>where the first is the `parametric backbone` (i.e. params that governs LLM resposne, e.g. LLM weights), whereas the second is the `non-parametric persistent artifact state` (e.g. tools, code, memories, structured knowledge) [1]
- `Evolution corresponds to cross-episode policy improvement driven by accumulated experience`:
	 ![[Pasted image 20261008165757.png]]
- Obs is deployment observations (e.g. interaction traces, environ feedback rewards) F-Evolve is update mechanism, i.e. converts observation into lasting behavioral improvement
-  due to the <span style="color:rgb(146, 208, 80)">train-deploy environment gap</span>, `purely static models inevitably degrade or fail under prolonged deployment` [1]
- to overcome this gap, evolution method needs to be <span style="color:rgb(255, 192, 0)">adaptative</span> and <span style="color:rgb(255, 192, 0)">goal-directed</span> (<span style="color:rgb(146, 208, 80)">parametric</span> (update 0, risk catastrophic forgetting) and <span style="color:rgb(146, 208, 80)">non-parametric heuristic evolution</span> (update S, use fixed rules) methods are static and heuristic)
- `common root cause: [..] absence of agentic capability in the evolution process itself`, i.e. methods don't know how to diagnose, plan and execute necessary updates to the LLM, so evolution actually needs to be <span style="color:rgb(255, 192, 0)">agentic</span>
	`The central idea is to elevate FEvolve from a fixed, heuristic-driven workflow to an explicit evolver agent—a goal-directed optimizer that  diagnoses what to change, autonomously governs when to change, and collaboratively synthesizes composable updates to maintain and improve both the parametric backbone πθ and the persistent artifact state πS`  (would use validation gate to verify fix)
- characterized by three core principles: 
	- <span style="color:rgb(146, 208, 80)">goal-oriented principle</span>: what to change, explicitly diagnoses deployment failures and their causes, finds possible component that can be improved for better performance in future
	- <span style="color:rgb(146, 208, 80)">autonomy principle</span>: when to change, finds relevant evidence/failures that need a reaction
	- <span style="color:rgb(146, 208, 80)">compositional principle</span>: how to evolve, using diagnosis, planning, updating and verification based on shared evidence and state, produces <span style="color:rgb(255, 192, 0)">modular structured artifacts</span>
- `budgeted optimizer` that does all this under a `finite evolution-time compute budget`
- three axis: <span style="color:rgb(255, 192, 0)">training-time, inference-time and "evolution-compute-time"</span>
- <span style="color:rgb(255, 192, 0)">evolver agent</span> treats evolution as decision-making problem
	- `At each episode t, it proposes a structured candidate update ∆t, such as add, patch, refactor, or prune operations over πS and/or πθ , and makes an explicit commit decision`
- <span style="color:rgb(146, 208, 80)">Amortization</span>: agentic evolution amortizes repeated inference-time reasoning into durable, governed capability, transforming recurrent failures into stable system assets, i.e. regularily fixes failures

- A-Evolve implements previously mentioned three principles:
	- goal-oriented: explicit update objective based on deployment evidence, proposes targeted edits over a structured space
	- autonomous: conditional updates that are initiated by explicit evidence selection, commit/no-opertation (no-op) decision
	- compositional: modular evolver that produces typed artifacts, commits happen only via explicit acceptance mechanisms (e.g. validation, review)
- <span style="color:rgb(0, 176, 240)">πS</span> now consists of ![[Pasted image 20261008182226.png]] where K is <span style="color:rgb(0, 176, 240)">knowledge registry</span> (structured or textual artifacts that are addressable and versioned, e.g. schemas, workflows, interface contracts), T is <span style="color:rgb(0, 176, 240)">tool registry</span> (executable function, e.g. scripts, API wrappers) and V is <span style="color:rgb(0, 176, 240)">validation registry</span> (governance assets, e.g. unit tests, regression suites. opt human review hooks)
- separates instance level task execution and cross-episode capability improvement
- Solve-Evolve Loop: 
	- solve phase produces trajectory T based on episode t with input x_t_
	- evolve phase produces conditional update ![[Pasted image 20261008182952.png]] where delta t is a structured update and c_t_ is the given decision (commit/no-op)
- `solve-time compute targets task completion, while evolve-time compute targets amortized improvement across episodes`
- The Evolver implements four cooperating functions: ![[Pasted image 20261008183223.png]]
	- Diagnose: identifies actionable failure modes and their causes
	- Plan: translates Diagnose into explicit edit plan (target artifact, edit operators, constraints)
	- Update: executes plan via synthesis of concrete artifact changes
	- Verify: evaluates update against validation registry and returns commit decision
