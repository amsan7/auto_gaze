### Test of interpolation function
library(purrr)
library(tidyverse)

add_phase_timing <- function(df_trial, df_feats) {
  start <- df_trial %>% pull(phase_onset_sec)
  end <- df_trial %>% pull(phase_offset_sec)
  
  # return the interpolated timing data
  df_feats %>% 
    filter(timestamp_rounded >= start, timestamp_rounded <= end) %>% 
    select(timestamp)
}


# Check if the interpolation function works on the first trial. 
test <- d_timing %>% 
  filter(trial %in% c("p1", "p2")) %>% 
  select(trial, phase, phase_onset_sec, phase_offset_sec) %>% 
  unique()

test_nest <- test %>% 
  group_by(trial, phase) %>% 
  nest()

blah <- test_nest %>% 
  mutate(timing = map(data, .f = add_phase_timing, df_feats = d_features)) %>% 
  unnest(timing) # pull out the timing information 

## Join with features

blah_final <- left_join(d_features, blah, by = "timestamp") 


# Plot to see if the timing of trials and phases looks reasonable

blah_final %>% 
  filter(!is.na(trial)) %>% 
  ggplot(aes(x = timestamp, y = phase, color = trial)) +
  geom_line()
