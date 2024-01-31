class DatosMonitoreo {
  final double sensorDht22;
  final int sensorFC281;
  final int sensorFC282;
  final int sensorFC283;
  final double sensorPH;
  final double sensorPH2;
  final double sensorPH3;

  DatosMonitoreo(
      {required this.sensorDht22,
      required this.sensorFC281,
      required this.sensorFC282,
      required this.sensorFC283,
      required this.sensorPH,
      required this.sensorPH2,
      required this.sensorPH3});

  factory DatosMonitoreo.fromRTDB(Map<String, dynamic> data) {
    return DatosMonitoreo(
        sensorDht22: data['SensorDht22'] ?? 0.0,
        sensorFC281: data['SensorFC281'] ?? 0,
        sensorFC282: data['SensorFC282'] ?? 0,
        sensorFC283: data['SensorFC283'] ?? 0,
        sensorPH: data['SensorpH'] ?? 0.0,
        sensorPH2: data['SensorpH2'] ?? 0.0,
        sensorPH3: data['SensorpH3'] ?? 0.0);
  }
  String datoDht22() {
    return '$sensorDht22 °C';
  }

  String fc281() {
    return '$sensorFC281 %';
  }

  String fc282() {
    return '$sensorFC282 %';
  }

  String fc283() {
    return '$sensorFC283 %';
  }

  String sensorpH() {
    return '$sensorPH ';
  }

  String sensorpH2() {
    return '$sensorPH2 ';
  }

  String sensorpH3() {
    return '$sensorPH3 ';
  }
}
