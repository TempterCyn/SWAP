# SWAP: Towards Copyright Auditing of Soft Prompts via Sequential Watermarking.

---

## Introduction

This repository contains training and evaluation pipelines for vision-language prompt learning on multiple recognition datasets.

Current implemented trainers include:

- `PromptSRC`
- `MaPLe`
- `CoCoOp`
- `CoOp`
- `IVLP` (independent V-L prompting)
- `ZSCLIP` (zero-shot CLIP baseline)

The project is organized for reproducible experiments in:

- Base-to-Novel generalization
- Cross-dataset / domain generalization
- Few-shot settings

---

## Overview

Pipeline overview (local source file):

- `E:\浏览器下载\POVSW_pipeline (1).pdf`

```text
SWAP/
├── clip/                     # CLIP model components
├── configs/                  # dataset and trainer configs
│   ├── datasets/
│   └── trainers/
├── datasets/                 # dataset registration / loading
├── docs/                     # installation, datasets, evaluation docs
├── scripts/                  # runnable bash scripts
│   ├── swap_promptsrc/
│   ├── swap_maple/
│   └── swap_cocoop/
├── trainers/                 # training logic for each method
├── train.py                  # main entrypoint
└── parse_test_res.py         # parse averaged test logs
```

---

## Getting Started

### 1) Environment

Recommended Python version: `3.8` (Ubuntu 20.04 tested in upstream docs).

```bash
conda create -y -n swap python=3.8
conda activate swap
pip install -r requirements.txt
```

Install PyTorch by following [pytorch.org](https://pytorch.org/) for your CUDA version.

### 2) Install Dassl.pytorch

```bash
git clone https://github.com/KaiyangZhou/Dassl.pytorch.git
cd Dassl.pytorch
pip install -r requirements.txt
python setup.py develop
cd ..
```

### 3) Prepare Datasets

Follow dataset preparation instructions in:

- [`docs/DATASETS.md`](docs/DATASETS.md)

Before running scripts, update the `DATA` variable in each script to your dataset root path.

---

## Running

All commands below should be executed at repository root.

### Base-to-Novel Training Scripts

```bash
# PromptSRC
bash scripts/swap_promptsrc/base2new_train.sh imagenet 1
# MaPLe
bash scripts/swap_maple/base2new_train_maple.sh imagenet 1
# CoCoOp
bash scripts/swap_cocoop/base2new_train.sh imagenet 1
```

---

## Main Results

The table below reports watermarking and verification performance (`WSR`, `p-value`, `Ĥ`) while also showing utility (`ACC Base/Novel`) on three datasets.

| Prompt Tuning Method | Protection Method | ImageNet (Base / Novel / WSR / p-value / Ĥ) | Caltech101 (Base / Novel / WSR / p-value / Ĥ) | OxfordPets (Base / Novel / WSR / p-value / Ĥ) |
|---|---|---|---|---|
| CoCoOp | SWAP (ours) | 75.89 / 70.10 / 99.98 / 0 / 0.00 | 97.65 / 93.10 / 99.67 / 0 / 0.01 | 94.92 / 97.40 / 99.36 / 0 / 0.00 |
| MaPLe | SWAP (ours) | 77.13 / 69.26 / 99.95 / 0 / 0.01 | 97.30 / 95.31 / 99.99 / 0 / 0.01 | 95.03 / 96.82 / 99.94 / 0 / 0.01 |
| PromptSRC | SWAP (ours) | 77.43 / 70.48 / 99.97 / 0 / 0.00 | 96.28 / 94.21 / 99.94 / 0 / 0.00 | 96.13 / 96.80 / 99.99 / 0 / 0.01 |

For full comparisons with baselines, please refer to your original Table 3 figure.

---

## Evaluation

```bash
python parse_test_res.py <output_dir> --test-log
```

---

## Notes

- If a target output directory already exists, scripts resume from saved outputs.
- Config files used by scripts are under `configs/trainers/<Trainer>/`.
- Default setup in scripts uses `16-shot` for base-to-novel unless changed.

---

## Acknowledgements

This codebase builds upon and adapts ideas from:

- [PromptSRC](https://github.com/muzairkhattak/PromptSRC)
- [MaPLe](https://github.com/muzairkhattak/multimodal-prompt-learning)
- [CoOp / Co-CoOp](https://github.com/KaiyangZhou/CoOp)
- [Dassl.pytorch](https://github.com/KaiyangZhou/Dassl.pytorch)

---

## Citation Info

Paper link: [https://arxiv.org/abs/2511.04711](https://arxiv.org/abs/2511.04711)
