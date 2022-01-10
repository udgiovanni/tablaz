import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tablaz/ui/encabezado.dart';

class Validaciones extends StatefulWidget {
  const Validaciones({Key? key}) : super(key: key);

  @override
  _ValidacionesState createState() => _ValidacionesState();
}

class _ValidacionesState extends State<Validaciones> {
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
  bool cargando = false;
  String mensaje = '';
  bool tablaZCreada = false;
  @override
  Widget build(BuildContext context) {
    setState(() async {
      tablaZCreada = await tablaZ();
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (cargando) ...[
              Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Center(
                      child: Column(children: [
                    const Encabezado(),
                    Text(mensaje,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20)),
                    const SizedBox(height: 80),
                    const CircularProgressIndicator()
                  ])))
            ] else
              ...[]
          ],
        ),
      ),
    );
  }

  Future<bool> tablaZ() async {
    bool existenciaTablaZ;
    try {
      Directory dataDB = await getApplicationSupportDirectory();
      final db = sqlite3.open('${dataDB.path}\\\\database.sqlite3');
      // ignore: unused_local_variable
      final ResultSet dataTablaZ = db.select('SELECT * FROM TABLAZ');
      existenciaTablaZ = true;
    } catch (e) {
      existenciaTablaZ = false;
    }
    return existenciaTablaZ;
  }
}
