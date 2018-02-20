#!/bin/sh

module load system
module load singularity/2.4

vid=$SCRATCH/auto_gaze/raw_video/30054.f.25.V2-.mov
#vid=$PI_HOME/headcam_videos_rotated/XS_1230_objs.mov

sbatch --mail-type=FAIL --mail-user=sanchez7@stanford.edu \
	--wrap="singularity exec $SINGULARITY_CACHEDIR/openface-cambridge.img bash -c \
	'cd /opt/OpenFace/build/bin && ./FeatureExtraction -q -out_dir $PI_HOME/eyegaze -f $SCRATCH/auto_gaze/raw_video/30054.f.25.V2-.mov'"

