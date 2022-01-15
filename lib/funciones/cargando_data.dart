import 'package:tablaz/objetos/objetos.dart';

class FuncionesGeneralesTablaZ {
  String tryStringCortar(String text, int inicio, int fin) {
    String result;
    try {
      result = text.substring(inicio, fin).trim();
    } catch (e) {
      result = '';
    }
    return result;
  }

  String tryStringFin(String text, int inicio) {
    String result;
    try {
      result = text.substring(inicio).trim();
    } catch (e) {
      result = '';
    }
    return result;
  }

  String tryInt(String text, int inicio, int fin) {
    String result;
    try {
      result = int.parse(text.substring(inicio, fin)).toString();
    } catch (e) {
      result = '';
    }
    return result.toString();
  }

  CuentaContratoType dataCuenta(String account) {
    CuentaContratoType result = CuentaContratoType();
    result.VKONT = tryStringCortar(account, 0, 12);
    result.GPART = tryStringCortar(account, 12, 22);
    result.VKTYP = tryStringCortar(account, 22, 24);
    result.STREET = tryStringCortar(account, 24, 84);
    result.VKBEZ = tryStringCortar(account, 84, 119);
    result.VKONA = tryStringCortar(account, 119, 139);
    result.REGIOGR_CA_T = tryStringCortar(account, 139, 147);
    result.KTOKL = tryStringCortar(account, 147, 151);
    result.KOFIZ_SD = tryStringCortar(account, 151, 153);
    result.ABWVK = tryStringCortar(account, 153, 165);
    result.FORMKEY = tryStringCortar(account, 165, 195);
    result.ZZDIR = tryStringCortar(account, 195, 255);
    result.IKEY = tryStringCortar(account, 255, 257);
    result.ZPORTION = tryStringCortar(account, 257, 265);
    result.REGIOGROUP = tryStringFin(account, 265);
    return result;
  }

  AltaInstalacionType dataAltaInstalacion(String altaInstalacion) {
    AltaInstalacionType result = AltaInstalacionType();
    result.VERTRAG = tryStringCortar(altaInstalacion, 0, 10);
    result.ANLAGE = tryStringCortar(altaInstalacion, 10, 20);
    result.VKONTO = tryStringCortar(altaInstalacion, 20, 32);
    result.SPARTE = tryStringCortar(altaInstalacion, 32, 34);
    result.STAGRUVER = tryStringCortar(altaInstalacion, 34, 36);
    result.EINZDAT = tryStringCortar(altaInstalacion, 36, 44);
    result.AUSZDAT = tryStringFin(altaInstalacion, 44);
    return result;
  }

  InterlocutorComercialType dataInterlocutorComercial(String data) {
    InterlocutorComercialType interlocutor = InterlocutorComercialType();
    interlocutor.PARTNER = tryStringCortar(data, 0, 10);
    interlocutor.NAME_ORG1 = tryStringCortar(data, 10, 50);
    interlocutor.BU_SORT1 = tryStringCortar(data, 50, 70);
    interlocutor.STREET = tryStringCortar(data, 70, 130);
    interlocutor.HOUSE_NUM1 = tryStringCortar(data, 130, 140);
    interlocutor.CITY2 = tryStringCortar(data, 140, 180);
    interlocutor.REGIOGROUP = tryStringCortar(data, 180, 188);
    interlocutor.TEL_NUMBER = tryStringCortar(data, 188, 218);
    interlocutor.CLERK_ID = tryStringCortar(data, 218, 226);
    interlocutor.NAME_FIRST = tryStringCortar(data, 226, 266);
    interlocutor.NAME_LAST = tryStringCortar(data, 266, 306);
    interlocutor.BU_SORT2 = tryStringCortar(data, 306, 326);
    interlocutor.BPKIND = tryStringCortar(data, 326, 330);
    interlocutor.TITLE = tryStringCortar(data, 330, 334);
    interlocutor.HOUSE_NUM2 = tryStringCortar(data, 334, 374);
    interlocutor.CITY1 = tryStringCortar(data, 374, 414);
    interlocutor.REGION = tryStringCortar(data, 414, 417);
    return interlocutor;
  }

  ObjetoConexionType dataObjetoConexio(String data) {
    ObjetoConexionType objeto = ObjetoConexionType();
    objeto.HAUS = tryStringCortar(data, 0, 30);
    objeto.STREET = tryStringCortar(data, 30, 90);
    objeto.REGPOLIT = tryStringCortar(data, 90, 98);
    objeto.REGIOGROUP = tryStringCortar(data, 98, 106);
    objeto.ILOAN = tryStringCortar(data, 106, 110);
    objeto.SWERK = tryStringCortar(data, 110, 150);
    objeto.STR_SUPPL2 = tryStringCortar(data, 150, 190);
    objeto.HOUSE_NUM1 = tryStringCortar(data, 190, 200);
    objeto.CITY1 = tryStringCortar(data, 200, 240);
    objeto.REGION = tryStringCortar(data, 240, 243);
    objeto.BUILDING = tryStringCortar(data, 243, 263);
    objeto.COUNC = tryStringCortar(data, 263, 267);
    return objeto;
  }

  PuntoSuministroType dataPuntoSuministro(String data) {
    PuntoSuministroType puntoSumin = PuntoSuministroType();
    puntoSumin.VSTELLE = tryStringCortar(data, 0, 10);
    puntoSumin.HAUS = tryStringCortar(data, 10, 40);
    puntoSumin.VBSART = tryStringCortar(data, 40, 48);
    puntoSumin.HAUS_NUM2 = tryStringCortar(data, 48, 88);
    puntoSumin.FLOOR = tryStringCortar(data, 88, 98);
    puntoSumin.ROOMNUMBER = tryStringCortar(data, 98, 108);
    puntoSumin.STR_ERG2 = tryStringCortar(data, 108, 148);
    puntoSumin.STR_ERG4 = tryStringCortar(data, 148, 188);
    puntoSumin.LGZUSATZ = tryStringCortar(data, 188, 228);
    puntoSumin.ANZPERS = tryStringCortar(data, 228, 232);
    return puntoSumin;
  }

  InstalacionType dataInstalacion(String dataI) {
    String data = dataI.replaceAll(',', '.');
    InstalacionType instalacionData = InstalacionType();
    instalacionData.ANLAGE = tryStringCortar(data, 0, 10);
    instalacionData.VSTELLE = tryStringCortar(data, 10, 20);
    instalacionData.SPARTE = tryStringCortar(data, 20, 22);
    instalacionData.AB = tryStringCortar(data, 22, 30);
    instalacionData.BIS = tryStringCortar(data, 30, 38);
    instalacionData.AKLASSE = tryStringCortar(data, 38, 42);
    instalacionData.TARIFTYP = tryStringCortar(data, 42, 52);
    instalacionData.BRANCHE = tryStringCortar(data, 52, 62);
    instalacionData.ABLEINH = tryStringCortar(data, 62, 70);
    instalacionData.ANLART = tryStringCortar(data, 70, 74);
    instalacionData.TEMP_AREA = tryStringCortar(data, 74, 82);
    instalacionData.KONDIGR = tryStringCortar(data, 82, 92);
    instalacionData.TARIFART = tryStringCortar(data, 92, 100);
    return instalacionData;
  }

  AparatoType dataMedidor(String data) {
    AparatoType medidorData = AparatoType();
    medidorData.EQUNR = tryStringCortar(data, 0, 18);
    medidorData.VSTELLE = tryStringCortar(data, 18, 28);
    medidorData.HERST = tryStringCortar(data, 28, 58);
    medidorData.MATNR = tryStringCortar(data, 58, 76);
    medidorData.ILOAN = tryStringCortar(data, 76, 80);
    medidorData.SERNR = tryStringCortar(data, 80, 98).trim();
    medidorData.EQTYP = tryStringCortar(data, 98, 99);
    medidorData.STTXT = tryStringCortar(data, 99, 100);
    medidorData.BIS = tryStringCortar(data, 100, 108);
    medidorData.IWERK = tryStringCortar(data, 108, 112);
    medidorData.INGRP = tryStringCortar(data, 112, 115);
    medidorData.TPLNR = tryStringCortar(data, 115, 145);
    return medidorData;
  }

  ContratoType dataContrato(String data) {
    ContratoType contratoData = ContratoType();
    List<String> contratoLinea = data.split('|');
    try {
      contratoData.VKONTO = contratoLinea[1].trim(); //Cuenta Contrato
      contratoData.VERTRAG = contratoLinea[2].trim(); //Contrato
      contratoData.SPARTE = contratoLinea[9].trim(); //Sector
      contratoData.STAGRUVER = contratoLinea[7].trim(); // GR
      contratoData.BUKRS = ''; // FALTANTE
      contratoData.GEMFAKT = contratoLinea[12].trim(); // FC
      contratoData.ABRSPERR = contratoLinea[16].trim(); // MC
      contratoData.ABRFREIG = ''; // FALTANTE
      contratoData.KOFIZ = ''; // FALTANTE
      contratoData.COKEY = contratoLinea[8].trim(); //Imputación
      contratoData.BSTATUS = ''; // FALTANTE
      contratoData.FAKTURIERT = ''; // FALTANTE
      contratoData.ERNAM = contratoLinea[11].trim(); // CREADO POR
      contratoData.EINZDAT = fechaNormal(contratoLinea[10].trim()); // FCREACIÓN
      contratoData.AUSZDAT =
          fechaNormal(contratoLinea[15].trim()); // FECHA DE BAJA
    } catch (e) {
      contratoData.VKONTO = '';
      contratoData.VERTRAG = '';
      contratoData.SPARTE = '';
      contratoData.STAGRUVER = '';
      contratoData.BUKRS = '';
      contratoData.GEMFAKT = '';
      contratoData.ABRSPERR = '';
      contratoData.ABRFREIG = '';
      contratoData.KOFIZ = '';
      contratoData.COKEY = '';
      contratoData.BSTATUS = '';
      contratoData.FAKTURIERT = '';
      contratoData.ERNAM = '';
      contratoData.EINZDAT = '';
      contratoData.AUSZDAT = '';
    }
    return contratoData;
  }

  SpoolVigenciaActual dataSpoolActual(String data1) {
    String data2 = data1.replaceAll('\$', " ");
    String data3 = data2.replaceAll('"', " ");
    String data4 = data3.replaceAll("'", ' ');
    String data = data4.replaceAll(",", ' ');
    SpoolVigenciaActual v0 = SpoolVigenciaActual();
    v0.ZZCTACONTR = tryStringCortar(data, 14, 26).trim();
    v0.ZZDIRENVIO = tryStringCortar(data, 217, 297).trim();
    v0.ZZDIAMEDID = tryStringCortar(data, 454, 457).trim();
    v0.ZZLECACTUAL = tryStringCortar(data, 457, 471).trim();
    v0.ZZLECANTERI = tryStringCortar(data, 471, 485).trim();
    v0.ZZULTCONSUMO = tryStringCortar(data, 485, 493).trim();
    v0.ZZCODULTCONS = tryStringCortar(data, 493, 501).trim();
    v0.ZZCNSPROMHIST = tryStringCortar(data, 641, 649).trim();
    v0.ZZINDINQUILIN = tryStringCortar(data, 2898, 2899).trim();
    v0.ZZMESMORA = tryStringCortar(data, 2902, 2905).trim();
    v0.ZZVLRTER = tryStringCortar(data, 4967, 4985).trim();
    v0.IND_FRADIG = tryStringCortar(data, 5984, 5985).trim();
    v0.ZZTELEFONO = tryStringCortar(data, 5985, 6015).trim();
    v0.ZZCORREO = tryStringCortar(data, 6015, 6256).trim();

    return v0;
  }

  SpoolVigenciaActual dataSpoolLoad(String linea) {
    SpoolVigenciaActual dataSpool = SpoolVigenciaActual();
    List<String> lineaFrag = linea.split(',');
    dataSpool.ZZCTACONTR = lineaFrag[0];
    dataSpool.ZZDIRENVIO = lineaFrag[1];
    dataSpool.ZZDIAMEDID = lineaFrag[2];
    dataSpool.ZZLECACTUAL = lineaFrag[3];
    dataSpool.ZZLECANTERI = lineaFrag[4];
    dataSpool.ZZULTCONSUMO = lineaFrag[5];
    dataSpool.ZZCODULTCONS = lineaFrag[6];
    dataSpool.ZZCNSPROMHIST = lineaFrag[7];
    dataSpool.ZZINDINQUILIN = lineaFrag[8];
    dataSpool.ZZMESMORA = lineaFrag[9];
    dataSpool.ZZVLRTER = lineaFrag[10];
    dataSpool.IND_FRADIG = lineaFrag[11];
    dataSpool.ZZTELEFONO = lineaFrag[12];
    dataSpool.ZZCORREO = lineaFrag[13];
    return dataSpool;
  }
}

String fechaNormal(String fecha) {
  List<String> fechaFrag = fecha.split('.');
  String fechaNormal = fechaFrag[2] + fechaFrag[1] + fechaFrag[0];
  return fechaNormal;
}
