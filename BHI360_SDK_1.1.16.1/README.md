# Firmware Integration Summary

A step-by-step guide to embedding a custom machine-learning model on the **Bosch BHI360** smart-sensor platform—covering model conversion, driver creation, firmware compilation and deployment.

---

## 1  Development Environment Setup

| Tool | Purpose | Source |
| ---- | ------- | ------ |
| **GNU ARM Toolchain** | Cross-compile C for Cortex-M0+ | GitHub |
| **Eclipse IDE for C/C++** | Import / manage / build SDK | eclipse.org |
| **BHI360 SDK** | Drivers, abstractions & build scripts | Bosch developer portal |

> **Smoke test:** build the baseline firmware (`/release/gccfw`) and flash it with **Bosch Development Desktop 2.0** to verify the tool-chain.

---

## 2  Integrating the Machine-Learning Model

1. **Convert model ➜ C**

       m2cgen your_model.pkl -o libs/my_classifier/

2. **Generated files**

   * `model.c` – decision-tree logic (`predictInner`)
   * `model.h` – API & label map

3. **Wrap & register**

   * Add `model_infer()` wrapper in `model.c`
   * Guard names in `model.h`
   * Drop a `CMakeLists.txt` in `libs/my_classifier/` so CMake builds the library

---

## 3  Creating a Virtual Sensor Driver

* Duplicate a template into `drivers_custom/VirtMyClassifier/`
* Edit `VirtMyClassifier.c` to  
  1. collect / simulate feature vectors  
  2. call `model_infer()`  
  3. log / store the predicted class
* Add a `CMakeLists.txt` to compile & link the driver with the model and SDK runtime

---

## 4  Registering the Configuration

1. Create `boards/Bosch_Shuttle3_BHI360_MyModel.cfg`
2. Add `VirtMyClassifier` in the cfg alongside existing sensors
3. Update build system  

   * `boards/CMakeLists.txt` – register the board  
   * `common/config.7189_di03_rtos_bhi360.cmake` – include driver & board

---

## 5  Building the Custom Firmware

* In Eclipse, select **Bosch_Shuttle3_BHI360_MyModel** and _Build_
* Output:

       release/gccfw/Bosch_Shuttle3_BHI360_MyModel.fw

  Contains the embedded ML model, custom driver and full BHI360 sensor stack—no external libs required.

---

## 6  Flashing & Deployment

1. Connect the board and open **Bosch Development Desktop 2.0**
2. When prompted, select the new `.fw` file
3. After flashing, classification results stream via standard logs or registers

---

## 7  Final Firmware & Re-usability

* Flashable on any BHI360 board with identical hardware
* Published in the project GitHub repo under `/release/`

---
## Key Files Modified/Created

| Path | Description |
|------|-------------|
| `boards/Bosch_Shuttle3_BHI360_MyModel.cfg` | Custom board configuration |
| `boards/CMakeLists.txt` | Board registry update |
| `common/config.7189_di03_rtos_bhi360.cmake` | Build configuration |
| `libs/my_classifier/model.c` | Decision tree implementation |
| `libs/my_classifier/model.h` | Model API header |
| `libs/my_classifier/CMakeLists.txt` | Model build script |
| `drivers_custom/VirtMyClassifier/VirtMyClassifier.c` | Custom driver |
| `drivers_custom/VirtMyClassifier/CMakeLists.txt` | Driver build script |
| `release/gccfw/Bosch_Shuttle3_BHI360_MyModel.fw` | Final firmware image |


---

**Result:** a lean, self-contained firmware enabling real-time on-device inference for edge intelligence in wearable applications.
