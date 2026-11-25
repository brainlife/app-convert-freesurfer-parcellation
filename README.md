<h1 align="center">Convert FreeSurfer annotations to parcellation</h1>

<p align="center">
  A volumetric parcellation on the grid of a T1-weighted image from a FreeSurfer 7.3.2 aparc, aparc.a2009s or aparc.DKTatlas +aseg volume.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.750"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.750-blue.svg" alt="Run on brainlife.io"></a>
  <a href="https://github.com/brainlife/app-convert-freesurfer-parcellation/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

> 📍 **This branch, `app-v1.0_freesurfer-7.3.2`, is the brainlife.io App Convert freesurfer annotations to parcellation** ([doi:10.25663/brainlife.app.750](https://doi.org/10.25663/brainlife.app.750)).

## 🧠 At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Converts a FreeSurfer 7.3.2 aparc, aparc.a2009s or aparc.DKTatlas +aseg volume into a volumetric parcellation resliced to the T1-weighted image with mri_vol2vol, with a FreeSurfer color-table label.json.**

Reslices mri/<parcellation>+aseg.mgz to the T1 image grid by header (nearest-neighbour), writes parc.nii.gz with a label.json built from the FreeSurfer color table, and tags the output with the chosen parcellation. The T1 must be in the same space as the FreeSurfer run (no registration is computed). Requires a FreeSurfer license.

| | |
|---|---|
| 📥 **Inputs** | `neuro/freesurfer` · `neuro/anat/t1w` |
| 📤 **Outputs** | `neuro/parcellation/volume` |
| 🐳 **Container** | `brainlife/freesurfer:7.3.2` |
| ⚙️ **Resources** | 2 CPUs · 1.5 h walltime |
| 🔑 **Requires** | `FREESURFER_LICENSE` |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.750](https://doi.org/10.25663/brainlife.app.750) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `freesurfer` | `neuro/freesurfer` | yes | FreeSurfer recon-all output; mri/<parcellation>+aseg.mgz is used. |
| `anat` | `neuro/anat/t1w` | yes | T1-weighted image defining the output voxel grid. Must be aligned with the FreeSurfer anatomy; only the header is used. |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `parcellation` | `neuro/parcellation/volume` | Volumetric parcellation (parc.nii.gz) on the T1 grid with label.json, tagged with the chosen atlas. |

<details>
<summary><b>⚙️ Parameters</b> (1)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `parcellation` | enum | `aparc.a2009s` | Which FreeSurfer atlas+aseg volume to convert: aparc (Desikan-Killiany), aparc.a2009s (Destrieux) or aparc.DKTatlas (DKT). Options: `aparc`, `aparc.a2009s`, `aparc.DKTatlas`. |

</details>

<!-- brainlife-app:end -->

## 🚀 Running the App

### ☁️ On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.750](https://doi.org/10.25663/brainlife.app.750), choose a `neuro/freesurfer` dataset and the T1-weighted image (`neuro/anat/t1w`) it was computed from, pick the atlas in `parcellation` (`aparc` for Desikan-Killiany, `aparc.a2009s` for Destrieux, the default, or `aparc.DKTatlas` for DKT) and press **Execute**. The App archives a `neuro/parcellation/volume` dataset tagged with the chosen atlas, ready for any App that takes a volumetric parcellation.

The T1 image only defines the output voxel grid: `mri/<parcellation>+aseg.mgz` is resliced onto it by header with nearest-neighbour interpolation (`mri_vol2vol --regheader`), and no registration is computed. Use the T1 that is aligned with the FreeSurfer anatomy.

### 💻 Locally

You need [Singularity/Apptainer](https://apptainer.org/), [`jq`](https://jqlang.github.io/jq/) and a [FreeSurfer license](https://surfer.nmr.mgh.harvard.edu/registration.html). The App runs the `brainlife/freesurfer:7.3.2` container.

1. Clone this repository and check out the App branch: `git checkout app-v1.0_freesurfer-7.3.2`.
2. Create `config.json` with the paths to your inputs and the atlas you want:

   ```json
   {
       "freesurfer": "/input/freesurfer/output",
       "t1": "/input/t1/t1.nii.gz",
       "parcellation": "aparc.a2009s"
   }
   ```

3. Export your license and run the App:

   ```bash
   export FREESURFER_LICENSE="$(cat ~/freesurfer/license.txt)"
   ./main
   ```

## 📦 Outputs

```text
parcellation/parc.nii.gz   the chosen <atlas>+aseg volume on the T1 grid
product.json               tags the output with the chosen atlas
```

`label.json` in this repository maps each voxel value to its FreeSurfer color-table name and RGB colour.

## 🩺 Troubleshooting

- **`parcellation/parc.nii.gz` is not written**: check that the FreeSurfer output contains `mri/<parcellation>+aseg.mgz` for the atlas you chose, and that `FREESURFER_LICENSE` is set.

## 📚 Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Convert freesurfer annotations to parcellation. brainlife.io App. [doi:10.25663/brainlife.app.750](https://doi.org/10.25663/brainlife.app.750)
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## 👥 Authors

- Brad Caron
- Franco Pestilli (project director)

## 💰 Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## ⚖️ License

[MIT](https://github.com/brainlife/app-convert-freesurfer-parcellation/blob/master/LICENSE). FreeSurfer itself is distributed under its own [license](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense).
