/// [Kalman.h]https://github.com/bachagas/Kalman

class KalmanFilter1D {
  double _q; //process noise covariance
  double _r; //measurement noise covariance
  double _x; //value
  double _p; //estimation error covariance
  double _k; //kalman gain

  KalmanFilter1D(double processNoise, double measurementNoise,
      double estimatedError, double intialValue) {
    this._q = processNoise;
    this._r = measurementNoise;
    this._p = estimatedError;
    this._x = intialValue;
  }

  double getFilteredValue(double measurement) {
    this._p = this._p + this._q;

    this._k = this._p / (this._p + this._r);
    this._x = this._x + this._k * (measurement - this._x);
    this._p = (1 - this._k) * this._p;

    return this._x;
  }

  void setParameters(
      double processNoise, double measurementNoise, {double estimatedError}) {
    this._q = processNoise;
    this._r = measurementNoise;
    if (estimatedError != null) {
      this._p = estimatedError;
    }
  }

  double getProcessNoise() {
    return this._q;
  }

  double getMeasurementNoise() {
    return this._r;
  }

  double getEstimatedError() {
    return this._p;
  }
}
