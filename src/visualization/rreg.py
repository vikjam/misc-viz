#!/usr/bin/env python
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import TheilSenRegressor
from sklearn.linear_model import RANSACRegressor

# Load the example dataset for Anscombe's quartet
df = sns.load_dataset("anscombe")

# Show the results of a linear regression within each dataset
fig, ax = plt.subplots()
sns.lmplot(x           = "x",
           y           = "y",
           col         = "dataset",
           hue         = "dataset",
           data        = df,
           col_wrap    = 2,
           ci          = None,
           size        = 4,
           scatter_kws = {"s": 50, "alpha": 1})
plt.savefig('../../reports/figures/rreg.png')



# End of script
