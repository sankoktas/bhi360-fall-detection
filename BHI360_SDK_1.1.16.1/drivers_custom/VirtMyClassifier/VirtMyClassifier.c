// drivers_custom/VirtMyClassifier/VirtMyClassifier.c

#include <SensorAPI.h>
#include <host.h>
#include <arc.h>
#include <hw_versions.h>
#include "model.h"     /* predict_inner(), my_model_infer() */

////////////////////////////////////////////////////////////////////////////////
// Local macros & definitions

#define DRIVER_REV                  (1u)
// DRIVER_ID is supplied via the CMakeLists.txt `-DDESCRIPTOR_NAME=virt_${DRIVER_KEY}_desc`
// and `SET(DRIVER_ID <your_id>)` there.

#define SENSOR_INPUT                BSX_INPUT_ID_ACCELERATION
#define SENSOR_TYPE_MY_CLASSIFIER   (SENSOR_TYPE_CUSTOMER_VISIBLE_START + 11)

////////////////////////////////////////////////////////////////////////////////
// Data structures

typedef struct {
    uint8_t label;   /* predicted class label */
    uint8_t confidence; 
} __attribute__((packed)) output_t;

////////////////////////////////////////////////////////////////////////////////
// Forward declarations

static SensorStatus handle_sensor_data(VirtualSensorDescriptor* self, void* raw);

////////////////////////////////////////////////////////////////////////////////
// Sensor driver implementation

static SensorStatus handle_sensor_data(VirtualSensorDescriptor* self, void* raw)
{
    // Get parent (physical accel) descriptor
    PhysicalSensorDescriptor* parent = cast_HeaderToPhysical(
        getSensorParent(cast_VirtualToHeader(self))
    );

    // Determine scale factor: raw counts → g units
    float dyn_range    = getDynamicRange(cast_PhysicalToHeader(parent));
    float scale_factor = parent->get_scale_factor(parent)
                       * (float)MAX_SINT16 / dyn_range;

    // raw points come as int32_t[3] (X, Y, Z)
    int32_t *s = (int32_t*)raw;
    double input[3] = {
        (double)(s[0] * scale_factor) / 32768.0,
        (double)(s[1] * scale_factor) / 32768.0,
        (double)(s[2] * scale_factor) / 32768.0
    };

    // Run quantized model inference
    uint8_t  pred = my_model_infer((int8_t*)s);

    // Package output
    output_t out = { pred, 100 };
    reportSensorEvent(self, &out, self->timestamp);

    return SensorOK;
}

////////////////////////////////////////////////////////////////////////////////
// Descriptor instantiation

VIRTUAL_SENSOR_DESCRIPTOR VirtualSensorDescriptor DESCRIPTOR_NAME = {
    .triggerSource = {
        .sensor = {
            .type = {
                .value = SENSOR_INPUT,
                .flags = DRIVER_TYPE_PHYSICAL_FLAG,
            },
        },
    },

    .physicalSource = {
        .sensor = {
            .type = {
                .value = SENSOR_INPUT,
                .flags = DRIVER_TYPE_PHYSICAL_FLAG,
            },
        },
    },

    .info = {
        .id      = DRIVER_ID,
        .version = DRIVER_REV,
    },

    .type = {
        .value     = SENSOR_TYPE_MY_CLASSIFIER,
        .flags     = DRIVER_TYPE_VIRTUAL_FLAG,
        .wakeup_ap = FALSE,
    },

    .outputPacketSize   = sizeof(output_t),
    .priority           = PRIORITY_2,
    .initialize         = NULL,
    .handle_sensor_data = handle_sensor_data,
};
