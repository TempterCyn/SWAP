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

![SWAP Overview](docs/figures/overview.png)

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

![Main Results (Table 3)](docs/figures/table3.png)

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

## Citation

```bibtex
@misc{yang2025swapcopyrightauditingsoft,
      title={SWAP: Towards Copyright Auditing of Soft Prompts via Sequential Watermarking}, 
      author={Wenyuan Yang and Yichen Sun and Changzheng Chen and Zhixuan Chu and Jiaheng Zhang and Yiming Li and Dacheng Tao},
      year={2025},
      eprint={2511.04711},
      archivePrefix={arXiv},
      primaryClass={cs.CR},
      url={https://arxiv.org/abs/2511.04711}, 
}
```
