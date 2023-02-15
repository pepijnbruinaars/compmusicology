library(tidyverse)
library(spotifyr)

light <- spotifyr::get_track_audio_features("6AoG52kxfptY0QBQnjuQOe")
#pepsi <- spotifyr::get_playlist_audio_features("", "443PhwLJ63ci5JD8UpzNGf")

print(light)
