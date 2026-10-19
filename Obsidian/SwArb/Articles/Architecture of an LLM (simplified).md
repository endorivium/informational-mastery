https://medium.com/@thisiskuhan
- LLM = large language model
# Tokens
[Article](https://medium.com/@thisiskuhan/tokens-the-currency-of-llms-78b1a5fccd3c)

- tokens are the "currency" and represent both the input and output
- each LLM model has its own **Tokenizer** which dissects a sentence into smaller word **tokens**, which in turn are then mapped to their **Token IDs**
- types of tokens:
	- **word tokens** (token per word)
	- **character tokens** (token per letter)
	- **byte tokens** (text in raw bytes)
	- **subword token** (token per subword)
- behaviour is determined by:
	- **tokenization method** (e.g. BPE, WordPiece); efficient handling of a vast vocabulary
	- **parameters**: determine how many tokens can be recognized (commonly 50k, larger sizes > 100k)
	- **training dataset**: determines "useful" split during the tokenization, best splits determined for dataset domain (e.g. coding) > tokenizer works best in that context

`An LLM takes N input tokens and gives out only one output token.`
- LLM runs in loop where it receives the input as tokens (or rather token IDs) and based on those, creates an output token which is appended to the input token sequence; this is then the new input, repeating this loop until it produces a special token that marks the end of the generation
	- step-by-step prediction (**autoregressive** nature)

- each token represents a **small unit of computation** > more token = higher computation cost

# Embeddings
[Article](https://medium.com/@thisiskuhan/embeddings-meaning-measured-in-numbers-4a3452df1d1d)

- each LLM has its own **Embedder** which takes the token IDs and transforms them into **embeddings** which carry the meaning of the input
- previous methods (i.e. do two sentences use the same words?)
	- **One Hot Encoding**: set a vocabulary size (= vector size) and mark the appearance of a word with 1 else 0
	- **Bag of Words** (BoW): take a text section, make vector with size of how many unique words are in that word section (bag of words), when representing a sentence mark the appearance of a word with 1 else 0
	- **TF-IDF** where TF (**Term Frequency**) is how often a word shows up in a document and IDF (**Inverse Document Frequency**) is how rare the word is across the whole collection of documents
		- results in higher score for words that show up often within document (high TF) and lower score for words that appear in many documents (high DF)
		- highlights words that distinguishes one doc from another
-  all these methods are missing the *semantic meaning behind the words*

- **Embeddings**: take a pool of works and for each word, assign a rating how close a given word relates to the one being looked at (creates dense vector) e.g.![[Pasted image 20261019161616.png]]

- **Cosine Similarity**: find angle between two vectors and take the cosine > close to 1 = similar, close to 0 = not similar at all (is used after training)
- size determine detail and speed; e.g. 768 or 1536 > more detail but heavier and slower, 128 or 384 > faster and lighter, loses some meaning
- **Embedder**: text in -> dense vector out, size chosen to balance *accuracy, memory and speed*

## Anatomy of an LLM
[Article](https://medium.com/@thisiskuhan/the-anatomy-of-an-llm-part-1-894ce445446c)
## Neural Network
- consists of *input layer*, *hidden layers* and *output*, each node is a **neuron**
- **Forward Propagation**: passing info through input layer -> hidden layers -> output layer
	- each neuron has its own set of **weights** and a single bias **term** which form the z value, which is passed into an **activation function**, then passed forward to the next neuron
	- output layer gives **probability** to each possible outcome (**Softmax** activation function); highest propbable outcome is the final answer
- **Backpropagation**: reverse of forward propagation
	- moves backwards from output layer and updates weights and biases along the way; difference (called *loss*) between predicted answer and actual answer is compared
	- **Gradient Descent** is used to find optimal weights and biases
## Sampling
- architecture that relies on the concept of **Attention Mechanism**
- **Sampling Hyperparameters** (e.g. temperature, top-k, top-p) add sampling and creativity to the output probabilities
	- **temperature**: high temperature = more creative (trade accuracy for diversity) <> low temperature = more deterministic (sticks to highest probability), part of Softmax calculation (higher T spreads out probabilities)
	- **top-k**: how many highest-probability words to consider
	- **top-p**: dynamically chooses smallest set of words that add up to chosen probability p
	- change the way the model speaks

## Transformer
- consists of **Encoder**s and **Decoder**s
- **Positional Encoditing** (or Positional Embedding) describe the position of each token in the sentence
- **Encoder**: consists of Self-Attention layer and Feed Forward Network (FNN)
	- **Self-Attention layer**: tokens look at their relation to all other tokens, building *context-dependency*
	- **Feed Forward Network (FNN)**: each token is processed independently, model refines its embedding based on its context
	- **Attention Mechanism**: determines the importance of each component in a sequence relative to the other components in that sequence