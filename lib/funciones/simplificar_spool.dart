import 'dart:convert';
import 'dart:io';
import 'package:tablaz/funciones/cargando_data.dart';
import 'package:tablaz/objetos/objetos.dart';

class SimplificaSpoolTZ {
  //Cargando clase de funciones generales
  FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
  Future<List<List<dynamic>>> spoolTZ(String rutaSpool) async {
    List archivosSpool = Directory(rutaSpool).listSync();
    List<List<dynamic>> dataSpool = [];
    List<String> encabezado = [
      'ZZCTACONTR',
      'ZZDIRENVIO',
      'ZZDIAMEDID',
      'ZZLECACTUAL',
      'ZZLECANTERI',
      'ZZULTCONSUMO',
      'ZZCODULTCONS',
      'ZZCNSPROMHIST',
      'ZZINDINQUILIN',
      'ZZMESMORA',
      'ZZVLRTER',
      'IND_FRADIG',
      'ZZTELEFONO',
      'ZZCORREO'
    ];
    dataSpool.add(encabezado);
    for (int i = 1; i <= archivosSpool.length - 1; i++) {
      File archivoSpoolParcial = archivosSpool[i];
      var bytexTxt = archivoSpoolParcial.readAsBytesSync();
      String dataCargada = String.fromCharCodes(bytexTxt);
      LineSplitter lineasDataCargada = const LineSplitter();
      List<String> lineasCargadasParcial =
          lineasDataCargada.convert(dataCargada);
      for (int i = 0; i <= lineasCargadasParcial.length - 1; i++) {
        SpoolVigenciaActual vigAct =
            fz.dataSpoolActual(lineasCargadasParcial[i]);
        List<String> dataLineaSpool = [
          vigAct.ZZCTACONTR,
          vigAct.ZZDIRENVIO,
          vigAct.ZZDIAMEDID,
          vigAct.ZZLECACTUAL,
          vigAct.ZZLECANTERI,
          vigAct.ZZULTCONSUMO,
          vigAct.ZZCODULTCONS,
          vigAct.ZZCNSPROMHIST,
          vigAct.ZZINDINQUILIN,
          vigAct.ZZMESMORA,
          vigAct.ZZVLRTER,
          vigAct.IND_FRADIG,
          vigAct.ZZTELEFONO,
          vigAct.ZZCORREO
        ];
        dataSpool.add(dataLineaSpool);
      }
    }
    return dataSpool;
  }
}
