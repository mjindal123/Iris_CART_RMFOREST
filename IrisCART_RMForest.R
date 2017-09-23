data(iris)
summary(iris)

# visually look at the dataset

qplot(Petal.Length,Petal.Width,colour=Species,data=iris)

# The three species seem to be well segregated from each other. The accuracy in prediction 
# of borderline cases determines the predictive power of the model. In this case, we will 
# install two useful packages for making a CART model.

library(rpart)
library(caret)
train.flag <- createDataPartition(y=iris$Species,p=0.5,list=FALSE)
training <- iris[train.flag,]
Validation <- iris[-train.flag,]

# Now, we need to check the predictive power of the CART model, we just built. Here, we are 
# looking at a discordance rate (which is the number of misclassifications in the tree) as the 
# decision criteria. We use the following code to do the same :
  
modfit <- train(Species~.,method="rpart",data=training) 
# library(rattle)
# fancyRpartPlot(modfit$finalModel) to see the tree srecture

train.cart<-predict(modfit,newdata=training)
table(train.cart,training$Species)

# Misclassification rate = 3/75
# Only 3 misclassified observations out of 75, signifies good predictive power. 
# In general, a model with misclassification rate less than 30% is considered to be a good model. 
# But, the range of a good model depends on the industry and the nature of the problem. 
# Once we have built the model, we will validate the same on a separate data set. 
# This is done to make sure that we are not over fitting the model. In case we do over fit the model, 
# validation will show a sharp decline in the predictive power. It is also recommended to do an 
# out of time validation of the model. This will make sure that our model is not time dependent. 
# For instance, a model built in festive time, might not hold in regular time. For simplicity, 
# we will only do an in-time validation of the model. We use the following code to do an in-time 
# validation:
  
pred.cart<-predict(modfit,newdata=Validation)
table(pred.cart,Validation$Species)

# Misclassification rate = 4/75
# As we see from the above calculations that the predictive power decreased in validation 
# as compared to training. This is generally true in most cases. The reason being, the model
# is trained on the training data set, and just overlaid on validation training set. But, it 
# hardly matters, if the predictive power of validation is lesser or better than training. What
# we need to check is that they are close enough. In this case, we do see the misclassification 
# rate to be really close to each other. Hence, we see a stable CART model in this case study.
 
# Let's now try to visualize the cases for which the prediction went wrong. Following is the 
# code we use to find the same :
  
correct <- pred.cart == Validation$Species
qplot(Petal.Length,Petal.Width,colour=correct,data=Validation)
# 
# As you see from the graph, the predictions which went wrong were actually those borderline 
# cases. We have already discussed before that these are the cases which make or break the 
# comparison for the model. Most of the models will be able to categorize observation far 
# away from each other. It takes a model to be sharp to distinguish these borderline cases.


# CART model gave following result in the training and validation :
#   
# Misclassification rate in training data = 3/75
# 
# Misclassification rate in validation data = 4/75
# 
# As you can see, CART model gave decent result in terms of accuracy and stability. 
# We will now model the random forest algorithm on the same training dataset and validate 
# it using same validation dataset.
# 
# 
# Building  a Random forest model 
# We have used "caret" , "randomForest" package to build this model. 
# You can use the following code to generate a random forest model on the training dataset.

library(randomForest)
library(caret)
modfit <- train(Species~ .,method="rf",data=training)
pred <- predict(modfit,training)
table(pred,training$Species)

# Misclassification rate in training data = 0/75
# 
# Validating the model 
# Having built such an accurate model, we will like to make sure that we are not over 
# fitting the model on the training data. This is done by validating the same model on 
# an independent data set. We use the following code to do the same :

train.cart<-predict(modfit,newdata=Validation)
table(train.cart,Validation$Species)

# The model should have similar performance metrics across both training and validation. 
# This is very essential because business can live with a lower accuracy but not with a lower 
# stability. Every model has its own strength. Random forest, as seen from this case study, has a 
# very high accuracy on the training population, because it uses many different characteristics 
# to make a prediction. But, because of the same reason, it sometimes over fits the model on the 
# data. CART model on the other side is simplistic criterion cut model. This might be over 
# simplification in some case but works pretty well in most business scenarios. However, the 
# choice of model might be business requirement dependent, it is always good to compare performance 
# of different model before taking this call.
 