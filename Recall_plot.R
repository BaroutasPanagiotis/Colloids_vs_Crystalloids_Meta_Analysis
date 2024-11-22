# Load necessary libraries
library(ggplot2)

# Load the dataset
data <- read.csv("recall.csv")

# Create the plot
ggplot(data) +
  geom_step(aes(x = category, y = `Relevant.by.ASReview.LAB`, color = "ASReview LAB"), size = 1) +
  geom_step(aes(x = category, y = `Random.relevant`, color = "Random relevant"), size = 1) +
  geom_vline(xintercept = 64, linetype = "dashed", color = "red", size = 1) +  # Dashed vertical line at x = 60
  scale_color_manual(values = c("ASReview LAB" = "gold", "Random relevant" = "blue")) +  # Custom colors for lines
  labs(
    title = "Recall Progress",
    x = "Number of reviewed records",
    y = "Number of relevant records",
    color = ""
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5)  # Center the title
  )
