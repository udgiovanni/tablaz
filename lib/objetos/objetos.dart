// ignore_for_file: non_constant_identifier_names

import 'package:sqlite3/sqlite3.dart';

//Clase Interlocutor Comercial PARTNER
class InterlocutorComercialType {
  late String PARTNER;
  late String NAME_ORG1;
  late String BU_SORT1;
  late String STREET;
  late String HOUSE_NUM1;
  late String CITY2;
  late String REGIOGROUP;
  late String TEL_NUMBER;
  late String CLERK_ID;
  late String NAME_FIRST;
  late String NAME_LAST;
  late String BU_SORT2;
  late String BPKIND;
  late String TITLE;
  late String HOUSE_NUM2;
  late String CITY1;
  late String REGION;

  Map<String, dynamic> toMap() {
    return {
      'PARTNER': PARTNER,
      'NAME_ORG1': NAME_ORG1,
      'BU_SORT1': BU_SORT1,
      'STREET': STREET,
      'HOUSE_NUM1': HOUSE_NUM1,
      'CITY2': CITY2,
      'REGIOGROUP': REGIOGROUP,
      'TEL_NUMBER': TEL_NUMBER,
      'CLERK_ID': CLERK_ID,
      'NAME_FIRST': NAME_FIRST,
      'NAME_LAST': NAME_LAST,
      'BU_SORT2': BU_SORT2,
      'BPKIND': BPKIND,
      'TITLE': TITLE,
      'HOUSE_NUM2': HOUSE_NUM2,
      'CITY1': CITY1,
      'REGION': REGION
    };
  }
}

//Class Cuenta Contrato ACCOUNT
class CuentaContratoType {
  late String VKONT;
  late String GPART;
  late String VKTYP;
  late String STREET;
  late String VKBEZ;
  late String VKONA;
  late String REGIOGR_CA_T;
  late String KTOKL;
  late String KOFIZ_SD;
  late String ABWVK;
  late String FORMKEY;
  late String ZZDIR;
  late String IKEY;
  late String ZPORTION;
  late String REGIOGROUP;

  Map<String, dynamic> toMap() {
    return {
      'VKONT': VKONT,
      'GPART': GPART,
      'VKTYP': VKTYP,
      'STREET': STREET,
      'VKBEZ': VKBEZ,
      'VKONA': VKONA,
      'REGIOGR_CA_T': REGIOGR_CA_T,
      'KTOKL': KTOKL,
      'KOFIZ_SD': KOFIZ_SD,
      'ABWVK': ABWVK,
      'FORMKEY': FORMKEY,
      'ZZDIR': ZZDIR,
      'IKEY': IKEY,
      'ZPORTION': ZPORTION,
      'REGIOGROUP': REGIOGROUP
    };
  }
}

//Class Objeto de Conexión CONNOBJ
class ObjetoConexionType {
  late String HAUS;
  late String STREET;
  late String REGPOLIT;
  late String REGIOGROUP;
  late String ILOAN;
  late String SWERK;
  late String STR_SUPPL2;
  late String HOUSE_NUM1;
  late String CITY1;
  late String REGION;
  late String BUILDING;
  late String COUNC;

  Map<String, dynamic> toMap() {
    return {
      'HAUS': HAUS,
      'STREET': STREET,
      'REGPOLIT': REGPOLIT,
      'REGIOGROUP': REGIOGROUP,
      'ILOAN': ILOAN,
      'SWERK': SWERK,
      'STR_SUPPL2': STR_SUPPL2,
      'HOUSE_NUM1': HOUSE_NUM1,
      'CITY1': CITY1,
      'REGION': REGION,
      'BUILDING': BUILDING,
      'COUNC': COUNC
    };
  }
}

//Clase punto de suministro PREMISE
class PuntoSuministroType {
  late String VSTELLE;
  late String HAUS;
  late String VBSART;
  late String HAUS_NUM2;
  late String FLOOR;
  late String ROOMNUMBER;
  late String STR_ERG2;
  late String STR_ERG4;
  late String LGZUSATZ;
  late String ANZPERS;

  Map<String, dynamic> toMap() {
    return {
      'VSTELLE': VSTELLE,
      'HAUS': HAUS,
      'VBSART': VBSART,
      'HAUS_NUM2': HAUS_NUM2,
      'FLOOR': FLOOR,
      'ROOMNUMBER': ROOMNUMBER,
      'STR_ERG2': STR_ERG2,
      'STR_ERG4': STR_ERG4,
      'LGZUSATZ': LGZUSATZ,
      'ANZPERS': ANZPERS
    };
  }
}

//Clase Instalación INSTLN
class InstalacionType {
  late String ANLAGE;
  late String VSTELLE;
  late String SPARTE;
  late String AB;
  late String BIS;
  late String AKLASSE;
  late String TARIFTYP;
  late String BRANCHE;
  late String ABLEINH;
  late String ANLART;
  late String TEMP_AREA;
  late String KONDIGR;
  late String TARIFART;

  Map<String, dynamic> toMap() {
    return {
      'ANLAGE': ANLAGE,
      'VSTELLE': VSTELLE,
      'SPARTE': SPARTE,
      'AB': AB,
      'BIS': BIS,
      'AKLASSE': AKLASSE,
      'TARIFTYP': TARIFTYP,
      'BRANCHE': BRANCHE,
      'ABLEINH': ABLEINH,
      'ANLART': ANLART,
      'TEMP_AREA': TEMP_AREA,
      'KONDIGR': KONDIGR,
      'TARIFART': TARIFART
    };
  }
}

//Clase Alta de Instalación MOVE-IN
class AltaInstalacionType {
  late String VERTRAG;
  late String ANLAGE;
  late String VKONTO;
  late String SPARTE;
  late String STAGRUVER;
  late String EINZDAT;
  late String AUSZDAT;

  Map<String, dynamic> toMap() {
    return {
      'VERTRAG': VERTRAG,
      'ANLAGE': ANLAGE,
      'VKONTO': VKONTO,
      'SPARTE': SPARTE,
      'STAGRUVER': STAGRUVER,
      'EINZDAT': EINZDAT,
      'AUSZDAT': AUSZDAT
    };
  }
}

//Clase Medidor DEVICE
class AparatoType {
  late String EQUNR;
  late String VSTELLE;
  late String HERST;
  late String MATNR;
  late String ILOAN;
  late String SERNR;
  late String EQTYP;
  late String STTXT;
  late String BIS;
  late String IWERK;
  late String INGRP;
  late String TPLNR;

  Map<String, dynamic> toMap() {
    return {
      'EQUNR': EQUNR,
      'VSTELLE': VSTELLE,
      'HERST': HERST,
      'MATNR': MATNR,
      'ILOAN': ILOAN,
      'SERNR': SERNR,
      'EQTYP': EQTYP,
      'STTXT': STTXT,
      'BIS': BIS,
      'IWERK': IWERK,
      'INGRP': INGRP,
      'TPLNR': TPLNR
    };
  }
}

class GuardarAccount {
  late Database database;
  late List<String> data;
  Map<String, dynamic> toMap() {
    return {
      'Database': database,
      'data': data,
    };
  }
}
