import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tablaz/funciones/funciones_down_db.dart';
import 'package:tablaz/ui/encabezado.dart';
import '../../funciones/simplificar_spool.dart';

class Utilidades extends StatefulWidget {
  const Utilidades({Key? key}) : super(key: key);

  @override
  _UtilidadesState createState() => _UtilidadesState();
}

class _UtilidadesState extends State<Utilidades> {
  // Definicio de Colores
  Color fondo = const Color(0xFF091d36);
  Color azul02 = const Color.fromARGB(255, 23, 48, 83);
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
  //Valida Tabla Z
  bool tablaZCreada = false;
  FuncionesDownDB dbConsult = FuncionesDownDB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
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
              if (cargando) ...[
                SizedBox(
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
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black38,
                      ),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 80,
                      child: ListTile(
                        trailing: const Icon(Icons.navigate_next_rounded,
                            size: 50, color: Colors.green),
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: Text('Exportar a CSV Tabla Z', style: titulo3),
                        subtitle: Text(
                            "Exportar a CSV delimitado por ' ; ' Tabla Z",
                            style: cuerpo),
                        onTap: () async {
                          Directory rutaDatabase =
                              await getApplicationDocumentsDirectory();
                          String ruta = rutaDatabase.path;
                          bool tablaZCreadaValidador =
                              await dbConsult.tablaZ(ruta);
                          if (tablaZCreadaValidador) {
                            setState(() {
                              cargando = true;
                            });
                            String rutaDatabase = await rutaDB();
                            List<List<dynamic>> dataCSV = await compute(
                                dbConsult.tablaZCSV, rutaDatabase);
                            String csvCrudo =
                                const ListToCsvConverter().convert(dataCSV);
                            String csv = csvCrudo.replaceAll('null', '');
                            showToast('Creación Tabla Z Finalizada',
                                context: context,
                                duration: const Duration(seconds: 20));
                            String? outputFile = await FilePicker.platform
                                .saveFile(
                                    dialogTitle:
                                        'Seleccione La ruta de Salida:',
                                    fileName: 'tabla.csv');
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
                          } else {
                            showToast(
                                'No se ha creado la Tabla Z, revisar en la carpeta Documentos el arhivos database.sqlite3',
                                context: context,
                                duration: const Duration(seconds: 20));
                          }
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black38,
                      ),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 80,
                      child: ListTile(
                        trailing: const Icon(Icons.navigate_next_rounded,
                            size: 50, color: Colors.green),
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: Text('Simplificación SPOOL Tabla Z',
                            style: titulo3),
                        subtitle: Text(
                            'Simplifica SPOOL para la creación de Tabla Z',
                            style: cuerpo),
                        onTap: () async {
                          String? carpetaDataSpool = await FilePicker.platform
                              .getDirectoryPath(
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
                                simplificaSpoolTZ.spoolTZ, carpetaDataSpool);
                            String csv =
                                const ListToCsvConverter().convert(dataSpool);
                            showToast('Simplificación de SPOOL Finalizada',
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
                      ),
                    )
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  Future<String> rutaDB() async {
    final Directory documentosApp = await getApplicationDocumentsDirectory();
    String ruta = documentosApp.path;
    return ruta;
  }
}
