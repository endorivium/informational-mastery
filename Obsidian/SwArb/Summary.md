**Architectures of Self-Evolving Software**
**Reference Paper:**

[Darwin Godel Machine: Open-Ended Evolution of Self-Improving Agents](https://arxiv.org/abs/2505.22954)

[Agentic Evolution is the Path to Evolving LLMs](https://arxiv.org/pdf/2602.00359): [[Agentic Evolution Summary]]

**What is the topic about?**  
Various architectures have been proposed for how a self-evolving agent can be built. By self-evolving agent, we mean an agent that can modify its own code, tools, or persistent state, either to satisfy requirements given by a human or based on failures and gaps it identifies on its own during deployment.

The goal is to analyze popular architectures for such agents (e.g., the Darwin Gödel Machine and A-Evolve) and identify the key components that recur across them, what state gets modified (source code vs. persistent artifacts like tools/knowledge/tests), what proposes a change, and what decides whether a proposed change is kept or discarded.

[[General Glossary]]