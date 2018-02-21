import os
import csv

with open("../data/gold_set_candidates.csv", 'rb') as img_paths_f:
        img_paths = list(csv.reader(img_paths_f, delimiter=','))

for path in img_paths[1:]:
    os.system("mkdir -p ~/xsface/auto_gaze_sample/")
    os.system("scp sanchez7@sherlock.stanford.edu:/share/PI/mcfrank/auto_gaze_frames%s ~/xsface/auto_gaze_sample/" % (path[431]))

