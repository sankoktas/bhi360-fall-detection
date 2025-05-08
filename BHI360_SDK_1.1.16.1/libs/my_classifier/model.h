// libs/my_classifier/model.h
#pragma once
#include <stdint.h>

#define MODEL_INPUT   (128 * 3)
#define MODEL_OUTPUT  5

#ifdef __cplusplus
extern "C" {
#endif

void predict_inner(const double *input, double *output);
uint8_t my_model_infer(const int8_t in[MODEL_INPUT]);

static const char *LABELS[MODEL_OUTPUT] = {
    "FALL",
    "MOTION",
    "NO_MOTION",
    "SIT_TO_STAND",
    "STAND_TO_SIT"
};

#ifdef __cplusplus
}
#endif
