Jenny Zhang et al. (29 May 2025 | 12 Mar 2026)
[arXiv:2505.22954v3](https://arxiv.org/abs/2505.22954v3)
[Suwandi Article](https://richardcsuwandi.github.io/blog/2025/dgm/) | [Patel LinkedIn Article](https://www.linkedin.com/pulse/what-darwin-gödel-machine-agent-rewrote-its-own-code-learned-patel-o7e1c/)

<mark style="background: #FFB86CA6;">Note: check between revisions</mark>
# Notes
- an AI agents **tools** are not considered part of its codebase, they are more like *modular, external instruction and knowledge packages* that the agent loads dynamically
- an AI agent's **code base** refers to its source that runs the LLM, i.e. the *surrounding software architecture* which determines things such as tool call execution, file-handling workflows, patch-validation logic, etc
- DGM agents *modified their source code*, e.g. adding patch-validation logic (needed functions, when to run, etc), modifying and creating tools, testing functions, the way it replaces strings, message summarization (list based on *DGM on SWE-bench*), FM usage workflow, i.e. how it interacts and functions
- In DGM, agent appears to be one monolith that includes everything, meaning it does not modularize tools into their own files
- DGM does not retrain/alter underlying LLM model, base model is frozen

# Paper Summary
**Short Summary**:
![[Pasted image 20261014173144.png]]

- **self-modification phase**: selected coding agents (parent) generate modified version of themselves (child)
- **evaluation phase**: each modified agent is tested on a coding benchmark (SWE-bench, Polyglot)
- `A key assumption is that an increase in performance on coding benchmarks indicates better coding capabilities, andhence better ability to self-modify and self-improve.`
- DGM solves downstream tasks (i.e. coding problems) and also refines its own implementation (i.e. its codebase)
- **Parent selection** is roughly proportional to each agent’s performance score and **inversely proportional to the number of its children** with codebase-editing functionality
- all agents (whether failed or not) are kept in an archive to serve as possible future stepping stone, retaining a non-zero probability to be chosen as parent (**open-ended exploration**)
- each selected parent **analyses** own benchmark eval logs, **proposes new feature** to implement and **receives this proposal as problem statement** to execute
- **implements suggested feature** into its own codebase, generating a new coding agent
- child agents are **quantitatively evaluated on a chosen coding benchmark**
	- must compile successfully and retain ability to edit codebase
## SWE-Bench
[Github Repo](https://www.swebench.com/original.html)
Benchmark that tests an AI's ability to solve Github issues:
- SWE-bench test AI systems' ability to solve GitHub issues
- based on 2294 task instances that have issues with matching Pull requests that solved those issues
- isolated those tasks into their own execution environments (Docker Image) and implemented a "Fail-to-Pass" test where tests only pass with the correct Pull Request
- "SWE-bench evaluation works as follows. Per task instance, an **AI system is given the issue text**. The AI system should then **modify the codebase in order to resolve the described issues**. When the AI system is finished, we run the aforementioned Fail-to-Pass tests to check if the issue was successfully resolved."

## Polyglot
[Webpage](https://aider.chat/2024/12/21/polyglot.html)
- contains coding problems in C++ Go Java JavaScript Python Rust
- focuses on 225 most difficult exercises out of 697 provided by Exercism in the given language

## TheRegister Interview
[TheRegister](https://www.theregister.com/software/2025/06/02/boffins-found-self-improving-ai-sometimes-cheated/942318)
- `DGM relies on a "frozen" foundation model that handles the reading, writing, and execution of code via tool use. It is modifying generated software agents, but not the model at its core.`
- Fixed benchmarks are problematic insofar that DGM was observed cheating during an attempt to reduce hallucinations
- furthermore, would hallucinate the usage of specific tools with matching report without ever having used the tool
- problem of agents hacking their own benchmarks to "improve" without actually improving
- one solution would be the change and evolution of the tasks and goals alongside the model, Zhang suggests
