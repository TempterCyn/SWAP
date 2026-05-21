# SWAP: Prompt Learning Training and Evaluation Suite

> A clean research codebase for CLIP-based prompt learning methods, including PromptSRC, MaPLe, and CoCoOp.

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

## Running Experiments

All commands below should be executed at repository root.

### PromptSRC (Base-to-Novel)

Train on base classes:

```bash
bash scripts/swap_promptsrc/base2new_train.sh imagenet 1
```

Evaluate on novel classes:

```bash
bash scripts/swap_promptsrc/base2new_test.sh imagenet 1
```

### PromptSRC (Cross-Dataset / Domain Generalization)

```bash
bash scripts/swap_promptsrc/xd_train.sh imagenet 1
bash scripts/swap_promptsrc/xd_test.sh food101 1
```

### PromptSRC (Few-Shot)

```bash
bash scripts/swap_promptsrc/few_shot.sh food101 1 1
```

### MaPLe

```bash
bash scripts/swap_maple/base2new_train_maple.sh imagenet 1
bash scripts/swap_maple/base2new_test_maple.sh imagenet 1
```

### CoCoOp

```bash
bash scripts/swap_cocoop/base2new_train.sh imagenet 1
bash scripts/swap_cocoop/base2new_test.sh imagenet 1
```

---

## Evaluation and Result Parsing

Detailed evaluation instructions:

- [`docs/EVAL.md`](docs/EVAL.md)

Typical result parsing:

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

## Citation

If you use this repository in your research, please cite the corresponding papers for the method(s) you use.

