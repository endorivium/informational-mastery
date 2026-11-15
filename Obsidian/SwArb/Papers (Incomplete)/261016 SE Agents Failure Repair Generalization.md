Zhao et al. (16 Oct 2026) | [arXiv:2610.22984](https://arxiv.org/abs/2610.22984)

**Short Summary**: Zhao et al tested SE agents in an environment where there is no positive learning signals (such as successful trajectories, verifier feedback, etc) available (Cold-Start Failure-Only Evolution CFOE), arguing that in challenging open environments these signals may be unavailable when adaptation in response to novelty is most needed. Here, the **repair–generalization gap** describes how "*failure-derived experience can partially recover previously failed tasks, yet these gains rarely translate into sustained improvements on unseen tasks and may even degrade held-out performance*."
Current agents are better at repairing observed failures than at generalizing those failures into transferable capabilities, highlighting a fundamental challenge for autonomous learning in open environments.
Tested ReasoningBank, SkillOpt and Evo-Harness against 10 different LLM backbones.

- can extract useful local correction from failed interactions but struggle to turn them into transferable skill
- unreliable failure interpretation and limited transferability of even correct experiences
- successful behavioral evidence is substantially more supporting for transferable evolution than richer failure diagnosis




