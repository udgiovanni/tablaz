// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqlite3/open.dart';
import 'package:tablaz/pages/home.dart';
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
      title: 'Tabla Z',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Catastro de Usuarios Home'),
    );
  }
}
