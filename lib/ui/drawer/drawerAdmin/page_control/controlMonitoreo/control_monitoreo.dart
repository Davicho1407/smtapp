import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smtapp/ui/drawer/drawerAdmin/page_control/controlMonitoreo/analisis_datos.dart';
import 'package:smtapp/ui/drawer/drawerUser/paginacontrolUser/controlMonitoreo/datosFirebase.dart';

import 'cardImage.dart';

class ControlMonitoreo extends StatelessWidget {
  const ControlMonitoreo({super.key});
  static Widget create(BuildContext context) => ControlMonitoreo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
        title: const Text('Control de prototipo',
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
      body: _ManejoSensor(),
    );
  }
}

class _ManejoSensor extends StatefulWidget {
  const _ManejoSensor({super.key});

  @override
  State<_ManejoSensor> createState() => __ManejoSensorState();
}

class __ManejoSensorState extends State<_ManejoSensor> {
  String _dht22 = '0.00 °C';
  String _fc281 = '0 %';
  String _fc282 = '0 %';
  String _fc283 = '0 %';
  String _ph = '0';
  String _ph2 = '0';
  String _ph3 = '0';

  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _dailyDatosMonitoreoStream;

  @override
  void initState() {
    super.initState();
  }

  void _activateListeners() {
    _dailyDatosMonitoreoStream =
        _database.child('Sensores').onValue.listen((DatabaseEvent event) {
      final data = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final dailySpecial = DatosMonitoreo.fromRTDB(data);
      setState(() {
        _dht22 = dailySpecial.datoDht22();
        _fc281 = dailySpecial.fc281();
        _fc282 = dailySpecial.fc282();
        _fc283 = dailySpecial.fc283();
        _ph = dailySpecial.sensorpH();
        _ph2 = dailySpecial.sensorpH2();
        _ph3 = dailySpecial.sensorpH3();

        print(_dht22);
        print(_fc281);
        print(_ph);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              transform: Matrix4.translationValues(100, 0, 0),
              height: 50,
              width: 300,
              decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.all((Radius.circular(30)))),
              child: const Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  'Indicaciones',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'A continuación, le mostramos la funcionalidad del prototipo, en la cual podremos recaudar los datos de los sensores como lo son la temperatura, humedad y pH. Estas son fundamentales para a continuación realizar un análisis de que cultivo es más adaptable realizar en el terreno. ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              transform: Matrix4.translationValues(-80, 0, 0),
              height: 50,
              width: 300,
              decoration: const BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.all((Radius.circular(30)))),
              child: const Padding(
                padding: EdgeInsets.all(9),
                child: Text(
                  'Instrucciones de uso',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              height: 350.0,
              child: ListView(
                padding: const EdgeInsets.all(25.0),
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  CardImage(pathImage: "assets/img/Paso1.png"),
                  CardImage(pathImage: "assets/img/Paso2.png"),
                  CardImage(pathImage: "assets/img/Paso3.png")
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
                padding: EdgeInsets.all(20),
                height: 900,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.cyan.shade50,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    Center(
                      child:
                          Text('Temperatura', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_dht22',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Text('Humedad', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_fc281',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_fc282',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_fc283',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: Text('pH', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_ph',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_ph2',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all((Radius.circular(30)))),
                      child: Center(
                          child: Text(
                        '$_ph3',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        color: Colors.blue.shade900,
                        child: Text(
                          'Obtener datos',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          _activateListeners(); //generar valores random
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        color: Colors.blue.shade900,
                        child: Text(
                          'Ir ha analizar datos',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/analisisD');
                        }),
                  ],
                )),
            SizedBox(
              height: 30,
            )
          ],
        ));
  }

  @override
  void deactivate() {
    _dailyDatosMonitoreoStream.cancel();
    super.deactivate();
  }
}
