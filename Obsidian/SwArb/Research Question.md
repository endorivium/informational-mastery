**Architectures of Self-Evolving Software**
**Reference Paper:**

[Darwin Godel Machine: Open-Ended Evolution of Self-Improving Agents](https://arxiv.org/abs/2505.22954): [[2025-05 Darwin Gödel Machine (DGM)]]

[Agentic Evolution is the Path to Evolving LLMs](https://arxiv.org/pdf/2602.00359): [[2026-01 Agentic Evolution (A-Evolve)]]

**What is the topic about?**  
Various architectures have been proposed for how a self-evolving agent can be built. By self-evolving agent, we mean an **agent that can modify its own code, tools, or persistent state**, either to satisfy requirements given by a human or based on failures and gaps it identifies on its own during deployment.

The goal is to **analyze popular architectures for such agents** (e.g., the Darwin Gödel Machine and A-Evolve) and identify the <mark style="background: #ABF7F7A6;">key components that recur across them, what state gets modified</mark> (source code vs. persistent artifacts like tools/knowledge/tests), <mark style="background: #ABF7F7A6;">what proposes a change,</mark> and what decides whether a <mark style="background: #ABF7F7A6;">proposed change is kept or discarded.
</mark>

# Notes
- [[2025-07 Survey of SE Agents]] by Gao et al. was released in Jan 2026, DGM was released before it, A-Evolve was released afterwards
- maybe also look at the merit of using benchmarks to evaluate the improvement of an agent
- alternate research question: *an analysis and comparison of AI agent gödel machines*
	- define gödel machine and analyse approximation thereof
	- evaluate approaches to implementation (e.g. benchmark evaluation)