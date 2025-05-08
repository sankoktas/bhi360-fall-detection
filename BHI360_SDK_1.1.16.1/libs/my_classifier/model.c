#include "model.h"
#include <string.h>
#include <float.h>

/* ── Internal tree inference function ───────────────────────────────────── */
void predict_inner(const double *input, double *output)
{
    double var0[5];

    /* ==== Your full tree logic starts here ==== */
    if (input[3] <= 24.943058013916016) {
        if (input[3] <= 5.241030693054199) {
            if (input[0] <= 23.809596061706543) {
                if (input[4] <= 2.779699921607971) {
                    if (input[17] <= 16.88913059234619) {
                        memcpy(var0, (double[]){0.0, 0.024991322457480043, 0.9711905588337383, 0.003471017007983339, 0.0003471017007983339}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.0, 0.8571428571428571, 0.14285714285714285, 0.0, 0.0}, 5 * sizeof(double));
                    }
                } else {
                    if (input[0] <= 3.7083864212036133) {
                        memcpy(var0, (double[]){0.0, 0.02564102564102564, 0.9560439560439561, 0.01098901098901099, 0.007326007326007326}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.0036003600360036, 0.1404140414041404, 0.6426642664266426, 0.10711071107110712, 0.10621062106210621}, 5 * sizeof(double));
                    }
                }
            } else {
                if (input[15] <= 6.9438183307647705) {
                    if (input[6] <= 2.5798499584198) {
                        memcpy(var0, (double[]){0.0, 0.9090909090909091, 0.09090909090909091, 0.0, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.041666666666666664, 0.20833333333333334, 0.6111111111111112, 0.027777777777777776, 0.1111111111111111}, 5 * sizeof(double));
                    }
                } else {
                    if (input[7] <= 11.179136753082275) {
                        memcpy(var0, (double[]){0.0, 0.4166666666666667, 0.5833333333333334, 0.0, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.0, 0.8736842105263158, 0.11578947368421053, 0.0, 0.010526315789473684}, 5 * sizeof(double));
                    }
                }
            }
        } else {
            if (input[2] <= -0.8555665016174316) {
                if (input[0] <= 46.84600067138672) {
                    if (input[17] <= 14.775031089782715) {
                        memcpy(var0, (double[]){0.08703703703703704, 0.3, 0.2962962962962963, 0.07222222222222222, 0.24444444444444444}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.0029498525073746312, 0.046214355948869225, 0.0584070796460177, 0.013372664700098328, 0.8790560471976401}, 5 * sizeof(double));
                    }
                } else {
                    if (input[6] <= 29.272048950195312) {
                        memcpy(var0, (double[]){0.06250000000000001, 0.9162234042553192, 0.009973404255319151, 0.0, 0.011303191489361705}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.5798816568047337, 0.42011834319526625, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                    }
                }
            } else {
                if (input[0] <= 55.01298522949219) {
                    if (input[15] <= 7.970640182495117) {
                        memcpy(var0, (double[]){0.004580152671755725, 0.05362595419847328, 0.08740458015267176, 0.8398854961832061, 0.01450381679389313}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.016897081413210446, 0.5391705069124424, 0.17665130568356374, 0.250384024577573, 0.016897081413210446}, 5 * sizeof(double));
                    }
                } else {
                    if (input[15] <= 4.9785542488098145) {
                        memcpy(var0, (double[]){0.24688279301745636, 0.4164588528678304, 0.00997506234413965, 0.3266832917705736, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.1092436974789916, 0.8644257703081233, 0.0061624649859943975, 0.020168067226890758, 0.0}, 5 * sizeof(double));
                    }
                }
            }
        }
    } else {
        if (input[12] <= 78.445068359375) {
            if (input[11] <= 1.0967718362808228) {
                if (input[7] <= 26.279294967651367) {
                    if (input[12] <= 1.031596064567566) {
                        memcpy(var0, (double[]){0.4, 0.6, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){1.0, 0.0, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                    }
                } else {
                    memcpy(var0, (double[]){0.0, 1.0, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                }
            } else {
                if (input[16] <= 1.9251015782356262) {
                    if (input[16] <= 0.09848652780056) {
                        memcpy(var0, (double[]){0.6444444444444445, 0.3111111111111111, 0.044444444444444446, 0.0, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.9639314697926059, 0.03223624887285843, 0.003381424706943192, 0.0, 0.0004508566275924256}, 5 * sizeof(double));
                    }
                } else {
                    if (input[17] <= 18.581826210021973) {
                        memcpy(var0, (double[]){0.23529411764705882, 0.6764705882352942, 0.08823529411764706, 0.0, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.7, 0.3, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                    }
                }
            }
        } else {
            if (input[10] <= 239.96710205078125) {
                if (input[0] <= 10.948740005493164) {
                    memcpy(var0, (double[]){0.0, 0.0, 0.8333333333333334, 0.0, 0.16666666666666666}, 5 * sizeof(double));
                } else {
                    if (input[2] <= -5.759261846542358) {
                        memcpy(var0, (double[]){0.0, 0.0, 0.0, 0.0, 1.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.0, 0.0, 0.0, 0.6, 0.4}, 5 * sizeof(double));
                    }
                }
            } else {
                if (input[3] <= 46.53275108337402) {
                    memcpy(var0, (double[]){0.0, 1.0, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                } else {
                    if (input[8] <= 5.150941371917725) {
                        memcpy(var0, (double[]){1.0, 0.0, 0.0, 0.0, 0.0}, 5 * sizeof(double));
                    } else {
                        memcpy(var0, (double[]){0.8, 0.0, 0.2, 0.0, 0.0}, 5 * sizeof(double));
                    }
                }
            }
        }
    }

    memcpy(output, var0, 5 * sizeof(double));
}

/* ── Public firmware entrypoint ─────────────────────────────────────────── */
uint8_t my_model_infer(const int8_t in_q7[MODEL_INPUT])
{
    double input_d[18];
    for (uint8_t i = 0; i < 18; ++i)
        input_d[i] = (double)in_q7[i];

    double prob[5];
    predict_inner(input_d, prob);

    uint8_t best = 0;
    for (uint8_t i = 1; i < 5; ++i)
        if (prob[i] > prob[best]) best = i;

    return best;
}