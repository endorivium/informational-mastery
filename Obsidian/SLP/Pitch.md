# PStA Project Pitch: Template

Before you write code, you pitch **one or two papers** whose method you want to re-implement on the PARLO Dementia Corpus.

We discuss the pitch in the lecture: whether the plan is reasonable, what to simplify, and how to proceed.

  

Fill in this template as a team.

Short bullet answers are fine, aim for **two to three pages** in total.

"I don't know yet" is a valid answer, but then add it to the questions in Section 8.

The goal is not to have everything decided, but to have thought about it.

  

Reminder of the requirements:

three-class classification (HC / MCI / DEM) with speech and text features, at least **two unimodal baselines and one fusion model**, and the re-implementation of the method of one paper that uses audio and text.

You may start with audio only, the text side follows later in the course; the training and fusion mechanisms are largely the same.

  

---

  

## 0. Team


| Team name |Team 3 |

| Members |Julia Ihrenberger, Leonardo Kharraz Tavakol  |

| Date / version | e.g. pitch v1, revised after feedback |

  

---

  

## 1. Literature Study

  
What did you read, and what did you learn from it?

**1.1 Papers you read** (3 to 6, one line each)

  

| Paper (authors, year, venue)                                                                                                                                                         | Data / language / classes                                                                                                                           | Method (audio, text, fusion)                                                                                                                                                     | Main result (metric)                                                                                                                                                                      | Why relevant for us? |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| Challa Bharath Kumar, Gadu Srinivasa Rao and Sai Saranya Myla. 2026. Speech-Based Early Detection of Alzheimer’s Disease Using Explainable<br>Machine Learning and Ensemble Methods. | Classes: AD vs HC Dataset: Not mentioned Language: Not mentioned                                                                                    | audio only                                                                                                                                                                       | SVM acc: 0.93<br>XGBoost acc: 0.89                                                                                                                                                        |                      |
| Oiza-Zapata & Gallardo-Antolín. 2025. Alzheimer’s Disease Detection from Speech Using Shapley<br>Additive Explanations for Feature Selection and Enhanced<br>Interpretability.       | ADReSS (Cookie Theft, age/gender-matched), 156 speakers, official split 108 train / 48 test (4,077 segments ≤ 10 s); English; 2 classes (AD vs. HC) | Audio only: eGeMAPSv2 (88 features) per segment; removal of shortest 10 % segments; SHAP-based feature selection (top 32) XGBoost (grid search, StratifiedGroupKFold by speaker) | Test F1 0.769, acc 0.750, spec 0.667, sens 0.833                                                                                                                                          |                      |
| Tripti Tripathi, Rakesh Kumar. 2023. Speech-based detection of multi-class Alzheimer’s disease<br>classification using machine learning.                                             | Pitt Corpus<br>English<br>probable AD, possible AD, MCI, memory impair-<br>ments, vascular dementia, and contro                                     | audio only, using kNN, Decision Tree, SVM, XGBoost and Random Forest                                                                                                             | Acc/Prec/Rec/F1<br>Random forest .7047 .63 .70 .64<br>Support vector machine .7047 .64 .70 .65<br>Decision tree .69 .69 .68 .64<br>KNN .7205 .68 .72 .68<br>XGBoost .7559 .76 .76 .73<br> |                      |
  

**1.2 Which of the required and recommended readings did you use?**

(PDC paper, reviews, ADReSS / ADReSSo, TAUKADIAL, ...)

  

> read PDC paper

  

**1.3 What is the state of the art?**

Which results are reported for comparable setups, and how do they compare with chance (33 % UAR for three classes) and the baselines of the PDC paper?

Are these numbers comparable at all (language, data set, binary vs. three classes, evaluation protocol)?

  

> _your answer_

  

---

  

## 2. Candidate Paper(s)

  

Fill in one block per candidate (at most two).

  

### Candidate A: Oiza-Zapata & Gallardo-Antolín (2025)

  

**2.1 Citation and link**

  

> <span style="color:rgb(255, 255, 255)"><i>Oiza-Zapata, I., & Gallardo-Antolín, A. (2025). </i>Alzheimer’s Disease Detection from Speech Using Shapley Additive Explanations for Feature Selection and Enhanced Interpretability.</span>_ <span style="color:rgb(255, 255, 255)">Electronics, 14(11), 2248. [https://doi.org/10.3390/electronics14112248](https://doi.org/10.3390/electronics14112248) (open access, CC BY 4.0)</span>

Link: [https://www.mdpi.com/2079-9292/14/11/2248](https://www.mdpi.com/2079-9292/14/11/2248)

  

**2.2 The method in three to five sentences**

  

> _The system detects Alzheimer’s disease from audio alone. It splits each recording into short speech segments and describes every segment with the 88 handcrafted eGeMAPSv2 features from openSMILE (pitch, loudness, voice quality, formants, MFCCs, timing). An XGBoost classifier labels each segment, and each speaker’s diagnosis is the majority vote over their segments. Two steps make the model smaller and more accurate: the shortest 10 % of segments, which carry little information, are removed, and only the 32 most important features according to SHAP are kept. SHAP is then used again to explain the model, both globally (which features matter overall) and locally (why a given speaker was classified as AD).

  

**2.3 Pipeline sketch**

Draw or describe the pipeline from the input to the decision: input → pre-processing → features / encoders → fusion → classifier → output.

  

> <span style="color:rgb(255, 255, 255)"><span style="color:rgb(255, 255, 255)"><i><span style="color:rgb(255, 255, 255)">your answer</span></i></span></span>

  

**2.4 Modalities and fusion**

What is the audio part, what is the text part, and where and how are they combined (early, late, stacking, hybrid)?

  

> No text part only audio is used for getting the features

  

**2.5 Original data and evaluation**

Data set, language, number of speakers, classes, metric, splits.

Was the evaluation speaker-independent?

  

> _your answer_

  

**2.6 Reported results**

  

> _your answer_

  

**2.7 Availability**

Is code available? Are the pre-trained models available (and in which languages)?

  

>No

  

**2.8 Why this paper?**

What makes it interesting for you and for PARLO?

  

> _your answer_

  

### Candidate B (optional)

  

> _same questions as for Candidate A_

  

**If you pitch two papers:** which one do you prefer, and why?

  

> _your answer_

  

---

  

## 3. Sanity Check: Does It Fit PARLO?

  

Answer honestly, this is where most projects go wrong.

  

**3.1 Data fit**

PARLO is German, has 208 speakers, three classes and eight tasks with recordings between a few seconds and several minutes.

What is different from the paper's setup, and what do you have to change?

(e.g. English text models or word lists, binary instead of three classes, a different elicitation task, much shorter or longer recordings)

  

> _your answer_

  

**3.2 Which PARLO tasks?**

Which of the eight tasks will you use, and why?

Link your choice to the cognitive domain the task tests (e.g. the recall tasks for episodic memory, `pataka` for speech motor control).

  

> _your answer_

  

**3.3 Amount of data**

With five folds you train on about 165 participants.

How much training data does the method need?

Which parts are pre-trained and stay frozen, which parts are trained on PARLO?

  

> _your answer_

  

**3.4 Compute**

Which models do you use (size, number of parameters)?

Do you need a GPU?

Roughly how long do feature extraction and training take per fold?

Does it run on your own computer, or do you need the GPU machine (what exactly, and for how long)?

  

> _your answer_

  

**3.5 Transcripts**

Do you use the manual PARLO transcripts or your own ASR (which system)?

Do you use the same kind of transcripts for training and testing, and which one matches a realistic application?

  

> _your answer_

  

**3.6 Missing details**

Which details does the paper not report (hyperparameters, pre-processing, feature lists, layer choice, ...)?

How will you decide them?

  

> _your answer_

  

**3.7 Minimal version**

What is the smallest version of the project that you can deliver even if the full re-implementation does not work?

  

> _your answer_

  

---

  

## 4. Architectural Decisions

  

Things you might not have thought about yet.

Write down your current decision and the reason, or the open question.

  

| Decision | Your choice and why |

|---|---|

| **Unit of analysis:** participant, recording or segment? How are segment or recording predictions combined into one decision per participant? | |

| **Long recordings:** chunking, maximum input length of the models, pooling over time (mean, statistics, attention)? | |

| **Representation:** hand-crafted features, frozen embeddings (which layer?) or fine-tuning? | |

| **Several tasks per participant:** one model per task, or all tasks in one model? What happens if a participant misses a task? | |

| **Fusion:** where (early, late, stacking, hybrid), how are the modalities weighted, what happens with a missing modality? | |

| **Classifier and loss:** which model, which loss, how do you handle class imbalance? | |

| **Everything fitted on data** (scalers, PCA, feature selection, fusion weights, thresholds): is it fitted on the training folds only? | |

| **Hyperparameters:** which are fixed in advance, which are tuned, and how (inner folds, nested cross-validation)? | |

  

---

  

## 5. Evaluation Plan

  

**5.1 Splits**

Participant-level k-fold with `parlo-loader` (`corpus.kfold()`), saved once and reused for every experiment?

Do you additionally run a leave-one-site-out evaluation?

  

> _your answer_

  

**5.2 Metrics**

UAR as the primary metric; what else (confusion matrix, per-class recall, macro-F1)?

How do you report the spread (folds, seeds)?

  

> _your answer_

  

**5.3 Baselines**

Which two unimodal baselines?

What else do you compare with (majority class, chance, the original paper, the PDC paper baselines)?

  

> _your answer_

  

**5.4 Confounders**

Age, gender, education and recording site may differ between the groups.

How do you check that your model does not simply learn them?

  

> _your answer_

  

**5.5 Ablations**

Which component do you remove or replace to test your hypothesis (Section 6)?

  

> _your answer_

  

---

  

## 6. Research Question and Hypothesis

  

Re-implementing a paper is the means, not the goal.

What do you want to find out?

Examples: "Does the recall task add information over the stimulus task?", "Does fusion help MCI more than DEM?", "Does the method still work with German data and ASR transcripts?"

  

**6.1 Main question**

  

> _your answer_

  

**6.2 Expected outcome and why**

  

> _your answer_

  

**6.3 What would a negative result mean?**

  

> _your answer_

  

---

  

## 7. Questions to Me

  

What do you want to discuss in the pitch?

Scope, which of the two papers, compute on the GPU machine, data, unclear parts of the paper, ...

  

1.

2.

3.