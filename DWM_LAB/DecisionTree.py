import numpy as np
import pandas as pd
from sklearn.datasets import load_iris
from sklearn.tree import DecisionTreeClassifier, export_text
from sklearn.model_selection import train_test_split

data=load_iris()
X=data.data
y=data.target

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)


model=DecisionTreeClassifier(criterion='entropy')
model.fit(X_train,y_train)
ypred=model.predict(X_test)
tree_rules=export_text(model,feature_names=data.feature_names)
print(tree_rules)


accuracy=npm.mean(ypred==y_test)    