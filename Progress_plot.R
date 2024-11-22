# Load necessary libraries
# Load necessary libraries
library(ggplot2)

# Load the dataset
data <- read.csv('progress.csv')

# Create the plot
ggplot(data, aes(x = category, y = Relevant.records)) +
  geom_area(fill = "yellow", alpha = 0.5) +   # Density-like fill
  geom_line(color = "gold", size = 1) +       # Outline for the area
  geom_vline(xintercept = 64, linetype = "dashed", color = "red", size = 1) + 
  ylim(0, 10) +# Dashed vertical line
  labs(
    title = "Progress Density",
    x = "Number of reviewed records",
    y = "Number of relevant records"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5)  # Center the title
  )
