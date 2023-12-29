library(tidyverse)
library(igraph) 
library(node2vec)
df <- read_csv('pca_df.csv') #upload csv
df_actors <- df[1:33,4:36] #33 rows, 33 columns starting at the first actor
# Create a graph object
graph <- graph_from_adjacency_matrix(as.matrix(df_actors), mode = "undirected", weighted = NULL)

# Set actor names as vertex names
V(graph)$name <- names(df_actors)
# Plot the social network graph
plot(graph, main = "Social Network Graph", vertex.label.dist = 2, vertex.size = 10, vertex.label.cex = 0.8, edge.width = 2)