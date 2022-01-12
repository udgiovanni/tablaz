// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tablaz/pages/procesos_masivos/creacion_tabla_z.dart';
import 'package:tablaz/pages/utilidades/utilidades.dart';
import 'package:tablaz/ui/encabezado.dart';
import 'package:url_launcher/url_launcher.dart';

import '../funciones/funciones_down_db.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Definicio de Colores
  Color fondo = const Color(0xFF091d36);
  Color azul02 = const Color.fromARGB(255, 23, 48, 83);
  Color azul03 = const Color.fromARGB(255, 2, 2, 3);
  TextStyle titulo = const TextStyle(
    fontSize: 20,
    color: Colors.white,
  );
  TextStyle titulo2 = const TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
  TextStyle titulo3 = const TextStyle(
      fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle cuerpo = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
  //Indicador de proceso
  bool cargando = false;
  //Mensaje de proceso
  String mensaje = '';
  //Exisitencia tabla Z
  bool tablaZ = false;
  @override
  void initState() {
    super.initState();
    //Valida Tabla Z
    existenciaTablaZ();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [azul02, fondo],
                stops: const [0.1, 0.9]),
          ),
          child: Column(
            children: [
              const Encabezado(),
              const SizedBox(width: 40),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40),
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 200,
                        ),
                        Text('TABLA Z',
                            style: GoogleFonts.spartan(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Text('CATASTRO DE USUARIOS',
                            style: GoogleFonts.spartan(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Text('DIRECCIÓN DE APOYO COMERCIAL',
                            style: GoogleFonts.spartan(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Text('GERENCIA SERVICIO AL CLIENTE',
                            style: GoogleFonts.spartan(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 70),
                        TextButton(
                            onPressed: () {
                              launchURL(
                                  'https://acueducto.sharepoint.com/sites/DACProyectosTI/Documentos%20compartidos/Forms/AllItems.aspx?id=%2Fsites%2FDACProyectosTI%2FDocumentos%20compartidos%2F01%20Tabla%20Z&viewid=5db9dd02%2Db3d5%2D4f8a%2D9f12%2Dc00800b59e16');
                            },
                            child: Container(
                                height: 30,
                                width: 180,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Documentación',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                )))
                      ],
                    ),
                    const SizedBox(width: 50),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Row(
                          children: [
                            if (tablaZ) ...[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 350,
                                    width: 350,
                                    child: const FlareActor(
                                        'assets/images/database.flr',
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: "gravity"),
                                  ),
                                  Text('La base de Datos Tabla Z Creada',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16, color: Colors.white)),
                                  const SizedBox(height: 50),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Utilidades()));
                                      },
                                      child: Container(
                                          height: 30,
                                          width: 180,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'Exportar Tabla Z',
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )))
                                ],
                              )
                            ] else ...[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 350,
                                    width: 350,
                                    child: const FlareActor(
                                        'assets/images/database.flr',
                                        alignment: Alignment.center,
                                        fit: BoxFit.contain,
                                        animation: "gravity"),
                                  ),
                                  Text('Base de datos Tabla Z inexistente',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16, color: Colors.white)),
                                  const SizedBox(height: 50),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreacionTablaZ()));
                                      },
                                      child: Container(
                                          height: 30,
                                          width: 180,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'Crear Tabla Z',
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )))
                                ],
                              )
                            ]
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  Future<String> rutaDB() async {
    final Directory documentosApp = await getApplicationDocumentsDirectory();
    String ruta = documentosApp.path;
    return ruta;
  }

  existenciaTablaZ() async {
    bool tablaZCreada = false;
    FuncionesDownDB dbConsult = FuncionesDownDB();
    Directory rutaDatabase = await getApplicationDocumentsDirectory();
    String ruta = rutaDatabase.path;
    bool tablaZCreadaValidador = await dbConsult.tablaZ(ruta);
    setState(() {
      tablaZ = tablaZCreadaValidador;
    });
  }

  readTxtBarrios(String path) async {
    String data = await rootBundle.loadString(path);
    print(data);
  }
}
