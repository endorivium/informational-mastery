The goal is to **analyze popular architectures for such agents** (e.g., the Darwin Gödel Machine and A-Evolve) and identify the <mark style="background: #ABF7F7A6;">key components that recur across them, what state gets modified</mark> (source code vs. persistent artifacts like tools/knowledge/tests), <mark style="background: #ABF7F7A6;">what proposes a change,</mark> and what decides whether a <mark style="background: #ABF7F7A6;">proposed change is kept or discarded.</mark>

# Notes
- no unified naming for components, so hard to equate components
	- source code different from agent harness?
	- difference skill and tool
	- meta agent different from sub-agent?
- should answer these questions for each model individually and then congegrate them into one unified version

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

### Huxley Gödel Machine (HGM)
[[251029 Huxley-Gödel Machine (HGM)]]

### Mendel Gödel Machine (MGM)
[[260807 Mendel Goedel Machine (MGM)]]

## A-Evolve (AEv)
[[260313 Agentic Evolution (A-Evolve, AEv)]]

## Self-Improving Coding Agent (SICA)
[[250421 Self-Improving Coding Agent (SICA)]]

## Meta Agent Search (ADAS, MAS)
[[260302 Automated Design of Agentic Systems (MAS)]]

## Evo Harness (EH)
[[260815 Evo-Harness (EH)]]




# Comparison Summary


|      | Baseline Loop | Implemen-tation | Comp-onents | Bench-marks | Effective-ness | Code                                                                     |
| ---- | ------------- | --------------- | ----------- | ----------- | -------------- | ------------------------------------------------------------------------ |
| SICA |               |                 |             |             |                | [GitHub](https://github.com/MaximeRobeyns/self_improving_coding_agent)   |
| MAS  |               |                 |             |             |                | [GitHub](https://github.com/ShengranHu/ADAS)                             |
| EH   |               |                 |             |             |                | [GitHub](https://github.com/A-EVO-Lab/a-evolve/tree/release/evo-harness) |
| AEv  |               |                 |             |             |                | [GitHub](https://github.com/A-EVO-Lab/a-evolve)                          |
| DGM  |               |                 |             |             |                | [GitHub](https://github.com/jennyzzt/dgm)                                |
| HGM  |               |                 |             |             |                | [GitHub](https://github.com/metauto-ai/HGM)                              |
| MGM  |               |                 |             |             |                | [GitHub](https://github.com/RealLcz/MGM)                                 |

