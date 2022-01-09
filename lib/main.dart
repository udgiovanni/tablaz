// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';
import 'package:tablaz/pages/home.dart';
import 'package:window_size/window_size.dart';
import 'package:sqlite3/open.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Tabla Z Catastro de Usuarios');
    setWindowMinSize(const Size(1000, 700));
    setWindowMaxSize(Size.infinite);
  }
  open.overrideFor(OperatingSystem.windows, openSQLiteOnWindows);

  final db = sqlite3.openInMemory();
  db.dispose();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabla Z',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(title: ''),
    );
  }
}
