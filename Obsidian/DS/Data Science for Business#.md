# 1. Introduction - Data Analytical Thinking
<span style="color:rgb(255, 192, 0)">What is the difference between Data Science and Data Mining?</span>
Data Science describes fundamental principles and processes that guide the extraction of knowledge from data, whereas Data Mining is the usage of appropriate technology to translate those principles into actions. However, they are often used interchangeably.

<span style="color:rgb(255, 192, 0)">Why does it make sense to understand data-analytic thinking even if you do not intend to apply Data Science yourself?</span>
Even if you don't intend to use data science for decision making or similar, it is still necessary to be able to understand and evaluate proposals that involve data acquisition, exchange, etc/ evaluate data mining project by being able to spot obvious flaws, unrealistic assumptions and missing pieces.

<span style="color:rgb(255, 192, 0)">The book discusses how Wal-Mart applied data science when a Hurricane was on it's way to Florida. Discuss why this might be useful and what they gained from this project.</span>
Wal-Mart expected/hoped to find trends in their customers' purchase history to better prepare their sales for the upcoming hurricane. This was useful insofar that it challenged their assumptions of what they thought customers would buy and instead gave them a list of items that customers actually bought, allowing them to react to this change in customer behavior in advance and manage stock levels appropriately.

<span style="color:rgb(255, 192, 0)">What is "customer churn" and why it is a problem (in many industries, but specifically for mobile telecommunication providers)?</span>
Customer churn is the loss of customers at the end of their contract to a competitor. This especially concerns mobile telecommunication providers for example where the market is oversaturated, customer retention is difficult and the acquisition of new customers is more expensive than their retention since they would have to poach them from competitors.

<span style="color:rgb(255, 192, 0)">What does DDD stand for? Explain the concept. Why would a company want to employ DDD?</span>
DDD stands for Data Driven Decision Making and is the concept of using data and knowledge gained from that data to plot future decisions and actions within a business instead of relying on intuition/past experiences.
The reason for deploying DDD is to optimize existing processes or gain an advantage over other companies that stand in competition to your own. Increase of productivity of around 5%, orrelation with higher return on assets/equity/market value.

<span style="color:rgb(255, 192, 0)">Why does data science overlap with DDD and not just support it</span>
~~Data science allows for the extraction of knowledge from collected data which can then be used for DDD.~~ More and more decision are made automatically by systems based on data science/predictive analytics.

<span style="color:rgb(255, 192, 0)">What does Big Data mean?</span>
Big Data describes data that is too large in volume to be processed by conventional data processing systems.

<span style="color:rgb(255, 192, 0)">Explain how Signet Bank gained a significant competitive advantage by investing in data!</span>
Before their investment, banks would usually offer uniform terms for their credit, ignoring the potential of retaining their best customers that made them the most money. By creating a model which predicted profitability via appropriate data acquisition, they gained a significant competitive edge over their competitors by offering different terms to different customers that worked more in their favor.

<span style="color:rgb(255, 192, 0)">Give an example for the Fundamental concept: "Formulating data mining solutions and evaluating the results involves thinking carefully about the context in which they will be used.</span> 
In case of the churn example, it needs to be evaluated whether the expected value of the customers should be taken into account in addition to their likelihood of leaving. Furthermore, it needs to be evaluated if the solution poses an improvement in comparison to e.g. the default case or random action.

# 2. Intro to Predictive Modeling
<span style="color:rgb(255, 192, 0)">Why do we want to decompose a data-analytics problem and into what kind of pieces?</span>
We want to split the problem into pieces, so that they correlate to existing data science tasks, allowing the use of pre-existing tools and methods.

<span style="color:rgb(255, 192, 0)">Explain the tasks "classification" and "scoring" and how they relate to each other!</span>
Classification creates model that assign a label (class) to a new individual, whereas Scoring assigns a score to each possible class label, rating the individual's probability of belonging to that class

<span style="color:rgb(255, 192, 0)">What is the difference between Classification and Regression?</span>
Classification: assigns a class to an entity (if smth will happen)
Regression: assigns a numerical value (how much of smth happens)

<span style="color:rgb(255, 192, 0)">What does Clustering do?</span>
Clustering groups similar individuals together

<span style="color:rgb(255, 192, 0)">Describe the difference between supervised and unsupervised learning. Give one example for method for each type.</span>
Supervised: has a specific purpose/target value and wants to find out which group an individual belongs to, e.g. classification, regression
Unsupervised: does not have a specific target value, e.g. clustering, outlier detection

<span style="color:rgb(255, 192, 0)">What are the two phases of a machine learning/data mining system, and what is done in each of them?</span>
1. Model Creation: model is created/trained based on appropriate data in a controlled environment
2. Model Deployment/Usage: model is deployed and used in real world conditions

<span style="color:rgb(255, 192, 0)">Draw the CRISP DM process.</span>
1. Business Understanding
2. Data Understanding
3. Data Preparation
4. Modeling
5. Evaluation
6. Deployment
revolves around data and is cyclical, internal loops: 1<->2, 3<->4, 5->1

<span style="color:rgb(255, 192, 0)">Explain each step of the CRISP DM process in 1-2 sentences in your own words.</span>
1. Business Understanding: formulate the problem to be solved and the use scenario, divide business objective into one or more data science/ machine learning problems
2. Data Understanding: understand limitations and strengths of existing data as well as what data is needed, overview of available and missing data
3. Data Preparation: conversion and cleaning of existing data into necessary format for chosen machine learning method, identifying leaks in data (i.e. data that directly informs the solution)
4. Modeling: training/creation of model based on data
5. Evaluation: evaluation of the result of the model in respect to business problem that it needs to solve
6. Deployment: retraining the model on new data into a production environment

<span style="color:rgb(255, 192, 0)">Explain the difference between explanatory modelling and predictive modelling for regression analysis.</span> 
explanatory: explanation of why smth happened, i.e. patterns in the data that are valid for that data
predictive: prediction of if smth will happen, i.e. finding and generalizing patterns that are then valid for new data