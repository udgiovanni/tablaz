import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class DatabaseClass {
  Future<Database> getDatabase() async {
    final Directory directoryApp = await getTemporaryDirectory();
    final db = sqlite3.open('${directoryApp.path}\\database.sqlite3');
    return db;
  }
}
