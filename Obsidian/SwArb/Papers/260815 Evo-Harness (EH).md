Wei et al. (15 Aug 2026 | 30 Aug 2026)
[arXiv:2608.15071](https://arxiv.org/abs/2608.15071) | [GitHub](https://github.com/A-EVO-Lab/a-evolve/tree/release/evo-harness)

**Short Summary**: propose *Evo-Harness* framework which converts one-shot execution context into a reusable harness that guides future task solving, using *online harness learning* where a frozen agent continually improves by updating a structured harness across sequential tasks
![[Pasted image 20261106154825.png]]

- define harness as "an external scaffold that structurally shapes future planning"
- **Evo-Harness** consists of
	- *context-to-harness skill compilation* which converts individual execution contexts into resuable skill harness updates
		- *solver* reflects on the context and proposes candidate skills
		- *evolver* updates existing harness
	- two stages
		- *execution reflection*: 
		- *harness evolution*: receives the candidate memories and current harness, creating a set of harness edits
			- evolver filters noisy/redundant memories, merges compatible signals, revises existing guidance, promotes reusable lessons
- **Skills** are split into
	- *general skills* which are cross-task transferable patterns
	- *topic skills* which are localized operational knowledge

![[Pasted image 20261106154843.png]]

