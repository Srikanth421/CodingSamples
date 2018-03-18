# Import libraries and modules
import numpy as np
import pandas as pd
 
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
from sklearn.ensemble import RandomForestRegressor
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.externals import joblib 
from sklearn.preprocessing import LabelEncoder
 
# Load Bank Marketing data.http://archive.ics.uci.edu/ml/datasets/Bank+Marketing
dataset_url = 'D:/Machine Learning/UCI/bank-additional/bank-additional/bank-additional-full.csv'
data = pd.read_csv(dataset_url, sep=';')
 
for column in data.columns:
    if data[column].dtype == type(object):
        le = LabelEncoder()
        data[column] = le.fit_transform(data[column])

print(data.tail())
print(data.describe())
print(data.dtypes)
# Split data into training and test sets
y = data.y
X = data.drop('y', axis=1)
X_train, X_test, y_train, y_test = train_test_split(X, y, 
                                                    test_size=0.2, 
                                                    random_state=123, 
                                                    stratify=y)

X_train_scaled = preprocessing.scale(X_train)
print(X_train_scaled)

scaler = preprocessing.StandardScaler().fit(X_train)
X_train_scaled = scaler.transform(X_train)
 
print(X_train_scaled.mean(axis=0))
print(X_train_scaled.std(axis=0))

scaler = preprocessing.StandardScaler().fit(X_test)
X_test_scaled = scaler.transform(X_test)
# Declare data preprocessing steps
pipeline = make_pipeline(preprocessing.StandardScaler(), 
                         RandomForestRegressor(n_estimators=100))
 
# Declare hyperparameters to tune
hyperparameters = { 'randomforestregressor__max_features' : ['auto', 'sqrt', 'log2'],
                  'randomforestregressor__max_depth': [None, 5, 3, 1]}
 
# Tune model using cross-validation pipeline
clf = GridSearchCV(pipeline, hyperparameters, cv=10)
 
clf.fit(X_train, y_train)
 
# Refit on the entire training set
# No additional code needed if clf.refit == True (default is True)
 
# Evaluate model pipeline on test data
pred = clf.predict(X_test)
print(r2_score(y_test, pred))
print(mean_squared_error(y_test, pred))
 
# Save model for future use
joblib.dump(clf, 'rf_regressor.pkl')
# To load:  clf2 = joblib.load('rf_regressor.pkl')













