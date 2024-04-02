circshift <- function(v, n) {
  if (n == 0) v else c(tail(v, n), head(v, -n))
}

major_key <-
  c(6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88)
minor_key <-
  c(6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17)
key_templates <-
  tribble(
    ~name, ~template,
    "Gb:maj", circshift(major_key, 6),
    "Bb:min", circshift(minor_key, 10),
    "Db:maj", circshift(major_key, 1),
    "F:min", circshift(minor_key, 5),
    "Ab:maj", circshift(major_key, 8),
    "C:min", circshift(minor_key, 0),
    "Eb:maj", circshift(major_key, 3),
    "G:min", circshift(minor_key, 7),
    "Bb:maj", circshift(major_key, 10),
    "D:min", circshift(minor_key, 2),
    "F:maj", circshift(major_key, 5),
    "A:min", circshift(minor_key, 9),
    "C:maj", circshift(major_key, 0),
    "E:min", circshift(minor_key, 4),
    "G:maj", circshift(major_key, 7),
    "B:min", circshift(minor_key, 11),
    "D:maj", circshift(major_key, 2),
    "F#:min", circshift(minor_key, 6),
    "A:maj", circshift(major_key, 9),
    "C#:min", circshift(minor_key, 1),
    "E:maj", circshift(major_key, 4),
    "G#:min", circshift(minor_key, 8),
    "B:maj", circshift(major_key, 11),
    "D#:min", circshift(minor_key, 3)
  )

create_chromagram <- function(audio_analysis, key_templates) {
  audio_analysis %>%
    compmus_align(sections, segments) %>%
    select(sections) %>%
    unnest(sections) %>%
    mutate(
      pitches = map(segments,
                    compmus_summarise, pitches,
                    method = "acentre", norm = "manhattan")
    ) %>%
    compmus_match_pitch_template(key_templates, "aitchison", "manhattan") 
}

list_of_audio_analyses <- list(
  get_tidy_audio_analysis("6tNQ70jh4OwmPGpYy6R2o9"),
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
  get_tidy_audio_analysis("3qhlB30KknSejmIvZZLjOD"),
  
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
  
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4")
)

song_names <- c("Benson Boone - Beautiful things",
                "Ariana Grande - We cant be friends",
                "Djo - End of beginning",
                "B",
                "CV",
                "sfd",
                "D",
                "jj",
                "GG")
# Create chromagrams for each song
chromagrams <- lapply(seq_along(list_of_audio_analyses), function(i) {
  create_chromagram(list_of_audio_analyses[[i]], key_templates) %>%
    mutate(song_number = i, song_name = song_names[i])
})

# Combine chromagrams into one data frame
combined_chromagrams <- do.call(rbind, chromagrams)

# Create the plot
combined_plot <- ggplot(combined_chromagrams) +
  geom_tile(aes(x = start + duration / 2, width = duration, y = name, fill = d)) +
  scale_fill_viridis_c(option = "E", guide = "none") +
  theme_minimal() +
  labs(x = "Time (s)", y = "", fill = "Distance") +
  facet_wrap(~ song_name, nrow = 3, ncol = 3) +  # Facet by song name in a 3x3 grid
  theme(strip.background = element_rect(color = "white", fill = "white"),  # Add padding around facet labels
        strip.text = element_text(size = 5, face = "bold"),  # Adjust facet label size
        strip.placement = "outside",  # Placing titles outside the plot area
        panel.spacing = unit(1, "lines"),  # Increase spacing between facets
        plot.margin = margin(0.1, 0.1, 0.1, 0.1, "cm"),  # Adjusting plot margins
        axis.text.y = element_text(size = 4.5, angle = 45, hjust = 1))  # Reduce the size of y-axis labels5 degrees

# Print the combined plot
print(combined_plot)
