#pragma once
#ifdef __cplusplus
extern "C" {
#endif
int predict_inner(const double *input /* [18] */);
static const char *LABELS[5] = {
    "FALL",
    "MOTION",
    "NO_MOTION",
    "SIT_TO_STAND",
    "STAND_TO_SIT"
};
#ifdef __cplusplus
}
#endif
