# Load necessary libraries
library(tidyverse)    # For data manipulation and visualization
library(ggpubr)       # For additional ggplot2 functionalities
library(ggsci)        # For custom color palettes
library(GGally)       # For pairwise plots
library(extrafont)     # For using custom fonts
library(Cairo)         # For saving high-quality images

# Load the penguins dataset from palmerpenguins package
penguins <- palmerpenguins::penguins

# Remove rows with missing values
penguins <- penguins %>% drop_na()

# Create a pairwise scatterplot and histogram matrix using ggally
ggpairs(
  penguins[, c(1, 3:6)],                    # Select relevant columns
  columnLabels = c(
    "Species",                              # Add meaningful column labels
    "Bill Length (mm)",
    "Bill Depth (mm)",
    "Flipper Length (mm)",
    "Body Mass (g)"
  ),
  diag = list(continuous = ggally_densityDiag),  # Use density plots on the diagonal
  aes(color = species, alpha = 0.5),             # Add color by species and transparency
  showStrips = TRUE                              # Show strips for categorical variables
) +
  scale_fill_jco() +                            # Apply custom color palette
  scale_color_jco() +
  theme_classic() +                             # Use classic theme for a clean look
  theme(
    plot.caption = element_text(size = 11, hjust = 0.5, vjust = -5),
    plot.title = element_text(
      size = 22,
      face = 'bold',
      family = "Tw Cen MT",
      hjust = 0.5
    ),
    text = element_text(family = "Tw Cen MT"),
    strip.text = element_text(face = "bold", size = 12),
    panel.spacing = unit(5, "mm"),
    legend.title = element_text(size = 12),
    strip.background = element_blank(),
    legend.text = element_text(size = 8, face = "bold"),
    axis.title.x = element_text(size = 14),
    axis.text.y = element_text(
      family = "Tw Cen MT",
      size = 7,
      face = "bold"
    ),
    axis.text.x = element_text(
      family = "Tw Cen MT",
      size = 7,
      face = "bold"
    ),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    plot.margin = margin(2, 4, 2, 2, 'cm'),
    plot.background = element_rect(fill = 'grey95'),
    panel.background = element_rect(fill = 'grey95'),
    legend.background = element_rect(fill = 'grey95')
  )

# Save the plot as a PNG image with high resolution
ggsave("penguins.png", width = 15, height = 10, dpi = 300, type = "cairo")

