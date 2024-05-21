random_top100 <- sample(nrow(top100_tracks), 3)
top100_random <- top100_tracks[random_top100, "track.id"]
songs_top100 <- top100_tracks[random_top100, "track.name"]
artists_top100 <- top100_tracks[random_top100, "track.artists"]$track.artists

random_mellow <- sample(nrow(mellow_bars), 3)
mellow_random <- mellow_bars[random_mellow, "track.id"]
songs_mellow <- mellow_bars[random_mellow, "track.name"]
artists_mellow <- mellow_bars[random_mellow, "track.artists"]$track.artists

random_hardcore <- sample(nrow(hardcore_tracks), 3)
hardcore_random <- hardcore_tracks[random_hardcore, "track.id"]
songs_hardcore <- hardcore_tracks[random_hardcore, "track.name"]
artists_hardcore <- hardcore_tracks[random_hardcore, "track.artists"]$track.artists

# list_of_audio_analyses <- list(top100_random, mellow_random, hardcore_random)

list_of_audio_analyses <- list(get_tidy_audio_analysis(top100_random$track.id[[1]]),
                               get_tidy_audio_analysis(top100_random$track.id[[2]]),
                               get_tidy_audio_analysis(top100_random$track.id[[3]]),
                               
                               get_tidy_audio_analysis(mellow_random$track.id[[1]]),
                               get_tidy_audio_analysis(mellow_random$track.id[[2]]),
                               get_tidy_audio_analysis(mellow_random$track.id[[3]]),
                               
                               get_tidy_audio_analysis(hardcore_random$track.id[[1]]),
                               get_tidy_audio_analysis(hardcore_random$track.id[[2]]),
                               get_tidy_audio_analysis(hardcore_random$track.id[[3]])
)

song_names <- c(glue("{artists_top100[[1]]$name[1]} - {songs_top100$track.name[[1]]}"),
                glue("{artists_top100[[2]]$name[1]} - {songs_top100$track.name[[2]]}"),
                glue("{artists_top100[[3]]$name[1]} - {songs_top100$track.name[[3]]}"),
                
                glue("{artists_mellow[[1]]$name[1]} - {songs_mellow$track.name[[1]]}"),
                glue("{artists_mellow[[2]]$name[1]} - {songs_mellow$track.name[[2]]}"),
                glue("{artists_mellow[[3]]$name[1]} - {songs_mellow$track.name[[3]]}"),
                
                glue("{artists_hardcore[[1]]$name[1]} - {songs_hardcore$track.name[[1]]}"),
                glue("{artists_hardcore[[2]]$name[1]} - {songs_hardcore$track.name[[2]]}"),
                glue("{artists_hardcore[[3]]$name[1]} - {songs_hardcore$track.name[[3]]}")
)

rm(top100_random)
rm(random_top100)
rm(songs_top100)
rm(artists_top100)

rm(random_mellow)
rm(mellow_random)
rm(songs_mellow)
rm(artists_mellow)

rm(random_hardcore)
rm(hardcore_random)
rm(songs_hardcore)
rm(artists_hardcore)
