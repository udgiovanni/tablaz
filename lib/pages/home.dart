// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tablaz/funciones/simplificar_spool.dart';
import 'package:tablaz/pages/procesos_masivos/creacion_tabla_z.dart';
import 'package:tablaz/ui/encabezado.dart';
import 'package:csv/csv.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Definicio de Colores
  Color fondo = const Color(0xFF091d36);
  Color azul02 = const Color(0xFF3949AB);
  Color azul03 = const Color(0xFF9FA8DA);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (cargando) ...[
                Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                        child: Column(children: [
                      const Encabezado(),
                      Text(mensaje,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      const SizedBox(height: 80),
                      const CircularProgressIndicator()
                    ])))
              ] else ...[
                const Encabezado(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF103462),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 2,
                                offset: Offset(0, 3),
                                color: Colors.black54)
                          ]),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 550,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Acceso Rápido',
                              style: titulo,
                            ),
                            const Divider(color: Colors.white),
                            Text(
                              'Procesos Masivos',
                              style: titulo2,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 50,
                                color: Colors.white,
                              ),
                              title: Text('Creación Tabla Z', style: titulo3),
                              subtitle: Text(
                                  'Ingresa al modulo que automatiza la creación de la Tabla Z',
                                  style: cuerpo),
                              onTap: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CreacionTablaZ()));
                              },
                            ),
                            const SizedBox(height: 5),
                            ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 50,
                                color: Colors.white,
                              ),
                              title: Text('Simplificación SPOOL Tabla Z',
                                  style: titulo3),
                              subtitle: Text(
                                  'Simplifica la cantidad de datos almacenadas en el SPOOL para la creación de Tabla Z',
                                  style: cuerpo),
                              onTap: () async {
                                String? carpetaDataSpool =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Datos Spool');
                                if (carpetaDataSpool == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                } else {
                                  setState(() {
                                    cargando = true;
                                    mensaje = 'Simplificando Spool';
                                  });
                                  SimplificaSpoolTZ simplificaSpoolTZ =
                                      SimplificaSpoolTZ();
                                  List<List<dynamic>> dataSpool = await compute(
                                      simplificaSpoolTZ.spoolTZ,
                                      carpetaDataSpool);
                                  String csv = const ListToCsvConverter()
                                      .convert(dataSpool);
                                  showToast(
                                      'Simplificación de SPOOL Finalizada',
                                      context: context,
                                      duration: const Duration(seconds: 20));
                                  String? outputFile = await FilePicker.platform
                                      .saveFile(
                                          dialogTitle:
                                              'Seleccione La ruta de Salida:',
                                          fileName: 'SpoolReducido.csv');
                                  if (outputFile == null) {
                                    // User canceled the picker
                                  } else {
                                    final File csvExport =
                                        File(outputFile.toString());
                                    await csvExport.writeAsString(csv);
                                  }
                                  setState(() {
                                    cargando = false;
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF103462),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 0.5,
                                offset: Offset(3, 3),
                                color: Colors.black54)
                          ]),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 550,
                      child: Column(
                        children: [
                          Text(
                            'Documentación',
                            style: titulo,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
