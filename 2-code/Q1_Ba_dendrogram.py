import pandas as pd
from matplotlib import pyplot as plt
from scipy.cluster.hierarchy import dendrogram, linkage
import numpy as np

df = pd.read_excel("Q1_Ba_data_describe.xlsx")
df = df.set_index('roots')
Z = linkage(df, 'ward')
dendrogram(Z, leaf_rotation=90, leaf_font_size=8, labels=df.index)
plt.axhline(y=1, c='grey', lw=1, linestyle='dashed')
plt.xlabel('roots')
plt.title("Q1 group for Balanites aegyptiaca")
plt.show()
