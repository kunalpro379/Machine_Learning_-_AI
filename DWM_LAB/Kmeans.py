import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
from scipy.cluster.hierarchy import dendrogram, linkage

# Load the Iris dataset
iris = load_iris()
X = iris.data  # Features
y = iris.target  # True labels (for validation purposes)

# K-Means Clustering
def kmeans_clustering(X, n_clusters):
    kmeans = KMeans(n_clusters=n_clusters, random_state=42)
    kmeans.fit(X)
    y_kmeans = kmeans.predict(X)
    
    # Calculate the silhouette score
    silhouette_avg = silhouette_score(X, y_kmeans)
    print(f"K-Means Clustering with {n_clusters} clusters:")
    print(f"Silhouette Score: {silhouette_avg:.2f}\n")
    
    return y_kmeans, kmeans

# Visualizing K-Means results
def plot_kmeans(X, y_kmeans, kmeans):
    plt.figure(figsize=(8, 6))
    plt.scatter(X[:, 0], X[:, 1], c=y_kmeans, s=50, cmap='viridis')
    centers = kmeans.cluster_centers_
    plt.scatter(centers[:, 0], centers[:, 1], c='red', s=200, alpha=0.75, marker='X')
    plt.title("K-Means Clustering")
    plt.xlabel("Feature 1")
    plt.ylabel("Feature 2")
    plt.grid(True)
    plt.show()

# Perform K-Means Clustering with 3 clusters
y_kmeans, kmeans = kmeans_clustering(X, n_clusters=3)
plot_kmeans(X, y_kmeans, kmeans)
