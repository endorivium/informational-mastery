Zhang et al.
[Research Paper](file:///D:/Users/Julia%20Ihrenberger\Documents/1_Studium_Informatik/informational-mastery/SwArb/finished/ZhangEtAl_DarwinGoedelMachine.pdf)

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
