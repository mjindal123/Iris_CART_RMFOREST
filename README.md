# Iris_CART_RMFOREST
CART and RMFOREST comparison on iris data set
Data set “iris” gives the measurements in centimeters of the variables : sepal length and width and petal length and width, respectively, for 50 flowers from each of 3 species of Iris. The dataset has 150 cases (rows) and 5 variables (columns) named Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species. We intend to predict the Specie based on the 4 flower characteristic variables.

Once you have all performance metrics, you need to select the best model as per your business requirement. I will make this judgement based on 3 criterion in this case apart from business requirements:

1. Stability : The model should have similar performance metrics across both training and validation. This is very essential because business can live with a lower accuracy but not with a lower stability. We will give the highest weight to stability. For this case let’s take it as 5.

2. Performance on Training data : This is one of the important metric but nothing conclusive can be said just based on this metric. This is because an over fit model is unacceptable but will get a very high score at this parameter. Hence, we will give a low weight to this parameter (say 2).

3. Performance on Validation data : This metric catch holds of overfit model and hence is an important metric. We will score it higher than performance and lower than stability. For this case let’s take it as 3.

Note that the weights and scores entirely depends on the business case.
