#!/bin/bash

# custom config
DATA="/path/to/dataset/folder"
DIR="/path/to/model/folder"
TRAINER=SWAP_ATP
OUTPUT_DIR="/path/to/output/folder"

CFG=vit_b16_c2_ep5_batch4_2ctx
SHOTS=16

DATASET=caltech101

NCTX=2
EPO=5
SEED=1


CUDA_VISIBLE_DEVICES=0 python train.py \
        --root ${DATA} \
        --seed ${SEED} \
        --trainer ${TRAINER} \
        --dataset-config-file configs/datasets/${DATASET}.yaml \
        --config-file configs/trainers/SWAP_ATP/${CFG}.yaml \
        --output-dir ${OUTPUT_DIR}\
        --model-dir ${DIR} \
        --load-epoch ${EPO} \
        --eval-only \
        DATASET.NUM_SHOTS ${SHOTS} \
        TRAINER.MAPLE.N_CTX ${NCTX} \
        TRAINER.ATPROMPT.USE_ATPROMPT True \
        TRAINER.ATPROMPT.N_ATT1 ${NCTX} \
        TRAINER.ATPROMPT.N_ATT2 ${NCTX} \
        TRAINER.ATPROMPT.N_ATT3 ${NCTX} \
        DATASET.SUBSAMPLE_CLASSES new