import 'package:process_run/shell.dart';

class JoinTxtData {
  Future<void> joinReportesSAP(String rutaDatosSAP) async {
    var shell = Shell(
    );
    await shell.run('''
      ${rutaDatosSAP.substring(0, 2)}
      CD "$rutaDatosSAP"
      COPY "$rutaDatosSAP\\ACCO*.TXT" /y "$rutaDatosSAP\\TABLE_ACCOUNT.TXT"
      COPY "$rutaDatosSAP\\DEV*.TXT" /y "$rutaDatosSAP\\TABLE_DEVICE.TXT"
      COPY "$rutaDatosSAP\\INSTL*.TXT" /y "$rutaDatosSAP\\TABLE_INSTLN.TXT"
      COPY "$rutaDatosSAP\\MOV*.TXT" /y "$rutaDatosSAP\\TABLE_MOVE.TXT"
      COPY "$rutaDatosSAP\\PARTNER*.TXT" /y "$rutaDatosSAP\\TABLE_PARTNER.TXT"
      COPY "$rutaDatosSAP\\OBJC*.TXT" /y "$rutaDatosSAP\\TABLE_OBJCON.TXT"
      COPY "$rutaDatosSAP\\PREM*.TXT" /y "$rutaDatosSAP\\TABLE_PREMISE.TXT"
      COPY "$rutaDatosSAP\\PRD*.TXT" /y "$rutaDatosSAP\\TABLE_EVER.TXT"
      DEL "$rutaDatosSAP\\ACCO*.TXT"
      DEL "$rutaDatosSAP\\DEV*.TXT"
      DEL "$rutaDatosSAP\\INSTL*.TXT"
      DEL "$rutaDatosSAP\\MOV*.TXT"
      DEL "$rutaDatosSAP\\PARTNER*.TXT"
      DEL "$rutaDatosSAP\\OBJC*.TXT"
      DEL "$rutaDatosSAP\\PREM*.TXT"
      DEL "$rutaDatosSAP\\PRD*.TXT"
      ''');
  }

  Future<void> joinArchivosImpresion(
      String rutaArchivoImpresion, String vigencia) async {
    var shell = Shell();
    await shell.run('''
      ${rutaArchivoImpresion.substring(0, 2)}
      CD "$rutaArchivoImpresion"
      COPY "$rutaArchivoImpresion\\FAC*.TXT" /y "$rutaArchivoImpresion\\TABLE_$vigencia.TXT"
      DEL "$rutaArchivoImpresion\\FAC*.TXT"
      ''');
  }
}
