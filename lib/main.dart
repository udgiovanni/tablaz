// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:process_run/shell.dart';
import 'package:sqlite3/open.dart';
import 'package:tablaz/funciones/funciones_load_db.dart';
import 'package:tablaz/pages/home.dart';
import 'package:tablaz/ui/encabezado.dart';
import 'package:window_size/window_size.dart';
import 'dart:ffi';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


Future<void> main() async {
  sqfliteFfiInit();
  //Cargando el Driver de SQLite
  DynamicLibrary _openWindows() {
  final libraryNextToScript = File('assets/sqlite3.dll');
  return DynamicLibrary.open(libraryNextToScript.path);
}
  open.overrideFor(OperatingSystem.windows, _openWindows);
  
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Tabla Z Catastro de Usuarios');
    setWindowMinSize(const Size(1000, 700));
    setWindowMaxSize(Size.infinite);
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Catastro de Usuarios Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Definicio de Colores
  Color fondo = const Color(0xFF091d36);
  Color azul02 = const Color(0xFF3949AB);
  Color azul03 = const Color(0xFF9FA8DA);

  //Colores Check carga de Archivos
  Color check01 = const Color(0xFF3949AB);
  Color check02 = const Color(0xFF3949AB);
  Color check03 = const Color(0xFF3949AB);
  Color check04 = const Color(0xFF3949AB);
  Color check05 = const Color(0xFF3949AB);
  Color check06 = const Color(0xFF3949AB);
  Color check07 = const Color(0xFF3949AB);
  Color check08 = const Color(0xFF3949AB);
  //Indicador Working APP, se actualiza mediante setState
  bool cargando = false;
  //Rutas donde estan almacenados los archivos de las 7 tablas descargadas de SAP
  String pathAccount = '';
  String pathDevice = '';
  String pathINSTLN = '';
  String pathMOVE = '';
  String pathOBJCON = '';
  String pathPARTNER = '';
  String pathPREMISE = '';
  String pathSIGUE = '';
  //Mensaje a Usuarios
  String mensaje = '';

  @override
  Widget build(BuildContext context) {
    //Obtener Ruta de los archivos Temporales del Equipo
    return Scaffold(
      backgroundColor: fondo,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const Encabezado(),
              const SizedBox(height: 30),
              const Text('Catastro de Usuarios',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const Text('Dirección de Apoyo Comercial',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const Text('Creación Tabla Z - Catastro Usuarios',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              const SizedBox(height: 40),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Boton 1
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
                    //Boton 2
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
                    //Boton 3
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
                    //Boton 4
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
                    //Boton 5
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
                    //Boton 6
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
                    //Boton 7
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
                    //Boton 8
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
              ),
              const SizedBox(height: 40),
              //Tabla Account
              Container(
                child: Column(
                  children: [if(cargando)...[
                    Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      child: Center(child: Column(
                        children: [
                          Text(mensaje, style: const TextStyle(color: Colors.white, fontSize: 20)),
                          const SizedBox(height: 80),
                          const CircularProgressIndicator()
                        ],
                      )))
                  ]else...[
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla ACCOUNT  (1)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla Account con los datos unificados en un solo archivo\nRuta cargada: $pathAccount',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  cuentas =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (cuentas != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check01 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String acoountLoad = cuentas.files.single.path.toString();
                              setState(() {
                                pathAccount = acoountLoad;
                              });
                              }else {
                                setState(() {
                                  check01 = azul02;
                                });
                              }
                        },
                      )),
                      const SizedBox(height: 20),
              //Tabla MOVE
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla MOVE  (2)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla Move con los datos unificados en un solo archivo\nRuta cargada: $pathMOVE',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  move =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (move != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check02 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String moveLoad = move.files.single.path.toString();
                              setState(() {
                                pathMOVE = moveLoad;
                              });
                              }else {
                                setState(() {
                                  check02 = azul02;
                                });
                              }
                        },
                      )),
                ],
              ),
                const SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla DEVICE  (3)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla Device con los datos unificados en un solo archivo\nRuta cargada: $pathDevice',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  device =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (device != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check03 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String deviceLoad = device.files.single.path.toString();
                              setState(() {
                                pathDevice = deviceLoad;
                              });
                              }else {
                                setState(() {
                                  check03 = azul02;
                                });
                              }
                        },
                      )),
                      const SizedBox(height: 20),
              //Tabla MOVE
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla INSTLN  (4)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla Instln con los datos unificados en un solo archivo\nRuta cargada: $pathINSTLN',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  instal =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (instal != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check04 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String instlLoad = instal.files.single.path.toString();
                              setState(() {
                                pathINSTLN = instlLoad;
                              });
                              }else {
                                setState(() {
                                  check04 = azul02;
                                });
                              }
                        },
                      )),
                ],
              ),
                const SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla OBJCON  (5)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla OBJCON con los datos unificados en un solo archivo\nRuta cargada: $pathOBJCON',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  objetoConexion =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (objetoConexion != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check05 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String objetoconeLoad = objetoConexion.files.single.path.toString();
                              setState(() {
                                pathOBJCON = objetoconeLoad;
                              });
                              }else {
                                setState(() {
                                  check05 = azul02;
                                });
                              }
                        },
                      )),
                      const SizedBox(height: 20),
              //Tabla PARTNER
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla PARTNER  (6)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla PARTNER con los datos unificados en un solo archivo\nRuta cargada: $pathPARTNER',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  partner =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (partner != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check06 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String partLoad = partner.files.single.path.toString();
                              setState(() {
                                pathPARTNER = partLoad;
                              });
                              }else {
                                setState(() {
                                  check06 = azul02;
                                });
                              }
                        },
                      )),
                ],
              ),
                const SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla PREMISE  (7)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla PREMISE con los datos unificados en un solo archivo\nRuta cargada: $pathPREMISE',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  premise =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (premise != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check07 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String premiseLoad = premise.files.single.path.toString();
                              setState(() {
                                pathPREMISE = premiseLoad;
                              });
                              }else {
                                setState(() {
                                  check07 = azul02;
                                });
                              }
                        },
                      )),
                      const SizedBox(height: 20),
                ],
              ),
              /*
--------------------------------------------------------------------------------------------------------------------------------------------------
              */
              const SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos de los txt Descargadaos de SAP',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Folder Seleccionado: $pathOBJCON',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          String? carpetaDatosSAP = await FilePicker.platform.getDirectoryPath(
                            dialogTitle: 'Seleccionar Carpeta TXT SAP'
                          );
                          if(carpetaDatosSAP == null){
                          }else{
                            print(carpetaDatosSAP);
                            var shell = Shell();
                            setState(() {
                              cargando = true;
                              mensaje = 'Uniendo Archivos TXT';
                            });
                            await shell.run('''
                            ${carpetaDatosSAP.substring(0,2)}
                            CD "${carpetaDatosSAP}"
                            COPY "$carpetaDatosSAP\\ACCO*.TXT" /y "$carpetaDatosSAP\\ACCOUNT_TABLE.TXT"
                            COPY "$carpetaDatosSAP\\DEV*.TXT" /y "$carpetaDatosSAP\\DEVICE_TABLE.TXT"
                            COPY "$carpetaDatosSAP\\INSTL*.TXT" /y "$carpetaDatosSAP\\INSTLN_TABLE.TXT"
                            COPY "$carpetaDatosSAP\\MOV*.TXT" /y "$carpetaDatosSAP\\MOVE_TABLE.TXT"
                            COPY "$carpetaDatosSAP\\PARTNER*.TXT" /y "$carpetaDatosSAP\\PARTNER_TABLE.TXT"
                            COPY "$carpetaDatosSAP\\OBJC*.TXT" /y "$carpetaDatosSAP\\OBJCON_TABLE.TXT"
                            COPY "$carpetaDatosSAP\\PREM*.TXT" /y "$carpetaDatosSAP\\PREMISE_TABLE.TXT"
                            ''');
                            setState(() {
                              cargando = false;
                              mensaje = 'Archivos Txt Unidos Satisfactoriamente';
                            });
                          }
                        },
                      )),
                      const SizedBox(height: 20),
              //Tabla PARTNER
                  Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'Cargar Datos Tabla PARTNER  (6)',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Importar Archivo TXT con los datos de la Tabla PARTNER con los datos unificados en un solo archivo\nRuta cargada: $pathPARTNER',
                          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        onTap: ()async{
                          //Seleccionado el archivo TXT Unificado de la Tabla Account
                          FilePickerResult ?  partner =
                          await FilePicker.platform
                              .pickFiles(
                              type: FileType.custom
                              allowedExtensions: ['txt']
                              );
                              if (partner != null) {
                              // Cambiando el Color del bottom para indicar que se obtuvo la ruta del archivo
                              setState(() {
                                check06 = Colors.yellow;
                              });
                              //Conviertiendo a String la ruta donde esta almacenado el Arhivo
                              String partLoad = partner.files.single.path.toString();
                              setState(() {
                                pathPARTNER = partLoad;
                              });
                              }else {
                                setState(() {
                                  check06 = azul02;
                                });
                              }
                        },
                      )),
                ],
              ),
              /* 
------------------------------------------------------------------------------------------------------------------------------------------------
              */
              ]]),
              ),
              Center(
                child:Column(
                  children: [
                    const SizedBox(height: 30),
                    TextButton(onPressed: ()async {
                      if(pathAccount == '' || pathMOVE == '' || pathDevice == ''||pathINSTLN == ''||pathOBJCON == ''||pathPARTNER == ''||pathPREMISE == ''
                      ){
                        showToast('No Se han Cargado todos los archivos necesarios',context: context, duration: const Duration(seconds: 5));
                      }else {
                      FuncionesLoadDatabase fzDB = FuncionesLoadDatabase();
                      setState(() {
                        cargando = true;
                        mensaje = 'Iniciando Carga de Archivos....';
                        check08 = Colors.yellow;
                      });
                      //Cuenta Contrato
                      final List<String> listAccount = await compute(fzDB.txtToListString, pathAccount);
                      final bool dataGuardada = await compute(fzDB.guardarDatosCuentasDB,listAccount);
                      if(dataGuardada){
                        setState(() {
                        mensaje = 'Datos de Cuentas Almacenados en la DB..';
                        check01 = Colors.green;
                      });
                      }else {
                        setState(() {
                        mensaje = 'Ocurrio un error al Cargar los datos a la Base de Datos';
                        check01 = Colors.red;
                        cargando = false;
                      });
                      }
                      //Datos Interlocutor Comercial
                      final List<String> listaInterComer = await compute(fzDB.txtToListString, pathPARTNER);
                      final bool dataSaveIntComercial = await compute(fzDB.guardarDatosIntComercialDB,listaInterComer);
                      setState(() {
                         mensaje = 'Datos de Interlocutor Comercial Almacenados en la DB..';
                        check06 = Colors.green;
                      });
                      //Datos alta de Instalación
                      final List<String> listaAltaInstalacion = await compute(fzDB.txtToListString, pathMOVE);
                      final bool dataSaveAltaInstalacion = await compute(fzDB.guardarAltaInstalacionDB,listaAltaInstalacion);
                      setState(() {
                         mensaje = 'Datos de Alta de Instalacion Almacenados en la DB..';
                        check02 = Colors.green;
                      });
                        //Datos Medidor
                        final List<String> listMedidor = await compute(fzDB.txtToListString, pathDevice);
                        final bool dataSavemedidor = await compute(fzDB.guardarMedidorDB,listMedidor);
                        setState(() {
                         mensaje = 'Datos de Medidores Almacenados en la DB..';
                        check03 = Colors.green;
                      });

                        //Datos Instalacion

                        final List<String> listaInstalacion = await compute(fzDB.txtToListString, pathINSTLN);
                        final bool dataSaveInstalacion = await compute(fzDB.guardarInstalacionesDB,listaInstalacion);
                        setState(() {
                         mensaje = 'Datos de Instalaciones Almacenados en la DB..';
                        check04 = Colors.green;
                      });
                        //Datos ObjetoConexion

                        final List<String> listaObjetoConexion = await compute(fzDB.txtToListString, pathOBJCON);
                        final bool dataObjetoConexion = await compute(fzDB.guardarObjetoConexionDB,listaObjetoConexion);
                        setState(() {
                          mensaje = 'Datos de Objetos de Conexiones Almacenados en la DB..';
                          check05 = Colors.green;
                        });
                        //Datos Punto de Suministro

                        final List<String> listaPuntoSuministro = await compute(fzDB.txtToListString, pathPREMISE);
                        final bool dataSavePuntoSuministro = await compute(fzDB.guardarPuntoSumiinistroDB,listaPuntoSuministro);
                        setState(() {
                          check07 = Colors.green;
                          mensaje = 'Realizando las uniones para crear la Tabla Z';
                        });
                        await compute(fzDB.crearTablaZ,'');
                        setState(() {
                          check08 = Colors.green;
                          cargando = false;
                        });
                        }
                    }, child: Container(
                      child: Column(
                        children: const[
                          Icon(Icons.navigate_next_outlined, color: Colors.white, size: 80),
                          Text('Crear Tabla Z', style: TextStyle(fontSize: 16, color: Colors.white))
                        ],
                      ),
                    ))
                  ],
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
