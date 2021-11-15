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
    result.VKONT = tryInt(account, 0, 12);
    result.GPART = tryInt(account, 12, 22);
    result.VKTYP = tryStringCortar(account, 22, 24);
    result.STREET = tryStringCortar(account, 24, 84);
    result.VKBEZ = tryStringCortar(account, 84, 119);
    result.VKONA = tryInt(account, 119, 139);
    result.REGIOGR_CA_T = tryStringCortar(account, 139, 147);
    result.KTOKL = tryStringCortar(account, 147, 151);
    result.KOFIZ_SD = tryInt(account, 151, 153);
    result.ABWVK = tryInt(account, 153, 165);
    result.FORMKEY = tryStringCortar(account, 165, 195);
    result.ZZDIR = tryStringCortar(account, 195, 255);
    result.IKEY = tryInt(account, 255, 257);
    result.ZPORTION = tryStringCortar(account, 257, 265);
    result.REGIOGROUP = tryStringFin(account, 265);
    return result;
  }

  AltaInstalacionType dataAltaInstalacion(String altaInstalacion) {
    AltaInstalacionType result = AltaInstalacionType();
    result.VERTRAG = tryInt(altaInstalacion, 0, 10);
    result.ANLAGE = tryInt(altaInstalacion, 10, 20);
    result.VKONTO = tryInt(altaInstalacion, 20, 32);
    result.SPARTE = tryInt(altaInstalacion, 32, 34);
    result.STAGRUVER = tryInt(altaInstalacion, 34, 36);
    result.EINZDAT = tryStringCortar(altaInstalacion, 36, 44);
    result.AUSZDAT = tryStringFin(altaInstalacion, 44);
    return result;
  }

  InterlocutorComercialType dataInterlocutorComercial(String data) {
    InterlocutorComercialType interlocutor = InterlocutorComercialType();
    interlocutor.PARTNER = tryInt(data, 0, 10);
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
    puntoSumin.VSTELLE = tryInt(data, 0, 10);
    puntoSumin.HAUS = tryInt(data, 10, 40);
    puntoSumin.VBSART = tryInt(data, 40, 48);
    puntoSumin.HAUS_NUM2 = tryStringCortar(data, 48, 88);
    puntoSumin.FLOOR = tryInt(data, 88, 98);
    puntoSumin.ROOMNUMBER = tryInt(data, 98, 108);
    puntoSumin.STR_ERG2 = tryStringCortar(data, 108, 148);
    puntoSumin.STR_ERG4 = tryStringCortar(data, 148, 188);
    puntoSumin.LGZUSATZ = tryStringCortar(data, 188, 228);
    puntoSumin.ANZPERS = tryInt(data, 228, 232);
    return puntoSumin;
  }

  InstalacionType dataInstalacion(String dataI) {
    String data = dataI.replaceAll(',', '.');
    InstalacionType instalacionData = InstalacionType();
    instalacionData.ANLAGE = tryInt(data, 0, 10);
    instalacionData.VSTELLE = tryInt(data, 10, 20);
    instalacionData.SPARTE = tryStringCortar(data, 20, 22);
    instalacionData.AB = tryStringCortar(data, 22, 30);
    instalacionData.BIS = tryStringCortar(data, 30, 38);
    instalacionData.AKLASSE = tryInt(data, 38, 42);
    instalacionData.TARIFTYP = tryStringCortar(data, 42, 52);
    instalacionData.BRANCHE = tryStringCortar(data, 52, 62);
    instalacionData.ABLEINH = tryStringCortar(data, 62, 70);
    instalacionData.ANLART = tryInt(data, 70, 74);
    instalacionData.TEMP_AREA = tryInt(data, 74, 82);
    instalacionData.KONDIGR = tryInt(data, 82, 92);
    instalacionData.TARIFART = tryInt(data, 92, 100);
    return instalacionData;
  }

  AparatoType dataMedidor(String data) {
    AparatoType medidorData = AparatoType();
    medidorData.EQUNR = tryInt(data, 0, 18);
    medidorData.VSTELLE = tryInt(data, 18, 28);
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
}
