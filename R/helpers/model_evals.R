compute_precision <- function(true_positives, false_positives) {
  ( true_positives / (true_positives + false_positives) ) %>% round(2)
}

compute_recall <- function(true_positives, false_negatives) {
  ( true_positives / (true_positives + false_negatives) ) %>% round(2)
}

compute_f <- function(precision, recall) {
  ( (2 * precision * recall) / (precision + recall) ) %>% round(2)
}