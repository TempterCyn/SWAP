# Readme

To test the project, follow the below steps to create environment and install dependencies.

## Environment Setup

* Setup conda environment (recommended).

```bash
# Create a conda environment
conda create -y -n maple python=3.8

# Activate the environment
conda activate maple

# Install torch (requires version >= 1.8.1) and torchvision
# Please refer to https://pytorch.org/ if you need a different cuda version
pip install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
```

* Install dassl library.

```bash
# Instructions borrowed from https://github.com/KaiyangZhou/Dassl.pytorch#installation

# Clone this repo
git clone https://github.com/KaiyangZhou/Dassl.pytorch.git
cd Dassl.pytorch/

# Install dependencies
pip install -r requirements.txt

# Install this library (no need to re-build if the source code is modified)
python setup.py develop
cd ..
```

## Dataset Setup

### Install caltech101 dataset

- Create a folder named `caltech-101/` under your data directory.
- Download `101_ObjectCategories.tar.gz` from http://www.vision.caltech.edu/Image_Datasets/Caltech101/101_ObjectCategories.tar.gz and extract the file under your data directory.
- Download `split_zhou_Caltech101.json` from this [link](https://drive.google.com/file/d/1hyarUivQE36mY6jSomru6Fjd-JzwcCzN/view?usp=sharing) and put it under your data directory. 

The directory structure should look like:

```
your_data_directory/
|–– caltech-101/
    |–– 101_ObjectCategories/
    |–– split_zhou_Caltech101.json
```

**Important**: You need to modify the `DATA` path in `test.sh` to point to your data directory:

```bash
# Open test.sh in a text editor
# Find this line:
DATA="/path/to/your/data/directory"
# Change it to your data directory path:
```

## Checkpoint Setup

Before testing, you need to download the pre-trained checkpoint files:

1. Download the checkpoint files for different seeds from [https://www.dropbox.com/scl/fo/x5544fq24by44xr9c336f/AOc_3c0Mwl2xBLXATaayOYE?rlkey=mdhlml4wdx5ywuutwwh4lxr8p&st=hc1g9zsl&dl=0](#) 
2. Create the following directory structure:

**For SWAP:**
```
output/base2new/train_base/caltech101/shots_16/SWAP/vit_b16_c2_ep10_batch4_2ctx/
```

**For SWAP_ATP:**
```
output/base2new/train_base/caltech101/shots_16/SWAP_ATP/vit_b16_c2_ep5_batch4_2ctx/
```

3. Place the downloaded seed folders (seed1, seed2, etc.) into the corresponding directories

## Testing Method

After setting up the environment, dataset, and checkpoints, you can run tests using the following commands:

### Testing SWAP

```bash
bash test.sh [SEED] [SUBSAMPLE_CLASSES]
```

### Testing SWAP_ATP

```bash
bash test_atp.sh
```

**Important**: Before running `test_atp.sh`, you need to modify the following paths in the script:
- `DATA`: Point to your dataset directory
- `DIR`: Point to your model checkpoint directory
- `OUTPUT_DIR`: Point to your desired output directory

The `test_atp.sh` script includes additional ATPROMPT parameters:
- `TRAINER.ATPROMPT.USE_ATPROMPT True`: Enable ATPROMPT functionality
- `TRAINER.ATPROMPT.N_ATT1`, `N_ATT2`, `N_ATT3`: Number of attention tokens for each attribute level

### Parameters for test.sh:

- SEED: The seed number corresponding to the checkpoint folder
  - `1`: Independent Prompt Model
  - `2`: SWAP method
- SUBSAMPLE_CLASSES: 
  - `base`: Test on base classes
  - `new`: Test on new classes

### Parameters for test_atp.sh:

The SWAP_ATP testing script uses fixed parameters but you can modify:
- `SEED`: Checkpoint seed number (default: 1)
- `EPO`: Epoch number to load (default: 5)
- `NCTX`: Number of context tokens (default: 2)
- `DATASET.SUBSAMPLE_CLASSES`: Set to `new` for testing on new classes

Examples:

```bash
# Test Independent Prompt Model on base classes
bash test.sh 1 base

# Test SWAP method on new classes
bash test.sh 2 new

# Test SWAP_ATP method
bash test_atp.sh
```

**Note**: 

- The SWAP system will calculate p-values for statistical significance testing when running `test.sh` with seed 2
- The SWAP_ATP system includes additional target class analysis and sequence verification with p-value calculations

## Results

After running the tests, you will get:

### SWAP & SWAP_ATP Results::
1. Classification accuracy on the selected dataset
2. Sequence verification statistics and p-values for statistical analysis

The results will be displayed in the console and also saved in the output directory.