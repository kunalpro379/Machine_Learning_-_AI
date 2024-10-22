import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.cluster import KMeans
from scipy.cluster.hierarchy import dendrogram, linkage

# Load the Iris dataset
iris = load_iris()
X = iris.data  # Features
y = iris.target  # True labels (for validation purposes)

# Hierarchical Clustering (Dendrogram)
def plot_dendrogram(X):
    # Perform hierarchical clustering
    linked = linkage(X, method='ward')
    
    plt.figure(figsize=(10, 7))
    dendrogram(linked,
               orientation='top',
               distance_sort='descending',
               show_leaf_counts=True)
    plt.title("Hierarchical Clustering Dendrogram")
    plt.xlabel("Samples")
    plt.ylabel("Distance")
    plt.show()

# Plot the Dendrogram
plot_dendrogram(X)
