# Features
corpus_features <- get_playlist_audio_features("", "443PhwLJ63ci5JD8UpzNGf")

saveRDS(object = corpus_features, file = "data/corpus-features.RDS")

# Playlist data

illenium <-
  get_playlist_audio_features("illenium", "37i9dQZF1DZ06evO2nTSE0") |>
  add_audio_analysis() |>
  mutate(
    segments = map2(segments, key, compmus_c_transpose),
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "mean", norm = "manhattan"
      ),
    timbre =
      map(
        segments,
        compmus_summarise, timbre,
        method = "mean"
      )
  ) |>
  mutate(pitches = map(pitches, compmus_normalise, "clr")) |>
  mutate_at(vars(pitches, timbre), map, bind_rows) |>
  unnest(cols = c(pitches, timbre))

saveRDS(object = illenium, file = "data/illenium-data.RDS")

illenium_slice_data <- get_playlist_audio_features("spotify", "6YPjuCeFwwa9QOWgQf2E92")
dabin_slice_data <- get_playlist_audio_features("spotify", "2NsuHnVHEE8EWGgZ2feWvD")
saidthesky_slice_data <- get_playlist_audio_features("spotify", "64YMexODQbFxLw7hNczTc6")
classifier_data <-
  bind_rows(
    illenium_slice_data |> mutate(playlist = "Illenium") |> slice_head(n = 27),
    dabin_slice_data |> mutate(playlist = "Dabin") |> slice_head(n = 27),
    saidthesky_slice_data |> mutate(playlist = "Said The Sky") |> slice_head(n = 27)
  ) |> 
  add_audio_analysis()

saveRDS(object = classifier_data, file="data/classifier-data.RDS")

# --------------

# Track data
a_lydian <- get_tidy_audio_analysis("18U87POTjpJVmSUL8usDIO")
dont_feel_anything <- get_tidy_audio_analysis("7IiNKoMkXQ07YwDI7cbmOJ")
infinity <- get_tidy_audio_analysis("4l549wQMFj7HvlB7jzQnck")
gold_away <- get_tidy_audio_analysis("0OtEOm1n6owWtb5h1Ncei4")
gold_away_heart <- get_tidy_audio_analysis("2NsOLbG8B9d2QuzKVJO5hZ")
gf1 <- get_playlist_audio_features("", "5kEJhZTWUR28ppmuJmeAQO") |>
  add_audio_analysis()
gf2 <- get_playlist_audio_features("", "37RQUc3WTPJCLevgr6eFqy") |>
  add_audio_analysis()
gf3 <- get_playlist_audio_features("", "1KqOWYQQCIM7aO9WzX1f4d") |>
  add_audio_analysis()
gf4 <- get_playlist_audio_features("", "0IggDA4Wzw7PHfDiAK0pcM") |>
  add_audio_analysis()

saveRDS(object = a_lydian,file = "data/a-lydian-data.RDS")
saveRDS(object = dont_feel_anything,file = "data/dont-feel-anything-data.RDS")
saveRDS(object = infinity, file = "data/infinity-data.RDS")
saveRDS(object = gold_away, file = "data/gold-away-data.RDS")
saveRDS(object = gold_away_heart, file = "data/gold-away-heart-data.RDS")
saveRDS(object = gf1, file = "data/gf1-data.RDS")
saveRDS(object = gf2, file = "data/gf2-data.RDS")
saveRDS(object = gf3, file = "data/gf3-data.RDS")
saveRDS(object = gf4, file = "data/gf4-data.RDS")

# --------------

# Plots
tempogram_1 <- a_lydian |>
  tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(title="Tempogram of \'A Lydian\' - Analogue Dear", x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

tempogram_2 <- dont_feel_anything |>
  tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(title="Tempogram of \'I don\'t feel anything anymore\' - San Holo", x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

saveRDS(object = tempogram_1, file = "data/tempogram-1.RDS")
saveRDS(object = tempogram_2, file = "data/tempogram-2.RDS")

# --------------


