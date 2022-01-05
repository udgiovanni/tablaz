// ignore: dead_code
// ignore_for_file: dead_code, sized_box_for_whitespace

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tablaz/funciones/funciones_join_txt.dart';
import 'package:tablaz/funciones/funciones_load_db.dart';
import 'package:tablaz/objetos/objetos.dart';
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
  Color check09 = const Color(0xFF3949AB);
  Color check10 = const Color(0xFF3949AB);
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
          //Indicador Carga archivos Sap Cuenta Contrato
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
              //Indicador Carga archivos Sap Interlocutor Comercial
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
              //Indicador Carga de Archivos de alta de Instalación
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
              //Indicador Carga de Archivos medidor
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
              //Indicador Carga Instalaciones
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
              //Indicador Carga Objeto de Conexion
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
              //Indicador Carga punto de Suministro
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
              //Indicador carga datos Contrato
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
              const SizedBox(width: 20),
              //Indicador Spool de Impresion
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check09, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '9',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              //Indicador Creacion tabla Z
              Container(
                height: 50,
                width: 50,
                decoration:
                    BoxDecoration(color: check10, shape: BoxShape.circle),
                child: const Center(
                  child: Text(
                    '10',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
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
                                Icons.file_copy,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Archivo con Data Vigencia 01',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione el archivo simplificado del SPool de la Vigencia 1\n $datosV1',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                FilePickerResult? archivoVigencia1 =
                                    await FilePicker.platform.pickFiles(
                                        allowedExtensions: ['csv', 'txt'],
                                        dialogTitle: 'Archivo Vigencia 1');
                                if (archivoVigencia1 == null) {
                                  showToast('No se selecciono ningun Archivo',
                                      context: context);
                                  setState(() {
                                    check02 = const Color(0xFF3949AB);
                                    datosV1 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV1 = archivoVigencia1.files[0].path
                                        .toString();
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
                                Icons.file_copy,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Archivo Data Vigencia 02',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione el archivo simplificado del SPool de la Vigencia 2\n $datosV2',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                FilePickerResult? archivoVigencia2 =
                                    await FilePicker.platform.pickFiles(
                                        dialogTitle: 'Archivo Vigencia 02',
                                        allowedExtensions: ['csv', 'txt']);
                                if (archivoVigencia2 == null) {
                                  showToast('No se selecciono Ningun arhivo',
                                      context: context);
                                  setState(() {
                                    check03 = const Color(0xFF3949AB);
                                    datosV2 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV2 = archivoVigencia2.files[0].path
                                        .toString();
                                  });
                                }
                              }),
                        ),
                        //Container Vigencia 02
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: ListTile(
                              leading: const Icon(
                                Icons.file_copy,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Archivo Data Vigencia 03',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione el archivo simplificado del SPool de la Vigencia 3\n $datosV3',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                FilePickerResult? archivoVigencia3 =
                                    await FilePicker.platform.pickFiles(
                                        dialogTitle: 'Archivo Vigencia 3');
                                if (archivoVigencia3 == null) {
                                  showToast('No se selecciono Ningun Archivo',
                                      context: context);
                                  setState(() {
                                    check04 = const Color(0xFF3949AB);
                                    datosV3 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV3 = archivoVigencia3.files[0].path
                                        .toString();
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
                                Icons.file_copy,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Archivo Data Vigencia 04',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione el archivo simplificado del SPool de la Vigencia 4\n $datosV4',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                FilePickerResult? archivoVigencia4 =
                                    await FilePicker.platform.pickFiles(
                                        dialogTitle: 'Archivo Vigencia 04',
                                        allowedExtensions: ['csv', 'txt']);
                                if (archivoVigencia4 == null) {
                                  showToast('No se selecciono ningun Archivo',
                                      context: context);
                                  setState(() {
                                    check02 = const Color(0xFF3949AB);
                                    datosV1 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV4 = archivoVigencia4.files[0].path
                                        .toString();
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
                                Icons.file_copy,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Archivo Data Vigencia 05',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione el archivo simplificado del SPool de la Vigencia 5\n $datosV5',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                JoinTxtData jtxt = JoinTxtData();
                                FilePickerResult? archivoVigencia5 =
                                    await FilePicker.platform.pickFiles(
                                        dialogTitle:
                                            'Seleccionar Archivo Vigencia 5',
                                        allowedExtensions: ['csv', 'txt']);
                                if (archivoVigencia5 == null) {
                                  showToast('No se selecciono Ningun Archivo',
                                      context: context);
                                  setState(() {
                                    check06 = const Color(0xFF3949AB);
                                    datosV5 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV5 = archivoVigencia5.files[0].path
                                        .toString();
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
                                Icons.file_copy,
                                size: 70,
                                color: Colors.white,
                              ),
                              title: const Text(
                                'Archivo Data Vigencia 06',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Seleccione el archivo simplificado del SPool de la Vigencia 6\n $datosV6',
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              onTap: () async {
                                FilePickerResult? archivoVigencia6 =
                                    await FilePicker.platform.pickFiles(
                                        dialogTitle: 'Archivo Vigencia 6',
                                        allowedExtensions: ['.csv', '.txt']);
                                if (archivoVigencia6 == null) {
                                  showToast('No se selecciono Ningun Archivo',
                                      context: context);
                                  setState(() {
                                    check07 = const Color(0xFF3949AB);
                                    datosV6 = '';
                                  });
                                } else {
                                  setState(() {
                                    datosV6 = archivoVigencia6.files[0].path
                                        .toString();
                                  });
                                }
                              }),
                        ),
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
                      try {
                        setState(() {
                          cargando = true;
                          mensaje = 'Uniendo reportes de SAP';
                        });
                        showToast('Iniciando Proceso', context: context);
                      } catch (e) {
                        setState(() {
                          mensaje =
                              'Error durante la unión de los archivos de la Vigencia 1: $e';
                          check01 = Colors.red;
                        });
                      }

                      //Ejecutando la unión de los archivos de SAP con CMD (DOS)
                      try {
                        await jTXT.joinReportesSAP(datosSap);
                        setState(() {
                          mensaje = 'Uniendo Arhivos de Impresión Vigencia 1';
                        });
                      } catch (e) {
                        setState(() {
                          mensaje =
                              'Error durante la unión de los Reportes de SAP: "$e';
                          check01 = Colors.red;
                        });
                      }
                    }
                    //Creando y/o Cargando base de Datos
                    FuncionesLoadDatabase fzLoadDB = FuncionesLoadDatabase();
                    //Leyendo TXT y Cargando datos de Cuentas (ACCOUNT)
                    try {
                      final List<String> dataAccount = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_ACCOUNT.TXT');
                      await compute(
                          fzLoadDB.guardarDatosCuentasDB, dataAccount);
                      setState(() {
                        mensaje = 'Datos cuentas (ACCOUNT) almacenado en la DB';
                        check01 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla Account: $e';
                        check01 = Colors.red;
                      });
                    }
                    //Leyendo txt y Caragando Datos de Medidores (DEVICE)
                    try {
                      final List<String> dataDevice = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_DEVICE.TXT');
                      await compute(fzLoadDB.guardarMedidorDB, dataDevice);
                      setState(() {
                        mensaje = 'Datos Medidor (DEVICE) almacenado en la DB';
                        check02 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla Device: $e';
                        check01 = Colors.red;
                      });
                    }
                    //Leyendo txt y Cargando Datos de Instalación (INSTLN)
                    try {
                      final List<String> dataInstln = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_INSTLN.TXT');
                      await compute(
                          fzLoadDB.guardarInstalacionesDB, dataInstln);
                      setState(() {
                        mensaje =
                            'Datos Instalación (INSTLN) almacenado en la DB';
                        check03 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla INSTLN: $e';
                        check01 = Colors.red;
                      });
                    }
                    //Leyendo txt y Cargando Datos de la Alta de Instalación (MOVE-IN)
                    try {
                      final List<String> dataMoveIN = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_MOVE.TXT');
                      await compute(
                          fzLoadDB.guardarAltaInstalacionDB, dataMoveIN);
                      setState(() {
                        check04 = Colors.green;
                        mensaje =
                            'Datos Alta de Instalación (MOVE-IN) almacenado en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla MOVE-IN: $e';
                        check01 = Colors.red;
                      });
                    }
                    //Leyendo txt y Cargando Datos del Objeto de Conexión (CONNOBJ)
                    try {
                      final List<String> dataConnObj = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_OBJCON.TXT');
                      await compute(
                          fzLoadDB.guardarObjetoConexionDB, dataConnObj);
                      setState(() {
                        check05 = Colors.green;
                        mensaje =
                            'Datos Objeto de conexión (CONNOBJ) almacenado en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla CONNOBJ: $e';
                        check01 = Colors.red;
                      });
                    }
                    //Leyendo txt y Cargando datos del Interlocutor Comercial (PARTNER)
                    try {
                      final List<String> dataPartner = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_PARTNER.TXT');
                      await compute(
                          fzLoadDB.guardarDatosIntComercialDB, dataPartner);
                      setState(() {
                        check06 = Colors.green;
                        mensaje =
                            'Datos Interlocutor Comercial (PARTNER) almacenado en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla PARTNER: $e';
                        check01 = Colors.red;
                      });
                    }
                    //Leyendo txt y Cargando datos del Puntos de Suministro (PREMISE)
                    try {
                      final List<String> dataPremise = await compute(
                          fzLoadDB.txtToListString,
                          '$datosSap\\TABLE_PREMISE.TXT');
                      await compute(
                          fzLoadDB.guardarPuntoSumiinistroDB, dataPremise);
                      setState(() {
                        mensaje =
                            'Datos Punto de Suministros (PREMISE) almacenado en la DB';
                        check07 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento de la Tabla PREMISE: $e';
                        check07 = Colors.red;
                      });
                    }
                    //Cargando Datos Contrato (EVER)
                    try {
                      final List<String> dataEver = await compute(
                          fzLoadDB.txtToListStringANSI,
                          '$datosSap\\TABLE_EVER.TXT');
                      await compute(fzLoadDB.guardarContrato, dataEver);
                      setState(() {
                        mensaje = 'Datos de Contratos Almacenados en la DB';
                        check08 = Colors.green;
                      });
                    } catch (e) {
                      mensaje =
                          'Error durante la Lectura o Almacenamiento del Arhivo de contratos: $e';
                      check02 = Colors.red;
                    }
                    //Cargando Datos Spool Vigencia 01
                    try {
                      final List<String> datosVigencia =
                          await compute(fzLoadDB.txtToListStringANSI, datosV1);
                      SpoolDataTable spoolDataTable = SpoolDataTable();
                      spoolDataTable.nombreTabla = 'VIG01';
                      spoolDataTable.dataSpool = datosVigencia;
                      await compute(fzLoadDB.loadDataSpool, spoolDataTable);
                      setState(() {
                        mensaje = 'Datos Vigencia 01 Almacenados en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento del Arhivo de Impresión de la Vigencia 1: $e';
                        check09 = Colors.red;
                      });
                    }
                    //Cargando Datos Vigencia 2
                    try {
                      final List<String> datosVigencia =
                          await compute(fzLoadDB.txtToListStringANSI, datosV2);
                      SpoolDataTable spoolDataTable = SpoolDataTable();
                      spoolDataTable.nombreTabla = 'VIG02';
                      spoolDataTable.dataSpool = datosVigencia;
                      await compute(fzLoadDB.loadDataSpool, spoolDataTable);
                      setState(() {
                        mensaje = 'Datos Vigencia 2 Almacenados en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento del Arhivo de Impresión de la Vigencia 2: $e';
                        check09 = Colors.red;
                      });
                    }
                    //Cargando Datos Vigencia 3
                    try {
                      final List<String> datosVigencia =
                          await compute(fzLoadDB.txtToListStringANSI, datosV3);
                      SpoolDataTable spoolDataTable = SpoolDataTable();
                      spoolDataTable.nombreTabla = 'VIG03';
                      spoolDataTable.dataSpool = datosVigencia;
                      await compute(fzLoadDB.loadDataSpool, spoolDataTable);
                      setState(() {
                        mensaje = 'Datos Vigencia 3 Almacenados en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento del Arhivo de Impresión de la Vigencia 1: $e';
                        check09 = Colors.red;
                      });
                    }
                    //Cargando Datos Ultima Vigencia 4
                    try {
                      final List<String> datosVigencia =
                          await compute(fzLoadDB.txtToListStringANSI, datosV4);
                      SpoolDataTable spoolDataTable = SpoolDataTable();
                      spoolDataTable.nombreTabla = 'VIG04';
                      spoolDataTable.dataSpool = datosVigencia;
                      await compute(fzLoadDB.loadDataSpool, spoolDataTable);
                      setState(() {
                        mensaje = 'Datos Vigencia 4 Almacenados en la DB';
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento del Arhivo de Impresión de la Vigencia 1: $e';
                        check09 = Colors.red;
                      });
                    }
                    //Cargando Datos Vigencia 5
                    try {
                      final List<String> datosVigencia =
                          await compute(fzLoadDB.txtToListStringANSI, datosV5);
                      SpoolDataTable spoolDataTable = SpoolDataTable();
                      spoolDataTable.nombreTabla = 'VIG01';
                      spoolDataTable.dataSpool = datosVigencia;
                      await compute(fzLoadDB.loadDataSpool, spoolDataTable);
                      setState(() {
                        mensaje = 'Datos Vigencia 5 Almacenados en la DB';
                        check06 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento del Arhivo de Impresión de la Vigencia 5: $e';
                        check09 = Colors.red;
                      });
                    }
                    //Cargando Datos Vigencia 6
                    try {
                      final List<String> datosVigencia =
                          await compute(fzLoadDB.txtToListStringANSI, datosV6);
                      SpoolDataTable spoolDataTable = SpoolDataTable();
                      spoolDataTable.nombreTabla = 'VIG06';
                      spoolDataTable.dataSpool = datosVigencia;
                      await compute(fzLoadDB.loadDataSpool, spoolDataTable);
                      setState(() {
                        mensaje = 'Datos Vigencia 6 Almacenados en la DB';
                        check09 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Lectura o Almacenamiento del Arhivo de Impresión de la Vigencia 6: $e';
                        check09 = Colors.red;
                      });
                    }
                    //Generando Uniones de la Tabla Z
                    try {
                      await compute(fzLoadDB.crearTablaZ, '');
                      setState(() {
                        mensaje = 'Se ha Finalizado la Creación de la Tabla Z';
                        cargando = false;
                        check10 = Colors.green;
                      });
                    } catch (e) {
                      setState(() {
                        mensaje =
                            'Error durante la Unión de los Campos de la Tabla Z: $e';
                        cargando = false;
                        check10 = Colors.red;
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
