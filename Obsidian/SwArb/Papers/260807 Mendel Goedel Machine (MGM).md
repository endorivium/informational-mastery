Liu et al. (07 Aug 2026) 
[arXiv:2608.07645](https://arxiv.org/abs/2608.07645) | [GitHub](https://github.com/RealLcz/MGM)

**Short Summary**: based on *DGM* and *HGM*, but modifies the self-modification process by differentiating between *clonal mutation* (standard single-agent, single-trajectory i.e. one failed task), *reaction-norm mutation* (single agent, multi-trajectory i.e. multiple failed tasks) and *cross-lineage hybridization* (comparison of two agents who attempted the same task but not solved by both)

- source code is **genotype**
- evaluation outcomes is **phenotype**

- baseline architecture is based on [[251029 Huxley-Gödel Machine (HGM)]] but modifies the self-modification process (expansion policy)
- expansion in MGM splits into three sub-operators
	- **clonal mutation** where one agent is modified based on one failed task
	- **reaction-norm mutation** where one agent is modified based on multiple tasks that it has failed
	- **cross-lineage hybridization** where multiple agents have attempted the same task but not solved by both; a failed agent is designated as the target, another is the reference agent
		- if reference was successful, then difference in their genotype is used to correct target
		- if reference has also failed, then comparison is used to identify complementary failure modes
		- target is then prompted to extract "`a transferable behavioral trait from the reference trajectory`"


