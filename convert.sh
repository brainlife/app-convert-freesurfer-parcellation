#!/bin/bash

set -x
set -e

anat=`jq -r '.t1' config.json`
freesurfer=`jq -r '.freesurfer' config.json`
parc=`jq -r '.parcellation' config.json`

[ ! -d parcellation ] && mkdir parcellation

export SUBJECTS_DIR=./
[ ! -f parcellation/parc.nii.gz ] && mri_vol2vol --mov ${freesurfer}/mri/${parc}+aseg.mgz --targ ${anat} --regheader --interp nearest --o parcellation/parc.nii.gz
