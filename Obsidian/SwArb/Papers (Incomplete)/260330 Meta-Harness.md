Lee et al. (30 Mar 2026) | [arXiv:2603.28052](https://arxiv.org/abs/2603.28052) 
[Website](https://yoonholee.com/meta-harness/) | [GitHub](https://github.com/stanford-iris-lab/meta-harness-tbench2-artifact)

- provides interactive website and evolved harness artifact

**Short Summary**: Uses a **proposer** (separate coding agent) which decides *what to inspect* validates edits through direct interaction with the codebase, has *filesystem access* (source code, evaluation scores, execution traces) and executes selective diagnosis of raw prior code and execution traces, also has an archive of previous harnesses

![[Pasted image 20261115211408.png]]

- everything is outsourced to proposer
- *no parent-selection rule*; proposer is allowed to inspect any prior harness
- "Meta-Harness can improve automatically as coding agents become more capable"
- practical implementation: each harness is a single-file Python program that modifies task-specific prompting, retrieval, memory, and orchestration logic, proposer is Claude Code with Opus-4.6
- *filesystem contains all prior candidates' source code, execution traces and scores*