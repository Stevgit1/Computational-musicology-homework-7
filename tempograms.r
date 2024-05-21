create_tempogram <- function(audio_url) {
  audio_url |>
    tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |>
    ggplot(aes(x = time, y = bpm, fill = power)) +
    geom_raster() +
    scale_fill_viridis_c(guide = "none") +
    labs(x = "Time (s)", y = "Tempo (BPM)") +
    theme_classic() 
}

tempograms <- lapply(seq_along(list_of_audio_analyses), function(i) {
  tempogram_data <- create_tempogram(list_of_audio_analyses[[i]])
})

# Convert tempograms to ggplot objects and add titles
tempogram_plots <- lapply(seq_along(tempograms), function(i) {
  tempogram <- tempograms[[i]]
  ggplot(tempogram$data, aes(x = time, y = bpm, fill = power)) +
    geom_raster() +
    scale_fill_viridis_c(guide = "none") +
    labs(x = "Time (s)", y = "Tempo (BPM)", title = paste("Track:", song_names[i])) +
    theme_classic() +
    theme(plot.title = element_text(size = 7))
})

saveRDS(object = tempogram_plots, file = "data/tempogram_plots.RDS")

rm(tempograms)
rm(create_tempogram)
rm(tempogram_plots)
