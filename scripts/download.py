import os
import csv

with open("../data/emily/ground_truth/sample_alessandro.csv", 'rb') as img_paths_f:
        img_paths = list(csv.reader(img_paths_f, delimiter=','))

for path in img_paths[1:]:
    new_dir = "~/xsface/sample_alessandro/"
    os.system("mkdir -p %s" % new_dir)
    os.system("scp sanchez7@sherlock.stanford.edu:/share/PI/mcfrank/auto_gaze/auto_gaze_frames_emily%s %s" % (path[714], new_dir))

