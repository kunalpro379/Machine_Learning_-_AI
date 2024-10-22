import pandas as pd
import matplotlib.pyplot as plt
import networkx as nx
from mlxtend.frequent_patterns import apriori, association_rules
# Sample dataset (transactions)
data = {
    'TransactionID': [1, 2, 3, 4, 5],
    'Items': [
        ['Milk', 'Bread', 'Eggs'],
        ['Bread', 'Diaper', 'Beer'],
        ['Milk', 'Diaper', 'Beer', 'Cola'],
        ['Bread', 'Milk', 'Diaper', 'Beer'],
        ['Milk', 'Bread', 'Diaper', 'Cola']
    ]
}

# Create a DataFrame
df = pd.DataFrame(data)

# Create a basket matrix
basket = df.explode('Items').groupby(['TransactionID', 'Items'])['Items'].count().unstack(fill_value=0)
basket = basket.applymap(lambda x: 1 if x > 0 else 0)

# Apply the Apriori algorithm
frequent_itemsets = apriori(basket, min_support=0.4, use_colnames=True)

# Generate the association rules
rules = association_rules(frequent_itemsets, metric="confidence", min_threshold=0.5)

# Display the results
print("Frequent Itemsets:")
print(frequent_itemsets)

print("\nAssociation Rules:")
print(rules)

# Visualization of Frequent Itemsets
plt.figure(figsize=(10, 6))
plt.bar(frequent_itemsets['itemsets'].astype(str), frequent_itemsets['support'], color='skyblue')
plt.title('Frequent Itemsets Support')
plt.xlabel('Itemsets')
plt.ylabel('Support')
plt.xticks(rotation=45)
plt.show()

# Visualization of Association Rules using a Network Graph
plt.figure(figsize=(10, 8))
G = nx.DiGraph()

# Add edges for association rules
for index, row in rules.iterrows():
    G.add_edge(list(row['antecedents'])[0], list(row['consequents'])[0], weight=row['support'])

# Draw the graph
pos = nx.spring_layout(G)
edges = G.edges(data=True)

nx.draw_networkx_nodes(G, pos, node_size=2000, node_color='skyblue')
nx.draw_networkx_edges(G, pos, width=2, alpha=0.5, edge_color='gray')
nx.draw_networkx_labels(G, pos, font_size=12, font_family='sans-serif')

# Edge labels for support
edge_labels = {(u, v): f"{d['weight']:.2f}" for u, v, d in edges}
nx.draw_networkx_edge_labels(G, pos, edge_labels=edge_labels)

plt.title('Association Rules Network Graph')
plt.axis('off')
plt.show()
