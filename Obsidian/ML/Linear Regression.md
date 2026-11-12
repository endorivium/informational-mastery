**Quantifiying the Confidence in a Model** [Video](https://youtu.be/aFDOzpTeg0s?si=zL9eFs-gKqvoQAKo)
**SSR** - Sum of Squared Residuals
- finding the linear regression of data (y-intercept and slope) requires the minimization of the SSR
- sum of the square of the difference between the  predicted and actual value
**R $^2$** measures how much variation in the data can be explained by the model
![[Pasted image 20261112173051.png]]
- divides SSR by the SSR of the mean line and substracts it from 1
**p-value** is a statistical measure to determine the *likelihood that an observed outcome is the result of change* (i.e. random guessing results in a prediction that is as accurate as the model prediction)
StatQuest explains it as follows:
- for a given sample size k, choose k random datapoints and calculate R$^2$ for thousands of times, keeping track of each R$^2$ in a histogram
- take the model's R$^2$ as the threshold and get the percentage of values that are equal or above that threshold
   ![[Pasted image 20261112164606.png]]
- this value is the p-value
**L1 (Lasso) Regularization vs L2 (Ridge) Regularization** [Article](https://www.geeksforgeeks.org/machine-learning/ridge-regression-vs-lasso-regression/)
- add penality to the model's cost function
- L2 adds squared magnitude of the coefficients as penalty
	-  Loss = MSE + lambda *  sum of weights
	- good when there are many predictors or not enough data
	- good when all features are potentially relevant
	- penalty term is smooth and as slope value approaches 0, change in loss becomes very small, i.e. penalty slows down the closer to zero and improvement in model becomes non-significant between steps
- L1 adds absolute value of coefficients as penalty
	- facilitates feature selection by reducing unnecessary features to 0![[Pasted image 20261112180232.png]]