library(tidyverse)

df <- read_csv('df_A3.csv') #upload csv
df <- df[1:1000,]#limit df to smaller size, first 1000 rows
df$'Summarized Stars'<-gsub("'","",as.character(df$'Summarized Stars')) #get rid of quotations
df$'Summarized Stars'<-gsub("\\[|\\]","",as.character(df$'Summarized Stars')) #get rid of brackets
df$'Summarized Stars' <- lapply(strsplit(as.character(df$'Summarized Stars'),split=','),trimws)#make into list
summ_stars <- df$'Summarized Stars'[df$'Summarized Stars' != ""]

# Create a flat list of all stars
list_tot <- unlist(summ_stars)
# Create a set (unique elements) from the list
set_tot <- unique(list_tot)
set_tot <- Filter(function(x) !is.null(x) && x != "", set_tot)
print('starting!')

df_new <- data.frame(matrix(0, nrow = nrow(df), ncol = length(set_tot)))
colnames(df_new) <- set_tot

row_idx <- 1
for (list in summ_stars){
  for (person in list){ #going through each person in row list
    if (person %in% set_tot){
      col_idx <- match(person, set_tot)
      df_new[row_idx, col_idx] <- 1
    }
  }
  row_idx <- row_idx + 1
}

print('done!')
print(as_tibble(df_new))

# Specify the file path where you want to save the CSV file
file_path <- "pca_df_new.csv"

# Save the dataframe to a CSV file
write.csv(df_new, file = file_path, row.names = FALSE)

#DONE
