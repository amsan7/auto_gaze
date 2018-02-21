#!/bin/sh

vid=$SCRATCH/auto_gaze/raw_video/socref_21018_03_CV.MPG
#30054.f.25.V2-.mov
out_dir=$PI_HOME/auto_gaze_frames_emily

mkdir -p $out_dir

sbatch -p normal,hns -t 1:00:00 --mail-type=FAIL --mail-user=sanchez7@stanford.edu \
	--wrap="ffmpeg -i $vid -vf \"hflip,vflip,scale=720:480\" -vsync 0 $out_dir/image-%5d.jpg"
