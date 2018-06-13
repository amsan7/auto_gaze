compute_precision <- function(true_positives, false_positives) {
  ( true_positives / (true_positives + false_positives) ) %>% round(2)
}

compute_recall <- function(true_positives, false_negatives) {
  ( true_positives / (true_positives + false_negatives) ) %>% round(2)
}

compute_f <- function(precision, recall) {
  ( (2 * precision * recall) / (precision + recall) ) %>% round(2)
}


## below are two helper functions for smoothing model predictions based on prior knowledge
## about valid fixation lengths. 
## takes a dataframe with unsmoothed model predictions
## returns a dataframe with smoothed model predictions, removing short fixations

smooth_predictions <- function(df, fixation_len = 5) {
  by_trial <- df %>% 
    filter(!is.na(trial)) %>% 
    group_by(trial) %>% 
    nest()
  
  by_trial <- by_trial %>% 
    mutate(smoothed_pred = purrr::map(data, 
                                      smooth_predictions_trial, 
                                      fixation_len = fixation_len))
  
  unnest(by_trial, smoothed_pred)
}


smooth_predictions_trial <- function(df, fixation_len = fixation_len) {
  preds_vect <- df %>% pull(pred) %>% as.character()
  rle_enc <- rle(preds_vect)
  while(check_runs(rle_enc, fixation_length = fixation_len)) {
    print(rle_enc)
    first_bad_look_idx <- which(rle_enc$lengths <= fixation_len)[1]
    idx_start <- rle_enc$lengths[1:first_bad_look_idx-1] %>% sum() %>% +1
    idx_end <- rle_enc$lengths[1:first_bad_look_idx] %>% sum()
    first_bad_look_value <- rle_enc$values[first_bad_look_idx]
    preds_vect[idx_start:idx_end] <- flip_look(first_bad_look_value)
    rle_enc <- rle(preds_vect)
  }
  df %>% mutate(smoothed_pred = preds_vect)
}