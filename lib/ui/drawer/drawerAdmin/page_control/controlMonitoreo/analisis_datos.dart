import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../drawerUser/paginacontrolUser/controlMonitoreo/datosFirebase.dart';

class AnalizarDatos extends StatefulWidget {
  const AnalizarDatos({super.key});
  static Widget create(BuildContext context) => AnalizarDatos();

  @override
  State<AnalizarDatos> createState() => _AnalizarDatosState();
}

class _AnalizarDatosState extends State<AnalizarDatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        title: Text('Analizar datos',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/drawerAdmin');
          }),
        ),
      ),
      body: _DatosAnalisis(),
    );
  }
}

class _DatosAnalisis extends StatefulWidget {
  const _DatosAnalisis({super.key});

  @override
  State<_DatosAnalisis> createState() => __DatosAnalisisState();
}

class Planta {
  String nombre;
  double tempMin;
  double tempMax;
  double humedadMin;
  double humedadMax;
  double phMin;
  double phMax;

  Planta(
      {required this.nombre,
      required this.tempMin,
      required this.tempMax,
      required this.humedadMin,
      required this.humedadMax,
      required this.phMin,
      required this.phMax});
}

class PlantaMas {
  String nombre2;
  double tempMin2;
  double tempMax2;
  double humedadMin2;
  double humedadMax2;
  double phMin2;
  double phMax2;

  PlantaMas(
      {required this.nombre2,
      required this.tempMin2,
      required this.tempMax2,
      required this.humedadMin2,
      required this.humedadMax2,
      required this.phMin2,
      required this.phMax2});
}

class PlantaMenos {
  String nombre3;
  double tempMin3;
  double tempMax3;
  double humedadMin3;
  double humedadMax3;
  double phMin3;
  double phMax3;

  PlantaMenos(
      {required this.nombre3,
      required this.tempMin3,
      required this.tempMax3,
      required this.humedadMin3,
      required this.humedadMax3,
      required this.phMin3,
      required this.phMax3});
}

class __DatosAnalisisState extends State<_DatosAnalisis> {
  //Instancia de FirebaseDatabase
  final _database = FirebaseDatabase.instance.ref();
  //Sensores principales
  double temp = 0.0;
  double humedad1 = 0.0;
  double humedad2 = 0.0;
  double humedad3 = 0.0;
  double ph = 0.0;
  double ph2 = 0.0;
  double ph3 = 0.0;
////////////Susceptible/////////////
  ///Primer recuadro de planta con sensor fc281
  String nombrePlantaOptima = '';
  double tempMin = 0.0;
  double tempMax = 0.0;
  double humMin = 0.0;
  double humMax = 0.0;
  double phMin = 0.0;
  double phMax = 0.0;

  ///Segundo recuadro de planta con sensor fc282
  String nombrePlantaOptima2 = '';
  double tempMin2 = 0.0;
  double tempMax2 = 0.0;
  double humMin2 = 0.0;
  double humMax2 = 0.0;
  double phMin2 = 0.0;
  double phMax2 = 0.0;

  ///Tercer recuadro de planta con sensor fc283
  String nombrePlantaOptima3 = '';
  double tempMin3 = 0.0;
  double tempMax3 = 0.0;
  double humMin3 = 0.0;
  double humMax3 = 0.0;
  double phMin3 = 0.0;
  double phMax3 = 0.0;

  ////////////RegularMas/////////////
  ///Primer recuadro de planta con sensor fc281
  String nombrePlantaOptima4 = '';
  double tempMin4 = 0.0;
  double tempMax4 = 0.0;
  double humMin4 = 0.0;
  double humMax4 = 0.0;
  double phMin4 = 0.0;
  double phMax4 = 0.0;

  ///Segundo recuadro de planta con sensor fc282
  String nombrePlantaOptima5 = '';
  double tempMin5 = 0.0;
  double tempMax5 = 0.0;
  double humMin5 = 0.0;
  double humMax5 = 0.0;
  double phMin5 = 0.0;
  double phMax5 = 0.0;

  ///Tercer recuadro de planta con sensor fc283
  String nombrePlantaOptima6 = '';
  double tempMin6 = 0.0;
  double tempMax6 = 0.0;
  double humMin6 = 0.0;
  double humMax6 = 0.0;
  double phMin6 = 0.0;
  double phMax6 = 0.0;
/////////////RegularMenos///////////////
  ///  ///Primer recuadro de planta con sensor fc281
  String nombrePlantaOptima7 = '';
  double tempMin7 = 0.0;
  double tempMax7 = 0.0;
  double humMin7 = 0.0;
  double humMax7 = 0.0;
  double phMin7 = 0.0;
  double phMax7 = 0.0;

  ///Segundo recuadro de planta con sensor fc282
  String nombrePlantaOptima8 = '';
  double tempMin8 = 0.0;
  double tempMax8 = 0.0;
  double humMin8 = 0.0;
  double humMax8 = 0.0;
  double phMin8 = 0.0;
  double phMax8 = 0.0;

  ///Tercer recuadro de planta con sensor fc283
  String nombrePlantaOptima9 = '';
  double tempMin9 = 0.0;
  double tempMax9 = 0.0;
  double humMin9 = 0.0;
  double humMax9 = 0.0;
  double phMin9 = 0.0;
  double phMax9 = 0.0;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  //obtener los valores de temperatura, humedad y ph desde firebase realtime
  void _activateListeners() {
    _database.child('Sensores').once().then(
      (DatabaseEvent event) {
        final data = Map<String, dynamic>.from(
            event.snapshot.value as Map<dynamic, dynamic>);
        final dailySpecial = DatosMonitoreo.fromRTDB(data);
        setState(() {
          temp = double.parse(
              dailySpecial.datoDht22().replaceAll(RegExp('[^0-9.]'), ''));
          humedad1 = double.parse(
              dailySpecial.fc281().replaceAll(RegExp('[^0-9.]'), ''));
          humedad2 = double.parse(
              dailySpecial.fc282().replaceAll(RegExp('[^0-9.]'), ''));
          humedad3 = double.parse(
              dailySpecial.fc283().replaceAll(RegExp('[^0-9.]'), ''));
          ph = double.parse(
              dailySpecial.sensorpH().replaceAll(RegExp('[^0-9.]'), ''));
          ph2 = double.parse(
              dailySpecial.sensorpH2().replaceAll(RegExp('[^0-9.]'), ''));
          ph3 = double.parse(
              dailySpecial.sensorpH3().replaceAll(RegExp('[^0-9.]'), ''));

          print(temp);
          print(humedad1);
          print(humedad2);
          print(humedad3);
          print(ph);
          print(ph2);
          print(ph3);
          _determinarPlantaOptima1();
          _determinarPlantaOptima2();
          _determinarPlantaOptima3();
          _determinarPlantaOptima4();
          _determinarPlantaOptima5();
          _determinarPlantaOptima6();
          _determinarPlantaOptima7();
          _determinarPlantaOptima8();
          _determinarPlantaOptima9();
          // Recorrer la lista de plantas y verificar si los valores están dentro del rango óptimo para cada planta
        });
      },
    );
  }

////////////////////Susceptible/////////////////
  List<Planta> listaPlantasOptimas = [
    Planta(
        nombre: 'Papa',
        tempMin: 20,
        tempMax: 25,
        humedadMin: 20,
        humedadMax: 26,
        phMin: 5.5,
        phMax: 7),
    Planta(
        nombre: 'Trigo',
        tempMin: 17,
        tempMax: 22,
        humedadMin: 22,
        humedadMax: 29,
        phMin: 6,
        phMax: 7.5),
    Planta(
        nombre: 'Cebada',
        tempMin: 17,
        tempMax: 22,
        humedadMin: 22,
        humedadMax: 29,
        phMin: 6,
        phMax: 7.5),
    Planta(
        nombre: 'Alverja',
        tempMin: 15,
        tempMax: 19,
        humedadMin: 30,
        humedadMax: 36,
        phMin: 6,
        phMax: 7),
    Planta(
        nombre: 'Cebolla',
        tempMin: 15,
        tempMax: 19,
        humedadMin: 20,
        humedadMax: 25,
        phMin: 6,
        phMax: 7),
    Planta(
        nombre: 'Quinua',
        tempMin: 15,
        tempMax: 20,
        humedadMin: 34,
        humedadMax: 40,
        phMin: 6,
        phMax: 8),
    Planta(
        nombre: 'Haba',
        tempMin: 16,
        tempMax: 23,
        humedadMin: 27,
        humedadMax: 34,
        phMin: 6.3,
        phMax: 7.3),
    Planta(
        nombre: 'Frijol',
        tempMin: 17,
        tempMax: 23,
        humedadMin: 34,
        humedadMax: 40,
        phMin: 6.5,
        phMax: 7.5),
    Planta(
        nombre: 'Maiz',
        tempMin: 18,
        tempMax: 25,
        humedadMin: 21,
        humedadMax: 28,
        phMin: 6,
        phMax: 7.5),
  ];
////////////Planta optima con el sensor fc281
  void _determinarPlantaOptima1() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      Planta plantaOptima = listaPlantasOptimas.first;

      // Recorrer la lista de plantas
      for (Planta planta in listaPlantasOptimas) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin && temp <= planta.tempMax) {
          puntaje += 1;
        }
        if (humedad1 >= planta.humedadMin && humedad1 <= planta.humedadMax) {
          puntaje += 1;
        }
        if (ph >= planta.phMin && ph <= planta.phMax) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima = plantaOptima.nombre;
        tempMin = plantaOptima.tempMin;
        tempMax = plantaOptima.tempMax;
        humMin = plantaOptima.humedadMin;
        humMax = plantaOptima.humedadMax;
        phMin = plantaOptima.phMin;
        phMax = plantaOptima.phMax;
      });

      print('La planta más óptima es ${plantaOptima.nombre}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

////////////Planta optima con el sensor fc282
  void _determinarPlantaOptima2() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      Planta plantaOptima = listaPlantasOptimas.first;

      // Recorrer la lista de plantas
      for (Planta planta in listaPlantasOptimas) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin && temp <= planta.tempMax) {
          puntaje += 1;
        }
        if (humedad2 >= planta.humedadMin && humedad2 <= planta.humedadMax) {
          puntaje += 1;
        }
        if (ph2 >= planta.phMin && ph2 <= planta.phMax) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima2 = plantaOptima.nombre;
        tempMin2 = plantaOptima.tempMin;
        tempMax2 = plantaOptima.tempMax;
        humMin2 = plantaOptima.humedadMin;
        humMax2 = plantaOptima.humedadMax;
        phMin2 = plantaOptima.phMin;
        phMax2 = plantaOptima.phMax;
      });

      print('La planta más óptima es ${plantaOptima.nombre}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

////////////Planta optima con el sensor fc283
  void _determinarPlantaOptima3() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      Planta plantaOptima = listaPlantasOptimas.first;

      // Recorrer la lista de plantas
      for (Planta planta in listaPlantasOptimas) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin && temp <= planta.tempMax) {
          puntaje += 1;
        }
        if (humedad3 >= planta.humedadMin && humedad3 <= planta.humedadMax) {
          puntaje += 1;
        }
        if (ph3 >= planta.phMin && ph3 <= planta.phMax) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima3 = plantaOptima.nombre;
        tempMin3 = plantaOptima.tempMin;
        tempMax3 = plantaOptima.tempMax;
        humMin3 = plantaOptima.humedadMin;
        humMax3 = plantaOptima.humedadMax;
        phMin3 = plantaOptima.phMin;
        phMax3 = plantaOptima.phMax;
      });

      print('La planta más óptima es ${plantaOptima.nombre}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

  ////////////////////RegularMas/////////////////

  List<PlantaMas> listaPlantasRegularMas = [
    PlantaMas(
        nombre2: 'Papa',
        tempMin2: 26,
        tempMax2: 30,
        humedadMin2: 27,
        humedadMax2: 34,
        phMin2: 5.5,
        phMax2: 7),
    PlantaMas(
        nombre2: 'Trigo',
        tempMin2: 23,
        tempMax2: 30,
        humedadMin2: 30,
        humedadMax2: 38,
        phMin2: 6,
        phMax2: 7.5),
    PlantaMas(
        nombre2: 'Cebada',
        tempMin2: 23,
        tempMax2: 30,
        humedadMin2: 30,
        humedadMax2: 38,
        phMin2: 6,
        phMax2: 7.5),
    PlantaMas(
        nombre2: 'Alverja',
        tempMin2: 20,
        tempMax2: 25,
        humedadMin2: 37,
        humedadMax2: 44,
        phMin2: 6,
        phMax2: 7),
    PlantaMas(
        nombre2: 'Cebolla',
        tempMin2: 26,
        tempMax2: 32,
        humedadMin2: 26,
        humedadMax2: 30,
        phMin2: 6,
        phMax2: 7),
    PlantaMas(
        nombre2: 'Quinua',
        tempMin2: 21,
        tempMax2: 28,
        humedadMin2: 41,
        humedadMax2: 48,
        phMin2: 6,
        phMax2: 8),
    PlantaMas(
        nombre2: 'Haba',
        tempMin2: 24,
        tempMax2: 30,
        humedadMin2: 35,
        humedadMax2: 40,
        phMin2: 6.3,
        phMax2: 7.3),
    PlantaMas(
        nombre2: 'Frijol',
        tempMin2: 24,
        tempMax2: 28,
        humedadMin2: 29,
        humedadMax2: 34,
        phMin2: 6.5,
        phMax2: 7.5),
    PlantaMas(
        nombre2: 'Maiz',
        tempMin2: 26,
        tempMax2: 32,
        humedadMin2: 29,
        humedadMax2: 34,
        phMin2: 6,
        phMax2: 7.5),
  ];

  ////////////Planta optima con el sensor fc281
  void _determinarPlantaOptima4() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      PlantaMas plantaOptima = listaPlantasRegularMas.first;

      // Recorrer la lista de plantas
      for (PlantaMas planta in listaPlantasRegularMas) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin2 && temp <= planta.tempMax2) {
          puntaje += 1;
        }
        if (humedad1 >= planta.humedadMin2 && humedad1 <= planta.humedadMax2) {
          puntaje += 1;
        }
        if (ph >= planta.phMin2 && ph <= planta.phMax2) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima4 = plantaOptima.nombre2;
        tempMin4 = plantaOptima.tempMin2;
        tempMax4 = plantaOptima.tempMax2;
        humMin4 = plantaOptima.humedadMin2;
        humMax4 = plantaOptima.humedadMax2;
        phMin4 = plantaOptima.phMin2;
        phMax4 = plantaOptima.phMax2;
      });

      print('La planta más óptima es ${plantaOptima.nombre2}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

////////////Planta optima con el sensor fc282
  void _determinarPlantaOptima5() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      PlantaMas plantaOptima = listaPlantasRegularMas.first;

      // Recorrer la lista de plantas
      for (PlantaMas planta in listaPlantasRegularMas) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin2 && temp <= planta.tempMax2) {
          puntaje += 1;
        }
        if (humedad2 >= planta.humedadMin2 && humedad2 <= planta.humedadMax2) {
          puntaje += 1;
        }
        if (ph2 >= planta.phMin2 && ph2 <= planta.phMax2) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima5 = plantaOptima.nombre2;
        tempMin5 = plantaOptima.tempMin2;
        tempMax5 = plantaOptima.tempMax2;
        humMin5 = plantaOptima.humedadMin2;
        humMax5 = plantaOptima.humedadMax2;
        phMin5 = plantaOptima.phMin2;
        phMax5 = plantaOptima.phMax2;
      });

      print('La planta más óptima es ${plantaOptima.nombre2}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

////////////Planta optima con el sensor fc283
  void _determinarPlantaOptima6() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      PlantaMas plantaOptima = listaPlantasRegularMas.first;

      // Recorrer la lista de plantas
      for (PlantaMas planta in listaPlantasRegularMas) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin2 && temp <= planta.tempMax2) {
          puntaje += 1;
        }
        if (humedad3 >= planta.humedadMin2 && humedad3 <= planta.humedadMax2) {
          puntaje += 1;
        }
        if (ph3 >= planta.phMin2 && ph3 <= planta.phMax2) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima6 = plantaOptima.nombre2;
        tempMin6 = plantaOptima.tempMin2;
        tempMax6 = plantaOptima.tempMax2;
        humMin6 = plantaOptima.humedadMin2;
        humMax6 = plantaOptima.humedadMax2;
        phMin6 = plantaOptima.phMin2;
        phMax6 = plantaOptima.phMax2;
      });

      print('La planta más óptima es ${plantaOptima.nombre2}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }
////////////////////RegularMenos/////////////////

  List<PlantaMenos> listaPlantasRegularMenos = [
    PlantaMenos(
        nombre3: 'Papa',
        tempMin3: 15,
        tempMax3: 19,
        humedadMin3: 12,
        humedadMax3: 19,
        phMin3: 5.5,
        phMax3: 7),
    PlantaMenos(
        nombre3: 'Trigo',
        tempMin3: 12,
        tempMax3: 16,
        humedadMin3: 14,
        humedadMax3: 21,
        phMin3: 6,
        phMax3: 7.5),
    PlantaMenos(
        nombre3: 'Cebada',
        tempMin3: 12,
        tempMax3: 16,
        humedadMin3: 14,
        humedadMax3: 21,
        phMin3: 6,
        phMax3: 7.5),
    PlantaMenos(
        nombre3: 'Alverja',
        tempMin3: 10,
        tempMax3: 14,
        humedadMin3: 24,
        humedadMax3: 29,
        phMin3: 6,
        phMax3: 7),
    PlantaMenos(
        nombre3: 'Cebolla',
        tempMin3: 8,
        tempMax3: 15,
        humedadMin3: 15,
        humedadMax3: 19,
        phMin3: 6,
        phMax3: 7),
    PlantaMenos(
        nombre3: 'Quinua',
        tempMin3: 8,
        tempMax3: 14,
        humedadMin3: 24,
        humedadMax3: 33,
        phMin3: 6,
        phMax3: 8),
    PlantaMenos(
        nombre3: 'Haba',
        tempMin3: 15,
        tempMax3: 18,
        humedadMin3: 18,
        humedadMax3: 26,
        phMin3: 6.3,
        phMax3: 7.3),
    PlantaMenos(
        nombre3: 'Frijol',
        tempMin3: 12,
        tempMax3: 16,
        humedadMin3: 24,
        humedadMax3: 33,
        phMin3: 6.5,
        phMax3: 7.5),
    PlantaMenos(
        nombre3: 'Maiz',
        tempMin3: 12,
        tempMax3: 17,
        humedadMin3: 12,
        humedadMax3: 20,
        phMin3: 6,
        phMax3: 7.5),
  ];
////////////Planta optima con el sensor fc281
  void _determinarPlantaOptima7() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      PlantaMenos plantaOptima = listaPlantasRegularMenos.first;

      // Recorrer la lista de plantas
      for (PlantaMenos planta in listaPlantasRegularMenos) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin3 && temp <= planta.tempMax3) {
          puntaje += 1;
        }
        if (humedad1 >= planta.humedadMin3 && humedad1 <= planta.humedadMax3) {
          puntaje += 1;
        }
        if (ph >= planta.phMin3 && ph <= planta.phMax3) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima7 = plantaOptima.nombre3;
        tempMin7 = plantaOptima.tempMin3;
        tempMax7 = plantaOptima.tempMax3;
        humMin7 = plantaOptima.humedadMin3;
        humMax7 = plantaOptima.humedadMax3;
        phMin7 = plantaOptima.phMin3;
        phMax7 = plantaOptima.phMax3;
      });

      print('La planta más óptima es ${plantaOptima.nombre3}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

////////////Planta optima con el sensor fc282
  void _determinarPlantaOptima8() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      PlantaMenos plantaOptima = listaPlantasRegularMenos.first;

      // Recorrer la lista de plantas
      for (PlantaMenos planta in listaPlantasRegularMenos) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin3 && temp <= planta.tempMax3) {
          puntaje += 1;
        }
        if (humedad2 >= planta.humedadMin3 && humedad2 <= planta.humedadMax3) {
          puntaje += 1;
        }
        if (ph2 >= planta.phMin3 && ph2 <= planta.phMax3) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima8 = plantaOptima.nombre3;
        tempMin8 = plantaOptima.tempMin3;
        tempMax8 = plantaOptima.tempMax3;
        humMin8 = plantaOptima.humedadMin3;
        humMax8 = plantaOptima.humedadMax3;
        phMin8 = plantaOptima.phMin3;
        phMax8 = plantaOptima.phMax3;
      });

      print('La planta más óptima es ${plantaOptima.nombre3}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

////////////Planta optima con el sensor fc283
  void _determinarPlantaOptima9() {
    try {
      double mejorPuntaje = double.negativeInfinity;
      PlantaMenos plantaOptima = listaPlantasRegularMenos.first;

      // Recorrer la lista de plantas
      for (PlantaMenos planta in listaPlantasRegularMenos) {
        // Calcular el puntaje de la planta
        double puntaje = 0;
        if (temp >= planta.tempMin3 && temp <= planta.tempMax3) {
          puntaje += 1;
        }
        if (humedad3 >= planta.humedadMin3 && humedad3 <= planta.humedadMax3) {
          puntaje += 1;
        }
        if (ph3 >= planta.phMin3 && ph3 <= planta.phMax3) {
          puntaje += 1;
        }

        // Si la planta actual tiene un puntaje mayor al anterior, se convierte en la nueva planta óptima
        if (puntaje > mejorPuntaje) {
          mejorPuntaje = puntaje;
          plantaOptima = planta;
        }
      }
      setState(() {
        nombrePlantaOptima9 = plantaOptima.nombre3;
        tempMin9 = plantaOptima.tempMin3;
        tempMax9 = plantaOptima.tempMax3;
        humMin9 = plantaOptima.humedadMin3;
        humMax9 = plantaOptima.humedadMax3;
        phMin9 = plantaOptima.phMin3;
        phMax9 = plantaOptima.phMax3;
      });

      print('La planta más óptima es ${plantaOptima.nombre3}');
    } catch (e) {
      print('Se produjo un error al determinar la planta óptima: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Container(
            transform: Matrix4.translationValues(-70, 0, 0),
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.all((Radius.circular(30)))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
              child: Text(
                'Indicaciones',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Para una mayor toma de decisiones hemos optado en colocar un ánalisis de los datos obtenidos para que pueda establecer que planta esta concorde a los parametros obtenidos. ',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Asi llegamos al metodo semaforización, donde los colores representa lo siguiente',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 270,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Text(
                  'Sucepstible para cultivo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: Center(
                        //Colorcar un gestur detector
                        child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          "Temperatura óptima: ${tempMin} °C - ${tempMax} °C"),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                          "Humedad óptima: ${humMin} % - ${humMax}%"),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text("pH óptimo: ${phMin} - ${phMax}"),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      // agregar más información de la planta aquí
                                    ]),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ))),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima2}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima2,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura optima: ${tempMin2} °C - ${tempMax2} °C"),
                                    Text(
                                        "Humedad optima: ${humMin2} % - ${humMax2}%"),
                                    Text("pH optima: ${phMin2} - ${phMax2}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima3}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima3,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura optima: ${tempMin3} °C - ${tempMax3} °C"),
                                    Text(
                                        "Humedad optima: ${humMin3} % - ${humMax3}%"),
                                    Text("pH optimo: ${phMin3} - ${phMax3}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 270,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Text(
                  'Regular para cultivo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: Center(
                        //Colorcar un gestur detector
                        child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.yellowAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima4}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima4,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura regular: ${tempMin4} °C - ${tempMax4} °C"),
                                    Text(
                                        "Humedad regular: ${humMin4} % - ${humMax4}%"),
                                    Text("pH regular: ${phMin4} - ${phMax4}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ))),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.yellowAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima5}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima5,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura regular: ${tempMin5} °C - ${tempMax5} °C"),
                                    Text(
                                        "Humedad regular: ${humMin5} % - ${humMax5}%"),
                                    Text("pH regular: ${phMin5} - ${phMax5}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.yellowAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima6}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima6,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura regular: ${tempMin6} °C - ${tempMax6} °C"),
                                    Text(
                                        "Humedad regular: ${humMin6} % - ${humMax6}%"),
                                    Text("pH regular: ${phMin6} - ${phMax6}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            height: 270,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Text(
                  'No recomendado para cultivo',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: Center(
                        //Colorcar un gestur detector
                        child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima7}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima7,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura no regular: ${tempMin7} °C - ${tempMax7} °C"),
                                    Text(
                                        "Humedad no regular: ${humMin7} % - ${humMax7}%"),
                                    Text(
                                        "pH no regular: ${phMin7} - ${phMax7}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ))),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima8}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima8,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura no regular: ${tempMin8} °C - ${tempMax8} °C"),
                                    Text(
                                        "Humedad no regular: ${humMin8} % - ${humMax8}%"),
                                    Text(
                                        "pH no regular: ${phMin8} - ${phMax8}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 40,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all((Radius.circular(30)))),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                        ),
                        child: Center(
                            child: Text(
                          '${nombrePlantaOptima9}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(nombrePlantaOptima9,
                                  selectionColor: Colors.black),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "Temperatura no regular: ${tempMin9} °C - ${tempMax9} °C"),
                                    Text(
                                        "Humedad no regular: ${humMin9} % - ${humMax9}%"),
                                    Text(
                                        "pH no regular: ${phMin9} - ${phMax9}"),
                                    // agregar más información de la planta aquí
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("Cerrar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
