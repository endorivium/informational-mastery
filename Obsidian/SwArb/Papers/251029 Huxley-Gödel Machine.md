Wang et al. (24 Oct 2025 | 29 Oct 2025) | [arXiv:2510.21614v3](https://arxiv.org/abs/2510.21614v3)
[GitHub](https://github.com/metauto-ai/HGM)
**Short Summary**: Wang et al. propose the 
![[Pasted image 20261021204455.png]]
- **Compound Policy**: compound decision occurs at each step of self-improvement; expand tree by generating new agents or evaluate existing ones? 
	- *selection policy* chooses between expansion and evaluation
	- *expansion policy* determines which parent to modify
	- *evaluation policy* selects an agent to test

- **Metaproductivity**: an agent's ability to enhance its own self-improvement skills over time rather than just solving an immediate task
- **Global Metaproductivity (GMP)**: system-wide metric that tracks how evolution of a single agent impact the long-term evolutionary potential of the entire agent tree, difficult to calculate globally
	- **Clade-Metaproductivity (CMP)**: localized variant that focuses on a subtree rooted at a given agent (i.e. its clade), evaluates an agent based on the collective success of its descendants
- **Metaproductivity-Performance Mismatch (MPM)**: divergence between short-term task performance and long-term capacity for self-improvement (as measured by CMP)

**Huxley Gödel Machine (HGM)**
- *Expansion Policy*: estimate CMP using weighted average of agents' empirical performance in the clade (value between 0 and 1)
	- ![[Pasted image 20261021184238.png]]
	- n_c_success: num of successful downstream descendants (i.e. self-improvements), num of passed tests of a
	- n_c_failure: num of unsuccessful downstream descendants, num of failed tests of a
	- "weighted sum over the empirical means of agents in C(a), with weight for an agent being the number of task evaluations it has performed"
- *Evaluation Policy*: select highest scoring agent using **Thompson Sampling**
- *Selection Policy*: how and when to eval or expand agents inspired by *infinite-armed bandit*. when number of evaluations >= numbers of existing agents in a clade, then expand agents else eval, i.e. expand when all agents evaluated?
- HGM executes policies until budgets exceeds and returns *best-belief agent* ![[Pasted image 20261021185309.png]]
- benchmarks used: SWE-bench Verified, SWE-bench Lite, Polyglot