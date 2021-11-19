// ignore: dead_code
// ignore_for_file: dead_code, sized_box_for_whitespace

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tablaz/funciones/funciones_join_txt.dart';
import 'package:tablaz/ui/encabezado.dart';

class CreacionTablaZ extends StatefulWidget {
  CreacionTablaZ({Key? key}) : super(key: key);

  @override
  _CreacionTablaZState createState() => _CreacionTablaZState();
}

class _CreacionTablaZState extends State<CreacionTablaZ> {
  //Colores
  Color fondo = const Color(0xFF091d36);
  //Indicadores de estado de Proceso
  Color check01 = const Color(0xFF3949AB);
  Color check02 = const Color(0xFF3949AB);
  Color check03 = const Color(0xFF3949AB);
  Color check04 = const Color(0xFF3949AB);
  Color check05 = const Color(0xFF3949AB);
  Color check06 = const Color(0xFF3949AB);
  Color check07 = const Color(0xFF3949AB);
  Color check08 = const Color(0xFF3949AB);
  //Mensajes al usuarios
  String mensaje = '';
  //Rutas de las Carpetas donde estan almacenados los archivos
  String datosSap = '';
  String datosV1 = '';
  String datosV2 = '';
  String datosV3 = '';
  String datosV4 = '';
  String datosV5 = '';
  String datosV6 = '';
  bool cargando = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Encabezado(),
          //Indicador estado de Carga Archivos de SAP
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check01, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Carga Arhivos de Impresión Vigencia 01
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check02, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Carga de Archivos de Impresión Vigencia 02
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check03, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Carga de Archivos Impresión Vigencia 03
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check04, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '4',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Carga de Archivos Impresión Vigencia 04
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check05, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '5',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Carga de Archivos Impresión Vigencia 05
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check06, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '6',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Carga de Archivos de Impresión Vigencia 06
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check07, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '7',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Unión de Datos SQLITE
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check08, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '8',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              if (cargando) ...[
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                        child: Column(children: [
                      Text(mensaje,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      const SizedBox(height: 80),
                      const CircularProgressIndicator()
                    ])))
              ] else ...[
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Container para Cargar los Datos de SAP
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos SAP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione la Carpeta donde están almacenados los datos Descargados de SAP \n $datosSap',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaDatosSAP =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta TXT SAP');
                                if (carpetaDatosSAP == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check01 = const Color(0xFF3949AB);
                                    datosSap = '';
                                  });
                                } else {
                                  setState(() {
                                    datosSap = carpetaDatosSAP;
                                    check01 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                        //Containeer Carga de Datos de Facturación Vigencia 01
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos Vigencia 01',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Seleccione la Carpeta donde están almacenados los datos de Lectura de la Vigencia 01',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaVigencia =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Vigencia 01');
                                if (carpetaVigencia == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check02 = const Color(0xFF3949AB);
                                    datosV1 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV1 = carpetaVigencia;
                                    check02 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Container Vigencia 02
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos Vigencia 2',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Seleccione la Carpeta donde están almacenados los datos de Lectura de la Vigencia 2',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaVigencia =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Vigencia 2');
                                if (carpetaVigencia == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check03 = const Color(0xFF3949AB);
                                    datosV2 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV2 = carpetaVigencia;
                                    check03 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                        //Containeer Vigencia 02
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos Vigencia 3',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Seleccione la Carpeta donde están almacenados los datos de Lectura de la Vigencia 3',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaVigencia =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Vigencia 3');
                                if (carpetaVigencia == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check04 = const Color(0xFF3949AB);
                                    datosV3 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV3 = carpetaVigencia;
                                    check04 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Container vigencia 04
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos Vigencia 04',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Seleccione la Carpeta donde están almacenados los datos de Lectura de la Vigencia 04',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaVigencia =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Vigencia 04');
                                if (carpetaVigencia == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check02 = const Color(0xFF3949AB);
                                    datosV1 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV4 = carpetaVigencia;
                                    check05 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                        //Containeer Vigencia 05
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos Vigencia 5',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Seleccione la Carpeta donde están almacenados los datos de Lectura de la Vigencia 5',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaVigencia =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Vigencia 5');
                                if (carpetaVigencia == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check06 = const Color(0xFF3949AB);
                                    datosV5 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV5 = carpetaVigencia;
                                    check06 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Container vigencia 06
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ListTile(
                              leading: const Icon(
                                Icons.folder_open,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Folder Datos Vigencia 06',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: const Text(
                                'Seleccione la Carpeta donde están almacenados los datos de Lectura de la Vigencia 6',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                String? carpetaVigencia =
                                    await FilePicker.platform.getDirectoryPath(
                                        dialogTitle:
                                            'Seleccionar Carpeta Vigencia 6');
                                if (carpetaVigencia == null) {
                                  showToast('No se selecciono Ninguna Carpeta',
                                      context: context);
                                  setState(() {
                                    check07 = const Color(0xFF3949AB);
                                    datosV6 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV6 = carpetaVigencia;
                                    check07 = Colors.yellow;
                                  });
                                }
                              }),
                        ),
                        //Containeer Carga de Datos de Facturación Vigencia 01
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 60),
                TextButton(
                  onPressed: () async {
                    JoinTxtData jTXT = JoinTxtData();
                    if (datosSap == '' ||
                        datosV1 == '' ||
                        datosV2 == '' ||
                        datosV3 == '' ||
                        datosV4 == '' ||
                        datosV5 == '' ||
                        datosV6 == '') {
                      showToast(
                          'No se han seleccionado las carpetas necesarias',
                          context: context);
                    } else {
                      //Ejecutar Codigo crear Tabla Z
                      setState(() {
                        cargando = true;
                        mensaje = 'Uniendo reportes de SAP';
                      });
                      showToast('Iniciando Proceso', context: context);
                      await jTXT.joinReportesSAP(datosSap);
                      setState(() {
                        mensaje = 'Uniendo Arhivos de Impresión Vigencia 1';
                      });
                      await jTXT.joinArchivosImpresion(datosV1, 'V1');
                      setState(() {
                        mensaje = 'Uniendo Arhivos de Impresión Vigencia 2';
                      });
                      await jTXT.joinArchivosImpresion(datosV2, 'V2');
                      setState(() {
                        mensaje = 'Uniendo Arhivos de Impresión Vigencia 3';
                      });
                      await jTXT.joinArchivosImpresion(datosV3, 'V3');
                      setState(() {
                        mensaje = 'Uniendo Arhivos de Impresión Vigencia 4';
                      });
                      await jTXT.joinArchivosImpresion(datosV4, 'V4');
                      setState(() {
                        mensaje = 'Uniendo Arhivos de Impresión Vigencia 5';
                      });
                      await jTXT.joinArchivosImpresion(datosV4, 'V5');
                      setState(() {
                        mensaje = 'Uniendo Arhivos de Impresión Vigencia 6';
                      });
                      await jTXT.joinArchivosImpresion(datosV4, 'V6');
                      setState(() {
                        mensaje = 'Iniciando Carga de Datos de SAP';
                      });
                    }
                  },
                  child: Column(
                    children: const [
                      Icon(Icons.navigate_next_outlined,
                          color: Colors.white, size: 80),
                      Text('Crear Tabla Z',
                          style: TextStyle(fontSize: 16, color: Colors.white))
                    ],
                  ),
                )
              ],
            ],
          )
        ],
      )),
    );
  }
}
