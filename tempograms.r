create_tempogram <- function(audio_url) {
  audio_url |>
    tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |>
    ggplot(aes(x = time, y = bpm, fill = power)) +
    geom_raster() +
    scale_fill_viridis_c(guide = "none") +
    labs(x = "Time (s)", y = "Tempo (BPM)") +
    theme_classic() 
}



#list_of_audio_analyses <- list(
#  get_tidy_audio_analysis("6tNQ70jh4OwmPGpYy6R2o9"),
#  get_tidy_audio_analysis("51ZQ1vr10ffzbwIjDCwqm4"),
#  get_tidy_audio_analysis("3qhlB30KknSejmIvZZLjOD"),

#  get_tidy_audio_analysis("0uHrMbMv3c78398pIANDqR"),
#  get_tidy_audio_analysis("272RmS2rS59JVBhlSR0cMv"),
#  get_tidy_audio_analysis("4nOOoo9OJbgnTBNHe5b6nD"),

#  get_tidy_audio_analysis("1ULyVVWV7PjtOfGM1UspG7"),
#  get_tidy_audio_analysis("1fbgXK7wcdKu42CI5l0dTP"),
#  get_tidy_audio_analysis("0w8xLwXp9WDrlPxyWofCUS")
#)

list_of_audio_analyses <- list(
  get_tidy_audio_analysis("0w8xLwXp9WDrlPxyWofCUS"))

#song_names <- c("Benson Boone - Beautiful things",
#                "Ariana Grande - We cant be friends",
#                "Djo - End of beginning",

#                "Josot Klein - Europapa",
#                "Rachel Wallace - Tell me why",
#                "Brutalismus 3000 - Romantica",

#                "IDK - DENiM",
#                "TOBi - Someone I Knew",
#                "Russ - In the dirt")
song_names <- c("Benson Boone - Beautiful things")

# Create tempograms for each song
#tempograms <- lapply(seq_along(list_of_audio_analyses), function(i) {
#  tempogram_data <- create_tempogram(list_of_audio_analyses[[i]])$data
#  data.frame(tempogram_data, song_number = i, song_name = song_names[i])
#})
tempograms <- lapply(seq_along(list_of_audio_analyses), function(i) {
  tempogram_data <- create_tempogram(list_of_audio_analyses[[i]])
})

saveRDS(object = tempograms, file = 'data/tempogram9.RDS')