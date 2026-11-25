# ap convert freesurfer parcellation

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

**Converts a FreeSurfer 7.3.2 aparc, aparc.a2009s or aparc.DKTatlas +aseg volume into a volumetric parcellation resliced to the T1-weighted image with mri_vol2vol, with a FreeSurfer color-table label.json.**

Reslices mri/<parcellation>+aseg.mgz to the T1 image grid by header (nearest-neighbour), writes parc.nii.gz with a label.json built from the FreeSurfer color table, and tags the output with the chosen parcellation. The T1 must be in the same space as the FreeSurfer run (no registration is computed). Requires a FreeSurfer license.

Run it on brainlife.io: [https://doi.org/10.25663/brainlife.app.750](https://doi.org/10.25663/brainlife.app.750)

| Input | Datatype | Required | Description |
|---|---|---|---|
| `freesurfer` | `neuro/freesurfer` | yes | FreeSurfer recon-all output; mri/<parcellation>+aseg.mgz is used. |
| `anat` | `neuro/anat/t1w` | yes | T1-weighted image defining the output voxel grid. Must be aligned with the FreeSurfer anatomy; only the header is used. |

| Output | Datatype | Description |
|---|---|---|
| `parcellation` | `neuro/parcellation/volume` | Volumetric parcellation (parc.nii.gz) on the T1 grid with label.json, tagged with the chosen atlas. |

| Parameter | Type | Default | Description |
|---|---|---|---|
| `parcellation` | enum | `aparc.a2009s` | Which FreeSurfer atlas+aseg volume to convert: aparc (Desikan-Killiany), aparc.a2009s (Destrieux) or aparc.DKTatlas (DKT). Options: `aparc`, `aparc.a2009s`, `aparc.DKTatlas`. |

Runtime: container `brainlife/freesurfer:7.3.2`; 2 CPUs; 1.5 h walltime; needs `FREESURFER_LICENSE`.

<!-- brainlife-app:end -->

