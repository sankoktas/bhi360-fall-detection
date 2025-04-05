# 🧠 Fall Detection Pipeline with Sensor Data

This project implements a full pipeline for **human fall detection** using accelerometer and gyroscope data, annotated through **Label Studio**.

It includes:

- ✅ Label parsing and preprocessing
- 📊 Feature extraction (time-domain & frequency-domain)
- ⚙️ Data augmentation + SMOTE balancing
- 🤖 Classification using `HistGradientBoostingClassifier`
- 📈 Leave-One-Session-Out (LOSO) cross-validation
- 📉 Performance visualization with confusion matrices and metrics

---

## 🧾 Data Collection Info

- 📦 **Sensor:** Bosch BHI360 Shuttle Board  
- 🧠 **Firmware:** `Bosch_Shuttle3_BHI360_BMM150.fw`  
- 📈 **Sensor Configuration:**
  - Accelerometer (Corrected, Non-Wakeup) at **200 Hz**
  - Gyroscope (Corrected, Non-Wakeup) at **200 Hz**

Data was logged as JSON and then processed using this notebook for machine learning.

---

## 📁 Files & Structure

- `fall_detector.ipynb` – Main Jupyter notebook for preprocessing, training, evaluation
- `labeled_data/raw.csv` – Raw annotations exported from Label Studio
- `labeled_data/cleaned.csv` – Flattened per-timestep CSV with 3-class labels
- `labeled_data/cleaned_sorted_id.csv` – Final training-ready dataset with session IDs

---

## 🛠️ Label Studio Setup

Use this config when importing time series data into Label Studio:

```xml
<View>
  <TimeSeriesLabels name="tsLabels" toName="ts">
    <Label value="FALL" background="red"/>
    <Label value="MOTION" background="#ffea00"/>
    <Label value="NO MOTION" background="#05ff16"/>
  </TimeSeriesLabels>

  <TimeSeries name="ts" valueType="json" value="$tsData" timeColumn="timestamp_s" ordered="true">
    <Channel column="accel_x" legend="accel_x"/>
    <Channel column="accel_y" legend="accel_y"/>
    <Channel column="accel_z" legend="accel_z"/>
    <Channel column="gyro_x" legend="gyro_x"/>
    <Channel column="gyro_y" legend="gyro_y"/>
    <Channel column="gyro_z" legend="gyro_z"/>
  </TimeSeries>
</View>
