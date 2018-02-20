#!/bin/sh

module load system
module load singularity/2.4

vid=$SCRATCH/auto_gaze/raw_video/30054.f.25.V2-.mov
out_dir=$PI_HOME/eyegaze
out_file=results.features

sbatch --mail-type=FAIL --mail-user=sanchez7@stanford.edu \
	--wrap="singularity exec $SINGULARITY_CACHEDIR/openface-cambridge.img bash -c \
	'cd /opt/OpenFace/build/bin && ./FeatureExtraction -q -f $vid -outroot $out_dir -of $out_file'"

