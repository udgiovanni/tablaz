// ignore_for_file: unnecessary_string_interpolations
import 'dart:io';
//dart:convert facilita la conversion de datos
import 'dart:convert';
import 'package:tablaz/funciones/cargando_data.dart';
import 'package:tablaz/objetos/objetos.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:flutter/services.dart' show rootBundle;

//TXT a List de String para UTF-8
class FuncionesLoadDatabase {
  Future<List<String>> txtToListString(String ruta) async {
    File dataLoad = File(ruta);
    String dataCargad = dataLoad.readAsStringSync();
    String replace1 = dataCargad.replaceAll('"', ' ');
    String dataCargada = replace1.replaceAll("'", " ");
    LineSplitter lineasDataCargada = const LineSplitter();
    List<String> lineasCargadas = lineasDataCargada.convert(dataCargada);
    List<String> linean = [];
    for (int i = 0; i <= lineasCargadas.length - 1; i++) {
      linean.add(lineasCargadas[i]);
    }
    return linean;
  }

//TXT a List String para ANSI
  Future<List<String>> txtToListStringANSI(String ruta) async {
    File dataLoad = File(ruta);
    var bytesTxt = await dataLoad.readAsBytes();
    String dataCargadaBytex = String.fromCharCodes(bytesTxt);
    String replace1 = dataCargadaBytex.replaceAll('"', ' ');
    String dataCargada = replace1.replaceAll("'", " ");
    LineSplitter lineasDataCargada = const LineSplitter();
    List<String> lineasCargadas = lineasDataCargada.convert(dataCargada);
    List<String> linean = [];
    for (int i = 0; i <= lineasCargadas.length - 1; i++) {
      linean.add(lineasCargadas[i]);
    }
    return linean;
  }

//Funcion que almacena en la DB los datos de la tabla cuentas
  Future<void> guardarDatosCuentasDB(DatatoDB datoCuentas) async {
    //contador
    int i = 0;
    final db = sqlite3.open('${datoCuentas.ruta}\\database.sqlite3');
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    List<String> datosCuentas = datoCuentas.data;
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
    BEGIN;
    DROP TABLE IF EXISTS "ACCOUNT";
    CREATE TABLE "ACCOUNT" (
      "VKONT"	TEXT,
      "GPART"	TEXT,
      "VKTYP"	TEXT,
      "STREET" TEXT,
      "VKBEZ"	TEXT,
      "VKONA"	TEXT,
      "REGIOGR_CA_T"	TEXT,
      "KTOKL"	TEXT,
      "KOFIZ_SD"	TEXT,
      "ABWVK"	TEXT,
      "FORMKEY_CA"	TEXT,
      "ZZDIR"	TEXT,
      "IKEY"	TEXT,
      "ZPORTION"	TEXT,
      "REGIOGROUP"	TEXT
    );
    ''');
    final inserAccountData = db.prepare('''
    INSERT INTO ACCOUNT (
        VKONT,
        GPART,
        VKTYP,
        STREET,
        VKBEZ,
        VKONA,
        REGIOGR_CA_T,
        KTOKL,
        KOFIZ_SD,
        ABWVK,
        FORMKEY_CA,
        ZZDIR,
        IKEY,
        ZPORTION,
        REGIOGROUP
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
      ''');
    for (i; i <= datosCuentas.length - 1; i++) {
      String linea = datosCuentas[i];
      CuentaContratoType cuenta = fz.dataCuenta(linea);
      inserAccountData.execute([
        cuenta.VKONT,
        cuenta.GPART,
        cuenta.VKTYP,
        cuenta.STREET,
        cuenta.VKBEZ,
        cuenta.VKONA,
        cuenta.REGIOGR_CA_T,
        cuenta.KTOKL,
        cuenta.KOFIZ_SD,
        cuenta.ABWVK,
        cuenta.FORMKEY,
        cuenta.ZZDIR,
        cuenta.IKEY,
        cuenta.ZPORTION,
        cuenta.REGIOGROUP
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE ACCOUNT
    SET VKONT = NULL WHERE VKONT = '';
    UPDATE ACCOUNT
    SET GPART = NULL WHERE GPART = '';
    UPDATE ACCOUNT
    SET VKTYP = NULL WHERE VKTYP = '';
    UPDATE ACCOUNT
    SET STREET = NULL WHERE STREET = '';
    UPDATE ACCOUNT
    SET VKBEZ = NULL WHERE VKBEZ = '';
    UPDATE ACCOUNT
    SET VKONA = NULL WHERE VKONA = '';
    UPDATE ACCOUNT
    SET REGIOGR_CA_T = NULL WHERE REGIOGR_CA_T = '';
    UPDATE ACCOUNT
    SET KTOKL = NULL WHERE KTOKL = '';
    UPDATE ACCOUNT
    SET KOFIZ_SD = NULL WHERE KOFIZ_SD = '';
    UPDATE ACCOUNT
    SET ABWVK = NULL WHERE ABWVK = '';
    UPDATE ACCOUNT
    SET FORMKEY_CA = NULL WHERE FORMKEY_CA = '';
    UPDATE ACCOUNT
    SET ZZDIR = NULL WHERE ZZDIR = '';
    UPDATE ACCOUNT
    SET IKEY = NULL WHERE IKEY = '';
    UPDATE ACCOUNT
    SET ZPORTION = NULL WHERE ZPORTION = '';
    UPDATE ACCOUNT
    SET REGIOGROUP = NULL WHERE REGIOGROUP = '';
    COMMIT;
    ''');
    inserAccountData.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla InterlocutorComercial
  Future<void> guardarDatosIntComercialDB(DatatoDB datoInrComercial) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoInrComercial.ruta}\\database.sqlite3');
    List<String> datosInrComercial = datoInrComercial.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS PARTNER;
      CREATE TABLE PARTNER (
        PARTNER	TEXT,
        ADDRNUMBER,
        NAME_ORG1,
        BU_SORT1,
        STREET,
        HOUSE_NUM1,
        CITY2	TEXT,
        REGIOGROUP	TEXT,
        TEL_NUMBER	TEXT,
        CLERK_ID	TEXT,
        NAME_FIRST	TEXT,
        NAME_LAST	TEXT,
        BU_SORT2	TEXT,
        BPKIND	TEXT,
        TITLE	TEXT,
        HOUSE_NUM2	TEXT,
        CITY1	TEXT,
        REGION	TEXT
      );
    
    ''');
    final insertInterlocutorData = db.prepare('''
    INSERT INTO PARTNER (
        PARTNER,
        NAME_ORG1,
        BU_SORT1,
        STREET,
        HOUSE_NUM1,
        CITY2,
        REGIOGROUP,
        TEL_NUMBER,
        CLERK_ID,
        NAME_FIRST,
        NAME_LAST,
        BU_SORT2,
        BPKIND,
        TITLE,
        HOUSE_NUM2,
        CITY1,
        REGION
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosInrComercial.length - 1; i++) {
      String linea = datosInrComercial[i];
      InterlocutorComercialType interlocutor =
          fz.dataInterlocutorComercial(linea);
      insertInterlocutorData.execute([
        interlocutor.PARTNER,
        interlocutor.NAME_ORG1,
        interlocutor.BU_SORT1,
        interlocutor.STREET,
        interlocutor.HOUSE_NUM1,
        interlocutor.CITY2,
        interlocutor.REGIOGROUP,
        interlocutor.TEL_NUMBER,
        interlocutor.CLERK_ID,
        interlocutor.NAME_FIRST,
        interlocutor.NAME_LAST,
        interlocutor.BU_SORT2,
        interlocutor.BPKIND,
        interlocutor.TITLE,
        interlocutor.HOUSE_NUM2,
        interlocutor.CITY1,
        interlocutor.REGION
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE PARTNER
    SET PARTNER = NULL WHERE PARTNER = '';
    UPDATE PARTNER
    SET NAME_ORG1 = NULL WHERE NAME_ORG1 = '';
    UPDATE PARTNER
    SET BU_SORT1= NULL WHERE BU_SORT1= '';
    UPDATE PARTNER
    SET STREET= NULL WHERE STREET= '';
    UPDATE PARTNER
    SET HOUSE_NUM1= NULL WHERE HOUSE_NUM1= '';
    UPDATE PARTNER
    SET CITY2= NULL WHERE CITY2= '';
    UPDATE PARTNER
    SET REGIOGROUP= NULL WHERE REGIOGROUP= '';
    UPDATE PARTNER
    SET TEL_NUMBER= NULL WHERE TEL_NUMBER= '';
    UPDATE PARTNER
    SET CLERK_ID= NULL WHERE CLERK_ID= '';
    UPDATE PARTNER
    SET NAME_FIRST= NULL WHERE NAME_FIRST= '';
    UPDATE PARTNER
    SET NAME_LAST= NULL WHERE NAME_LAST= '';
    UPDATE PARTNER
    SET BU_SORT2= NULL WHERE BU_SORT2= '';
    UPDATE PARTNER
    SET BPKIND= NULL WHERE BPKIND= '';
    UPDATE PARTNER
    SET TITLE= NULL WHERE TITLE= '';
    UPDATE PARTNER
    SET HOUSE_NUM2= NULL WHERE HOUSE_NUM2= '';
    UPDATE PARTNER
    SET CITY1= NULL WHERE CITY1= '';
    UPDATE PARTNER
    SET REGION= NULL WHERE REGION= '';
    COMMIT;
    ''');
    insertInterlocutorData.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Alta Instalacion
  Future<void> guardarAltaInstalacionDB(DatatoDB datoAltasInstalacion) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoAltasInstalacion.ruta}\\database.sqlite3');
    List<String> datosAltasInstalacion = datoAltasInstalacion.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS "MOVE-IN";
      CREATE TABLE "MOVE-IN" (
        "VERTRAG"	TEXT,
        "ANLAGE"	TEXT,
        "VKONTO"	TEXT,
        "SPARTE"	TEXT,
        "STAGRUVER"	TEXT,
        "EINZDAT"	TEXT,
        "AUSZDAT"	TEXT
      );
    ''');
    final insertAltaInstalacionData = db.prepare('''
      INSERT INTO "MOVE-IN" (
        VERTRAG,
        ANLAGE,
        VKONTO,
        SPARTE,
        STAGRUVER,
        EINZDAT,
        AUSZDAT
        ) VALUES (?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosAltasInstalacion.length - 1; i++) {
      String linea = datosAltasInstalacion[i];
      AltaInstalacionType altaInstalacion = fz.dataAltaInstalacion(linea);
      insertAltaInstalacionData.execute([
        altaInstalacion.VERTRAG,
        altaInstalacion.ANLAGE,
        altaInstalacion.VKONTO,
        altaInstalacion.SPARTE,
        altaInstalacion.STAGRUVER,
        altaInstalacion.EINZDAT,
        altaInstalacion.AUSZDAT
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE "MOVE-IN"
    SET ANLAGE = NULL WHERE ANLAGE = '';
    UPDATE "MOVE-IN"
    SET VKONTO = NULL WHERE VKONTO = '';
    UPDATE "MOVE-IN"
    SET SPARTE = NULL WHERE SPARTE = '';
    UPDATE "MOVE-IN"
    SET EINZDAT = NULL WHERE EINZDAT = '';
    UPDATE "MOVE-IN"
    SET AUSZDAT = NULL WHERE AUSZDAT = '';
    COMMIT;
        ''');
    insertAltaInstalacionData.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Medidores
  Future<void> guardarMedidorDB(DatatoDB datoMedidores) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoMedidores.ruta}\\database.sqlite3');
    List<String> datosMedidores = datoMedidores.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla

    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS DEVICE;
      CREATE TABLE DEVICE (
        "EQUNR" TEXT,
        "LOGIKZW" TEXT,
        "ANLAGE" TEXT,
        "VSTELLE" TEXT,
        "HERST" TEXT,
        "MATNR" TEXT,
        "ILOAN" TEXT,
        "SWERK" TEXT,
        "SERNR" TEXT,
        "EQTYP" TEXT,
        "ESTAI" TEXT,
        "DATAB" TEXT,
        "BIS" TEXT,
        "IWERK" TEXT,
        "INGRP" TEXT,
        "TPLNR" TEXT,
        "STTXT" TEXT,
        "AB" TEXT,
        "BIS_MED" TEXT
      );
    ''');
    final insertDataMedidor = db.prepare('''
      INSERT INTO DEVICE (
        EQUNR,
        VSTELLE,
        HERST,
        MATNR,
        ILOAN,
        SERNR,
        EQTYP,
        DATAB,
        IWERK,
        INGRP,
        TPLNR
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?)
      ''');
    for (i; i <= datosMedidores.length - 1; i++) {
      String linea = datosMedidores[i];
      AparatoType medidor = fz.dataMedidor(linea);
      insertDataMedidor.execute([
        medidor.EQUNR,
        medidor.VSTELLE,
        medidor.HERST,
        medidor.MATNR,
        medidor.ILOAN,
        medidor.SERNR,
        medidor.EQTYP,
        medidor.BIS,
        medidor.IWERK,
        medidor.INGRP,
        medidor.TPLNR
      ]);
    }
    db.execute('''COMMIT;''');
    db.execute('''
    BEGIN;
    UPDATE DEVICE
    SET VSTELLE = NULL WHERE VSTELLE = '';
    UPDATE DEVICE
    SET HERST = NULL WHERE HERST = '';
    UPDATE DEVICE
    SET MATNR = NULL WHERE MATNR = '';
    UPDATE DEVICE
    SET ILOAN = NULL WHERE ILOAN = '';
    UPDATE DEVICE
    SET SERNR = NULL WHERE SERNR = '';
    UPDATE DEVICE
    SET EQTYP = NULL WHERE EQTYP = '';
    UPDATE DEVICE
    SET DATAB = NULL WHERE DATAB = '';
    UPDATE DEVICE
    SET IWERK = NULL WHERE IWERK = '';
    UPDATE DEVICE
    SET INGRP = NULL WHERE INGRP = '';
    UPDATE DEVICE
    SET INGRP = NULL WHERE INGRP = '';
    UPDATE DEVICE
    SET TPLNR = NULL WHERE TPLNR = '';
    COMMIT;
    ''');
    insertDataMedidor.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Instalaciones
  Future<void> guardarInstalacionesDB(DatatoDB datoInstalaciones) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoInstalaciones.ruta}\\database.sqlite3');
    List<String> datosInstalaciones = datoInstalaciones.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS INSTLN;
      CREATE TABLE INSTLN (
        "ANLAGE"	TEXT,
        "VSTELLE"	TEXT,
        "SPARTE"	TEXT,
        "AB"	TEXT,
        "BIS"	TEXT,
        "AKLASSE"	TEXT,
        "TARIFTYP"	TEXT,
        "BRANCHE"	TEXT,
        "ABLEINH"	TEXT,
        "ANLART"	TEXT,
        "TEMP_AREA"	TEXT,
        "KONDIGR"	TEXT,
        "TARIFART"	TEXT,
        "VL_FACTOR1"	TEXT,
        "VL_FACTOR2"	TEXT,
        "VL_CANTID1"	TEXT,
        "VL_CANTID2"	TEXT
      );
    ''');
    final insertDataInstalacion = db.prepare('''
    INSERT INTO INSTLN (
        ANLAGE,
        VSTELLE,
        SPARTE,
        AB,
        BIS,
        AKLASSE,
        TARIFTYP,
        BRANCHE,
        ABLEINH,
        ANLART,
        TEMP_AREA,
        KONDIGR,
        TARIFART
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosInstalaciones.length - 1; i++) {
      String linea = datosInstalaciones[i];
      InstalacionType instalacionType = fz.dataInstalacion(linea);
      insertDataInstalacion.execute([
        instalacionType.ANLAGE,
        instalacionType.VSTELLE,
        instalacionType.SPARTE,
        instalacionType.AB,
        instalacionType.BIS,
        instalacionType.AKLASSE,
        instalacionType.TARIFTYP,
        instalacionType.BRANCHE,
        instalacionType.ABLEINH,
        instalacionType.ANLART,
        instalacionType.TEMP_AREA,
        instalacionType.KONDIGR,
        instalacionType.TARIFART
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE INSTLN
    SET VSTELLE = NULL WHERE VSTELLE = '';
    UPDATE INSTLN
    SET SPARTE = NULL WHERE SPARTE = '';
    UPDATE INSTLN
    SET AB = NULL WHERE AB = '';
    UPDATE INSTLN
    SET BIS = NULL WHERE BIS = '';
    UPDATE INSTLN
    SET AKLASSE = NULL WHERE AKLASSE = '';
    UPDATE INSTLN
    SET TARIFTYP = NULL WHERE TARIFTYP = '';
    UPDATE INSTLN
    SET BRANCHE = NULL WHERE BRANCHE = '';
    UPDATE INSTLN
    SET ABLEINH = NULL WHERE ABLEINH = '';
    UPDATE INSTLN
    SET ANLART = NULL WHERE ANLART = '';
    UPDATE INSTLN
    SET TEMP_AREA = NULL WHERE TEMP_AREA = '';
    UPDATE INSTLN
    SET KONDIGR = NULL WHERE KONDIGR = '';
    UPDATE INSTLN
    SET TARIFART = NULL WHERE TARIFART = '';
    COMMIT;
    ''');
    insertDataInstalacion.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Objeto de Conexion
  Future<void> guardarObjetoConexionDB(DatatoDB datoObjetoConexion) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoObjetoConexion.ruta}\\database.sqlite3');
    List<String> datosObjetoConexion = datoObjetoConexion.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS CONNOBJ;
      CREATE TABLE CONNOBJ (
        "HAUS"	TEXT,
        "STREET"	TEXT,
        "REGPOLIT"	TEXT,
        "REGIOGROUP"	TEXT,
        "SWERK"	TEXT,
        "PLTXT"	TEXT,
        "STR_SUPL2"	TEXT,
        "HOUSE_NUM1"	TEXT,
        "CITY1"	TEXT,
        "REGION"	TEXT,
        "BUILDING"	TEXT,
        "COUNC"	TEXT
      );
    ''');
    final insertDataObjetoConexion = db.prepare('''
    INSERT INTO CONNOBJ (
        HAUS,
        STREET,
        REGPOLIT,
        REGIOGROUP,
        SWERK,
        PLTXT,
        STR_SUPL2,
        HOUSE_NUM1,
        CITY1,
        REGION,
        BUILDING,
        COUNC
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)
    ''');

    for (i; i <= datosObjetoConexion.length - 1; i++) {
      String linea = datosObjetoConexion[i];
      ObjetoConexionType objetoConexionType = fz.dataObjetoConexio(linea);
      insertDataObjetoConexion.execute([
        objetoConexionType.HAUS,
        objetoConexionType.STREET,
        objetoConexionType.REGPOLIT,
        objetoConexionType.REGIOGROUP,
        objetoConexionType.ILOAN,
        objetoConexionType.SWERK,
        objetoConexionType.STR_SUPPL2,
        objetoConexionType.HOUSE_NUM1,
        objetoConexionType.CITY1,
        objetoConexionType.REGION,
        objetoConexionType.BUILDING,
        objetoConexionType.COUNC
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE CONNOBJ
    SET STREET = NULL WHERE STREET = '';
    UPDATE CONNOBJ
    SET REGPOLIT = NULL WHERE REGPOLIT = '';
    UPDATE CONNOBJ
    SET REGIOGROUP = NULL WHERE REGIOGROUP = '';
    UPDATE CONNOBJ
    SET STR_SUPL2 = NULL WHERE STR_SUPL2 = '';
    UPDATE CONNOBJ
    SET HOUSE_NUM1 = NULL WHERE HOUSE_NUM1 = '';
    UPDATE CONNOBJ
    SET CITY1 = NULL WHERE CITY1 = '';
    UPDATE CONNOBJ
    SET REGION = NULL WHERE REGION = '';
    UPDATE CONNOBJ
    SET BUILDING = NULL WHERE BUILDING = '';
    UPDATE CONNOBJ
    SET COUNC = NULL WHERE COUNC = '';
    COMMIT;
    ''');
    insertDataObjetoConexion.dispose();
  }

//Funcion que almacena en la DB los datos de la tabla Instalaciones
  Future<void> guardarPuntoSumiinistroDB(DatatoDB datoPuntoSuministro) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoPuntoSuministro.ruta}\\database.sqlite3');
    List<String> datosPuntoSuministro = datoPuntoSuministro.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS PREMISE;
      CREATE TABLE PREMISE (
        "VSTELLE"	TEXT,
        "HAUS"	TEXT,
        "VBSART"	TEXT,
        "HAUS_NUM2"	TEXT,
        "FLOOR"	TEXT,
        "ROOMNUMBER"	TEXT,
        "STR_ERG2"	TEXT,
        "STR_ERG4"	TEXT,
        "LGZUSATZ"	TEXT,
        "ANZPERS"	TEXT
      );
    ''');
    final insertDataPuntoInstalacion = db.prepare('''
    INSERT INTO PREMISE (
        VSTELLE,
        HAUS,
        VBSART,
        HAUS_NUM2,
        FLOOR,
        ROOMNUMBER,
        STR_ERG2,
        STR_ERG4,
        LGZUSATZ,
        ANZPERS
        ) VALUES (?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosPuntoSuministro.length - 1; i++) {
      String linea = datosPuntoSuministro[i];
      PuntoSuministroType puntoSuministroType = fz.dataPuntoSuministro(linea);
      insertDataPuntoInstalacion.execute([
        puntoSuministroType.VSTELLE,
        puntoSuministroType.HAUS,
        puntoSuministroType.VBSART,
        puntoSuministroType.HAUS_NUM2,
        puntoSuministroType.FLOOR,
        puntoSuministroType.ROOMNUMBER,
        puntoSuministroType.STR_ERG2,
        puntoSuministroType.STR_ERG4,
        puntoSuministroType.LGZUSATZ,
        puntoSuministroType.ANZPERS
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE PREMISE
    SET HAUS = NULL WHERE HAUS = '';
    UPDATE PREMISE
    SET VBSART = NULL WHERE VBSART = '';
    UPDATE PREMISE
    SET HAUS_NUM2 = NULL WHERE HAUS_NUM2 = '';
    UPDATE PREMISE
    SET FLOOR = NULL WHERE FLOOR = '';
    UPDATE PREMISE
    SET ROOMNUMBER = NULL WHERE ROOMNUMBER = '';
    UPDATE PREMISE
    SET STR_ERG2 = NULL WHERE STR_ERG2 = '';
    UPDATE PREMISE
    SET STR_ERG4 = NULL WHERE STR_ERG4 = '';
    UPDATE PREMISE
    SET LGZUSATZ = NULL WHERE LGZUSATZ = '';
    UPDATE PREMISE
    SET ANZPERS = NULL WHERE ANZPERS = '';
    COMMIT;
    ''');

    insertDataPuntoInstalacion.dispose();
  }

// Función que almacena en la DB los datos de la Tabla Contrato (EVER)

  Future<void> guardarContrato(DatatoDB datoContrato) async {
    //contador
    int i = 0;
    //Database
    final db = sqlite3.open('${datoContrato.ruta}\\database.sqlite3');
    List<String> datosContrato = datoContrato.data;
    //Funciones de soporte
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    //Eliminar tabla si exiSTE y crear la nueva tabla
    db.execute('''
      BEGIN;
      DROP TABLE IF EXISTS EVER;
      CREATE TABLE "EVER" (
      "VKONTO"	TEXT,
      "VERTRAG"	TEXT,
      "SPARTE"	TEXT,
      "STAGRUVER"	TEXT,
      "BUKRS"	TEXT,
      "GEMFAKT"	TEXT,
      "ABRSPERR"	TEXT,
      "ABRFREIG"	TEXT,
      "KOFIZ"	TEXT,
      "COKEY"	TEXT,
      "BSTATUS"	TEXT,
      "FAKTURIERT"	TEXT,
      "ERNAM"	TEXT,
      "EINZDAT"	TEXT,
      "AUSZDAT"	TEXT
    );
    ''');
    final insertDataInstalacion = db.prepare('''
    INSERT INTO "EVER" (
      VKONTO,
      VERTRAG,
      SPARTE,
      STAGRUVER,
      BUKRS,
      GEMFAKT,
      ABRSPERR,
      ABRFREIG,
      KOFIZ,
      COKEY,
      BSTATUS,
      FAKTURIERT,
      ERNAM,
      EINZDAT,
      AUSZDAT
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (i; i <= datosContrato.length - 1; i++) {
      String linea = datosContrato[i];
      ContratoType contratoType = fz.dataContrato(linea);
      insertDataInstalacion.execute([
        contratoType.VKONTO,
        contratoType.VERTRAG,
        contratoType.SPARTE,
        contratoType.STAGRUVER,
        contratoType.BUKRS,
        contratoType.GEMFAKT,
        contratoType.ABRFREIG,
        contratoType.ABRSPERR,
        contratoType.KOFIZ,
        contratoType.COKEY,
        contratoType.BSTATUS,
        contratoType.FAKTURIERT,
        contratoType.ERNAM,
        contratoType.EINZDAT,
        contratoType.AUSZDAT
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    BEGIN;
    UPDATE EVER
    SET VERTRAG = NULL WHERE VERTRAG = '';
    UPDATE EVER
    SET SPARTE = NULL WHERE SPARTE = '';
    UPDATE EVER
    SET STAGRUVER = NULL WHERE STAGRUVER = '';
    UPDATE EVER
    SET BUKRS = NULL WHERE BUKRS = '';
    UPDATE EVER
    SET GEMFAKT = NULL WHERE GEMFAKT = '';
    UPDATE EVER
    SET ABRSPERR = NULL WHERE ABRSPERR = '';
    UPDATE EVER
    SET ABRFREIG = NULL WHERE ABRFREIG = '';
    UPDATE EVER
    SET KOFIZ = NULL WHERE KOFIZ = '';
    UPDATE EVER
    SET BSTATUS = NULL WHERE BSTATUS = '';
    UPDATE EVER
    SET FAKTURIERT = NULL WHERE FAKTURIERT = '';
    UPDATE EVER
    SET ERNAM = NULL WHERE ERNAM = '';
    UPDATE EVER
    SET EINZDAT = NULL WHERE EINZDAT = '';
    UPDATE EVER
    SET AUSZDAT = NULL WHERE AUSZDAT = '';
    COMMIT;
    ''');
  }

  //Cargando datos de Barrios
  Future<void> loadDataBarrios(DatatoDB datatoDB) async {
    final db = sqlite3.open('${datatoDB.ruta}\\database.sqlite3');
    db.execute('''
    BEGIN;
    DROP TABLE IF EXISTS REF_BARRIO;
    CREATE TABLE "REF_BARRIO" (
      "COD_BARRIO"	TEXT,
      "NME_BARRIO"	TEXT,
      "NME_LOCALIDAD"	TEXT,
      "NME_MUNICPIO"	TEXT,
      "COD_LOCALIDAD" TEXT
    );
    COMMIT;
    ''');
    List<String> linean = [];
    List<String> lineasCargadas = datatoDB.data;
    for (int i = 0; i <= lineasCargadas.length - 1; i++) {
      linean.add(lineasCargadas[i]);
    }
    final insertDataBarrios = db.prepare('''
    INSERT INTO REF_BARRIO(
      COD_BARRIO,
      NME_BARRIO,
      NME_LOCALIDAD,
      NME_MUNICPIO,
      COD_LOCALIDAD)
      VALUES (?,?,?,?,?)
    ''');
    for (int i = 1; i <= linean.length - 1; i++) {
      String dataLinea = linean[i].replaceAll('"', '');
      List<String> data = dataLinea.split(';');
      insertDataBarrios.execute([data[0], data[1], data[2], data[3], data[4]]);
    }
  }

  //Carga de Datos Spool
  Future<void> loadDataSpool(SpoolDataTable dataSpool) async {
    final db = sqlite3.open('${dataSpool.ruta}\\database.sqlite3');
    FuncionesGeneralesTablaZ fz = FuncionesGeneralesTablaZ();
    db.execute('''
    BEGIN;
    DROP TABLE IF EXISTS ${dataSpool.nombreTabla};
    CREATE TABLE ${dataSpool.nombreTabla}(
      "ZZCTACONTR"	TEXT,
      "ZZDIRENVIO"	TEXT,
      "ZZDIAMEDID"	TEXT,
      "ZZLECACTUAL"	TEXT,
      "ZZLECANTERI"	TEXT,
      "ZZULTCONSUMO"	TEXT,
      "ZZCODULTCONS"	TEXT,
      "ZZCNSPROMHIST"	TEXT,
      "ZZINDINQUILIN"	TEXT,
      "ZZMESMORA"	TEXT,
      "ZZVLRTER"	TEXT,
      "IND_FRADIG"	TEXT,
      "ZZTELEFONO"	TEXT,
      "ZZCORREO"	TEXT
    );
    ''');
    final insertDataSpool = db.prepare('''
    INSERT INTO ${dataSpool.nombreTabla} (
      ZZCTACONTR,
      ZZDIRENVIO,
      ZZDIAMEDID,
      ZZLECACTUAL,
      ZZLECANTERI,
      ZZULTCONSUMO,
      ZZCODULTCONS,
      ZZCNSPROMHIST,
      ZZINDINQUILIN,
      ZZMESMORA,
      ZZVLRTER,
      IND_FRADIG,
      ZZTELEFONO,
      ZZCORREO
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    ''');
    for (int i = 1; i <= dataSpool.dataSpool.length - 1; i++) {
      String linea = dataSpool.dataSpool[i];
      SpoolVigenciaActual spoolVig = fz.dataSpoolLoad(linea);
      insertDataSpool.execute([
        spoolVig.ZZCTACONTR,
        spoolVig.ZZDIRENVIO,
        spoolVig.ZZDIAMEDID,
        spoolVig.ZZLECACTUAL,
        spoolVig.ZZLECANTERI,
        spoolVig.ZZULTCONSUMO,
        spoolVig.ZZCODULTCONS,
        spoolVig.ZZCNSPROMHIST,
        spoolVig.ZZINDINQUILIN,
        spoolVig.ZZMESMORA,
        spoolVig.ZZVLRTER,
        spoolVig.IND_FRADIG,
        spoolVig.ZZTELEFONO,
        spoolVig.ZZCORREO
      ]);
    }
    db.execute('''
    COMMIT;
    ''');
    db.execute('''
    UPDATE ${dataSpool.nombreTabla} SET ZZDIRENVIO = NULL WHERE ZZDIRENVIO = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZDIAMEDID = NULL WHERE ZZDIAMEDID = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZLECACTUAL = NULL WHERE ZZLECACTUAL = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZLECANTERI = NULL WHERE ZZLECANTERI = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZULTCONSUMO = NULL WHERE ZZULTCONSUMO = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZCODULTCONS = NULL WHERE ZZCODULTCONS = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZCNSPROMHIST = NULL WHERE ZZCNSPROMHIST = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZINDINQUILIN = NULL WHERE ZZINDINQUILIN = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZMESMORA = NULL WHERE ZZMESMORA = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZVLRTER = NULL WHERE ZZVLRTER = '';
    UPDATE ${dataSpool.nombreTabla} SET IND_FRADIG = NULL WHERE IND_FRADIG = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZTELEFONO = NULL WHERE ZZTELEFONO = '';
    UPDATE ${dataSpool.nombreTabla} SET ZZCORREO = NULL WHERE ZZCORREO = '';
    ''');
  }

  Future<void> crearTablaZ(String ruta) async {
    //Database
    final db = sqlite3.open('$ruta\\database.sqlite3');
    db.execute('''
    BEGIN;
     UPDATE "ACCOUNT"
      SET "VKONT" = REPLACE(LTRIM(REPLACE(TRIM("VKONT"), "0", " ")), " ", "0"),
          "GPART" = REPLACE(LTRIM(REPLACE(TRIM("GPART"), "0", " ")), " ", "0"),
      "VKONA" = REPLACE(LTRIM(REPLACE(TRIM("VKONA"), "0", " ")), " ", "0"),
      "KTOKL" = REPLACE(LTRIM(REPLACE(TRIM("KTOKL"), "0", " ")), " ", "0"),
      "KOFIZ_SD" = REPLACE(LTRIM(REPLACE(TRIM("KOFIZ_SD"), "0", " ")), " ", "0")
    WHERE TRIM("VKONT") LIKE "0%"
      OR TRIM("GPART") LIKE "0%"
    OR TRIM("VKONA") LIKE "0%"
    OR TRIM("KTOKL") LIKE "0%"
    OR TRIM("KOFIZ_SD") LIKE "0%";

    UPDATE "CONNOBJ"
      SET "HAUS" = REPLACE(LTRIM(REPLACE(TRIM("HAUS"), "0", " ")), " ", "0"),
          "REGPOLIT" = REPLACE(LTRIM(REPLACE(TRIM("REGPOLIT"), "0", " ")), " ", "0")
    WHERE TRIM("HAUS") LIKE "0%"
      OR TRIM("REGPOLIT") LIKE "0%";

    UPDATE "DEVICE"
      SET "VSTELLE" = REPLACE(LTRIM(REPLACE(TRIM("VSTELLE"), "0", " ")), " ", "0"),
          "EQUNR" = REPLACE(LTRIM(REPLACE(TRIM("EQUNR"), "0", " ")), " ", "0")
    WHERE TRIM("VSTELLE") LIKE "0%"
      OR TRIM("EQUNR") LIKE "0%";

    UPDATE "EVER"
      SET "VKONTO" = REPLACE(LTRIM(REPLACE(TRIM("VKONTO"), "0", " ")), " ", "0"),
          "VERTRAG" = REPLACE(LTRIM(REPLACE(TRIM("VERTRAG"), "0", " ")), " ", "0"),
      "EINZDAT" = SUBSTR("EINZDAT", 7, 4) || SUBSTR("EINZDAT", 4, 2) || SUBSTR("EINZDAT", 1, 2)
    WHERE TRIM("VKONTO") LIKE "0%"
      OR TRIM("VERTRAG") LIKE "0%"
    OR "EINZDAT" LIKE "%.%";

    UPDATE "INSTLN"
      SET "ANLAGE" = REPLACE(LTRIM(REPLACE(TRIM("ANLAGE"), "0", " ")), " ", "0"),
          "VSTELLE" = REPLACE(LTRIM(REPLACE(TRIM("VSTELLE"), "0", " ")), " ", "0"),
      "ANLART" = REPLACE(LTRIM(REPLACE(TRIM("ANLART"), "0", " ")), " ", "0")
    WHERE TRIM("ANLAGE") LIKE "0%"
      OR TRIM("VSTELLE") LIKE "0%"
    OR TRIM("ANLART") LIKE "0%";
    
    UPDATE "MOVE-IN"
      SET "VKONTO" = REPLACE(LTRIM(REPLACE(TRIM("VKONTO"), "0", " ")), " ", "0"),
          "ANLAGE" = REPLACE(LTRIM(REPLACE(TRIM("ANLAGE"), "0", " ")), " ", "0"),
        "VERTRAG" = REPLACE(LTRIM(REPLACE(TRIM("VERTRAG"), "0", " ")), " ", "0")
    WHERE TRIM("VKONTO") LIKE "0%"
      OR TRIM("ANLAGE") LIKE "0%"
      OR TRIM("VERTRAG") LIKE "0%";

    UPDATE "REF_BARRIO"
      SET "COD_BARRIO" = REPLACE(LTRIM(REPLACE(TRIM("COD_BARRIO"), "0", " ")), " ", "0")
    WHERE TRIM("COD_BARRIO") LIKE "0%";
    
    UPDATE "PREMISE"
      SET "VSTELLE" = REPLACE(LTRIM(REPLACE(TRIM("VSTELLE"), "0", " ")), " ", "0")
    WHERE TRIM("VSTELLE") LIKE "0%";

    UPDATE "PARTNER"
      SET "PARTNER" = REPLACE(LTRIM(REPLACE(TRIM("PARTNER"), "0", " ")), " ", "0")
    WHERE TRIM("PARTNER") LIKE "0%";

    DELETE FROM ACCOUNT WHERE VKONT IS NULL;
      COMMIT;
    ''');
    db.execute('''
      BEGIN;      
      DROP TABLE IF EXISTS "TABLA_Z";
        CREATE TABLE "TABLA_Z" (
        "ACC-VKONT"	TEXT NOT NULL,
        "ACC-VKTYP"	TEXT,
        "ACC-VKONA"	TEXT,
        "ACC-REGIOGROUP_CA"	TEXT,
        "ACC-KTOKL"	TEXT,
        "ACC-KOFIZ_SD"	TEXT,
        "ACC-ABWVK"	TEXT,
        "ACC-ZZDIR"	TEXT,
        "ACC-ZPORTION" TEXT,
        "ACC-REGIOGROUP" TEXT,
        "ACC-MANSP"	TEXT,
        "ACC-FICA_INV_REASON" TEXT,
        "ACC-LOEVM"	TEXT,
        "INS-ANLAGE_1"	TEXT,
        "INS-ANLAGE_2"	TEXT,
        "INS-ANLAGE_3"	TEXT,
        "INS-SPARTE_1"	TEXT,
        "INS-SPARTE_2"	TEXT,
        "INS-SPARTE_3"	TEXT,
        "INS-AB_1"	TEXT,
        "INS-AB_2"	TEXT,
        "INS-AB_3"	TEXT,
        "INS-BIS_1"	TEXT,
        "INS-BIS_2"	TEXT,
        "INS-BIS_3"	TEXT,
        "INS-AKLASSE_1"	TEXT,
        "INS-AKLASSE_2"	TEXT,
        "INS-AKLASSE_3"	TEXT,
        "INS-TARIFTYP_1" TEXT,
        "INS-TARIFTYP_2" TEXT,
        "INS-TARIFTYP_3" TEXT,
        "INS-BRANCHE_1"	TEXT,
        "INS-BRANCHE_2"	TEXT,
        "INS-BRANCHE_3"	TEXT,
        "INS-ABLEINH_1"	TEXT,
        "INS-ABLEINH_2"	TEXT,
        "INS-ABLEINH_3"	TEXT,
        "INS-ANLART_1"	TEXT,
        "INS-ANLART_2"	TEXT,
        "INS-ANLART_3"	TEXT,
        "INS-TEMP_AREA_1" TEXT,
        "INS-TEMP_AREA_2" TEXT,
        "INS-TEMP_AREA_3" TEXT,
        "INS-KONDIGR_1"	TEXT,
        "INS-KONDIGR_2"	TEXT,
        "INS-KONDIGR_3"	TEXT,
        "INS-TARIFART_1" TEXT,
        "INS-TARIFART_2" TEXT,
        "INS-TARIFART_3" TEXT,
        "MOV-STAGRUVER_1" TEXT,
        "MOV-STAGRUVER_2" TEXT,
        "MOV-STAGRUVER_3" TEXT,
        "MOV-EINZDAT_1"	TEXT,
        "MOV-EINZDAT_2"	TEXT,
        "MOV-EINZDAT_3"	TEXT,
        "MOV-AUSZDAT_1"	TEXT,
        "MOV-AUSZDAT_2"	TEXT,
        "MOV-AUSZDAT_3"	TEXT,
        "REC-OPERAND_1"	TEXT,
        "REC-OPERAND_2"	TEXT,
        "REC-OPERAND_3"	TEXT,
        "REC-AB_1"	TEXT,
        "REC-AB_2"	TEXT,
        "REC-AB_3"	TEXT,
        "REC-BIS_1"	TEXT,
        "REC-BIS_2"	TEXT,
        "REC-BIS_3"	TEXT,
        "PRM-VSTELLE" TEXT,
        "PRM-VBSART" TEXT,
        "PRM-HAUS_NUM2"	TEXT,
        "PRM-FLOOR"	TEXT,
        "PRM-ROOMNUMBER" TEXT,
        "PRM-ANZPERS" TEXT,
        "PRM-LGZUSATZ" TEXT,
        "OTR-IND-RED_ASSIST" TEXT,
        "OTR-IND_FAC_VIRTUAL" TEXT,
        "OTR-NPN" TEXT,
        "OTR-LONGITUD" TEXT,
        "OTR-LATITUD" TEXT,
        "OTR-LOCALIDAD"	TEXT,
        "COB-HAUS"	TEXT, 
        "COB-STREET" TEXT,
        "COB-REGPOLIT" TEXT,
        "COB-REGIOGROUP" TEXT,
        "COB-SWERK"	TEXT,
        "COB-PLTXT"	TEXT,
        "COB-STR_SUPPL2" TEXT,
        "COB-HOUSE_NUM1" TEXT,
        "COB-CITY1"	TEXT,
        "COB-REGION" TEXT,
        "PAR-PARTNER" TEXT,
        "PAR-NAME_ORG1"	TEXT,
        "PAR-BU_SORT1" TEXT,
        "PAR-TEL_NUMBER" TEXT,
        "PAR-NAME_FIRST" TEXT,
        "PAR-NAME_LAST"	TEXT,
        "PAR-MOB_NUMBER" TEXT,
        "PAR-SMTP_ADDR"	TEXT,
        "PAR-TYPE" TEXT,
        "PAR-IDNUMBER" TEXT,
        "DEV-EQUNR"	TEXT,
        "DEV-HERST"	TEXT,
        "DEV-MATNR"	TEXT,
        "DEV-SWERK"	TEXT,
        "DEV-SERNR"	TEXT,
        "DEV-EQTYP"	TEXT,
        "DEV-STTXT"	TEXT,
        "DEV-INGRP"	TEXT,
        "DEV-AB" TEXT,
        "DEV-BIS" TEXT,
        "EVR-VERTRAG_1"	TEXT,
        "EVR-VERTRAG_2"	TEXT,
        "EVR-VERTRAG_3"	TEXT,
        "EVR-BUKRS_1" TEXT,
        "EVR-BUKRS_2" TEXT,
        "EVR-BUKRS_3" TEXT,
        "EVR-GEMFAKT_1"	TEXT,
        "EVR-GEMFAKT_2"	TEXT,
        "EVR-GEMFAKT_3"	TEXT,
        "EVR-ABRSPERR_1" TEXT,
        "EVR-ABRSPERR_2" TEXT,
        "EVR-ABRSPERR_3" TEXT,
        "EVR-ABRFREIG_1" TEXT,
        "EVR-ABRFREIG_2" TEXT,
        "EVR-ABRFREIG_3" TEXT,
        "EVR-COKEY_1" TEXT,
        "EVR-COKEY_2" TEXT,
        "EVR-COKEY_3" TEXT,
        "EVR-BSTATUS_1"	TEXT,
        "EVR-BSTATUS_2"	TEXT,
        "EVR-BSTATUS_3"	TEXT,
        "EVR-FAKTURIERT_1"	TEXT,
        "EVR-FAKTURIERT_2"	TEXT,
        "EVR-FAKTURIERT_3"	TEXT,
        "EVR-EINZDAT_1"	TEXT,
        "EVR-EINZDAT_2"	TEXT,
        "EVR-EINZDAT_3"	TEXT,
        "EVR-AUSZDAT_1"	TEXT,
        "EVR-AUSZDAT_2"	TEXT,
        "EVR-AUSZDAT_3"	TEXT,
        "FAC-ZZCODCON_1" TEXT,
        "FAC-ZZCODCON_2" TEXT,
        "FAC-ZZCODCON_3" TEXT,
        "FAC-ZZCODCON_4" TEXT,
        "FAC-ZZCODCON_5" TEXT,
        "FAC-ZZCODCON_6" TEXT,
        "FAC-PERVERBR_1" TEXT,
        "FAC-PERVERBR_2" TEXT,
        "FAC-PERVERBR_3" TEXT,
        "FAC-PERVERBR_4" TEXT,
        "FAC-PERVERBR_5" TEXT,
        "FAC-PERVERBR_6" TEXT,
        "FAC-ZZCONPROM"	TEXT,
        "FAC-ZZVIGENCIA" TEXT,
        "FAC-ZZCMO_PATRON"	TEXT,
        "FAC-I_ZWSTAND"	TEXT,
        "FAC-I_ZWSTVOR"	TEXT,
        PRIMARY KEY("ACC-VKONT")
      );
      CREATE INDEX "IX-ACCOUNT-GPART" ON "ACCOUNT" (
        "GPART"	ASC
      );

      CREATE INDEX "IX-ACCOUNT-VKONT" ON "ACCOUNT" (
        "VKONT"	ASC
      );

      CREATE INDEX "IX-CONNOBJ-HAUS" ON "CONNOBJ" (
        "HAUS"	ASC
      );

      CREATE INDEX "IX-DEVICE-VSTELLE" ON "DEVICE" (
        "VSTELLE"	ASC
      );

      CREATE INDEX "IX-EVR-VERTRAG" ON "EVER" (
        "VERTRAG"	ASC
      );

      CREATE INDEX "IX-EVR-VKONTO" ON "EVER" (
        "VKONTO"	ASC
      );

      CREATE INDEX "IX-INSTLN-ANLAGE" ON "INSTLN" (
        "ANLAGE"	ASC
      );

      CREATE INDEX "IX-INSTLN-VSTELLE" ON "INSTLN" (
        "VSTELLE"	ASC
      );

      CREATE INDEX "IX-MOVEIN-ANLAGE" ON "MOVE-IN" (
        "ANLAGE"	ASC
      );

      CREATE INDEX "IX-MOVEIN-VERTRAG" ON "MOVE-IN" (
        "VERTRAG"	ASC
      );

      CREATE INDEX "IX-MOVEIN-VKONTO" ON "MOVE-IN" (
        "VKONTO"	ASC
      );

      CREATE INDEX "IX-PARTNER-PARTNER" ON "PARTNER" (
        "PARTNER"	ASC
      );
      COMMIT;
      ''');
    db.execute('''
      BEGIN;
      INSERT INTO "TABLA_Z"
        ("ACC-VKONT", "ACC-VKTYP", "ACC-VKONA", "ACC-REGIOGROUP_CA", "ACC-KTOKL", "ACC-KOFIZ_SD", "ACC-ABWVK",
          "ACC-ZZDIR", "ACC-ZPORTION", "ACC-REGIOGROUP", "PAR-PARTNER")
      SELECT AC."VKONT", AC."VKTYP", AC."VKONA", AC."REGIOGR_CA_T", AC."KTOKL", AC."KOFIZ_SD", AC."ABWVK",
        AC."ZZDIR", AC."ZPORTION", AC."REGIOGROUP", "GPART"
      FROM "ACCOUNT" AC
            LEFT JOIN "TABLA_Z" TZ
        ON AC."VKONT" = TZ."ACC-VKONT" 
      WHERE TZ."ACC-VKONT" IS NULL
      GROUP BY AC.VKONT;
      COMMIT;
      ''');
    db.execute('''
      UPDATE "TABLA_Z"
          SET "PAR-NAME_ORG1" = T."NAME_ORG1",
            "PAR-BU_SORT1" = T."BU_SORT1",
            "PAR-TEL_NUMBER" = T."TEL_NUMBER",
            "PAR-NAME_FIRST" = T."NAME_FIRST",
            "PAR-NAME_LAST" = T."NAME_LAST"
        FROM ((SELECT PR.* 
              FROM "PARTNER" PR 
            GROUP BY PR."PARTNER"
            ORDER BY PR."TEL_NUMBER" DESC)) AS T
        WHERE "TABLA_Z"."PAR-PARTNER" = T."PARTNER"
          AND "TABLA_Z"."PAR-NAME_ORG1" IS NULL 
          AND "TABLA_Z"."PAR-NAME_FIRST" IS NULL;
          
        ''');
    db.execute('''
      UPDATE "TABLA_Z"
        SET "INS-ANLAGE_1" = T."ANLAGE",
          "INS-SPARTE_1" = T."SPARTE",
          "INS-AB_1" = T."AB",
          "INS-BIS_1" = T."BIS",
          "INS-AKLASSE_1" = T."AKLASSE", 
          "INS-TARIFTYP_1" = T."TARIFTYP",
          "INS-BRANCHE_1" = T."BRANCHE", 
          "INS-ABLEINH_1" = T."ABLEINH", 
          "INS-ANLART_1" = T."ANLART",
          "INS-TEMP_AREA_1" = T."TEMP_AREA", 
          "INS-KONDIGR_1"	= T."KONDIGR", 
          "INS-TARIFART_1" =  T."TARIFART",
          "PRM-VSTELLE" = T."VSTELLE"
      FROM (SELECT MV1."VKONTO", INS.*
            FROM "INSTLN" INS
                INNER JOIN 
            (SELECT DISTINCT MV."ANLAGE", MV."VKONTO"
            FROM "MOVE-IN" MV
            WHERE MV."ANLAGE" IS NOT NULL) AS MV1
            ON INS."ANLAGE" = MV1.ANLAGE
          WHERE INS.SPARTE = "10"
          GROUP BY MV1."VKONTO"
          ORDER BY INS.BIS DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."INS-ANLAGE_1" IS NULL;
      ''');
    db.execute('''
        BEGIN;
      -- 3.2 INSTALACIÓN ALCANTARILLADO CON MEDIDOR
      UPDATE "TABLA_Z"
        SET "INS-ANLAGE_2" = T."ANLAGE",
            "INS-SPARTE_2" = T."SPARTE",
            "INS-AB_2" = T."AB",
            "INS-BIS_2" = T."BIS",
            "INS-AKLASSE_2" = T."AKLASSE", 
            "INS-TARIFTYP_2" = T."TARIFTYP",
            "INS-BRANCHE_2" = T."BRANCHE", 
            "INS-ABLEINH_2" = T."ABLEINH", 
            "INS-ANLART_2" = T."ANLART",
            "INS-TEMP_AREA_2" = T."TEMP_AREA", 
            "INS-KONDIGR_2"	= T."KONDIGR", 
            "INS-TARIFART_2" =  T."TARIFART",
            "PRM-VSTELLE" = IFNULL("PRM-VSTELLE", T."VSTELLE")
      FROM (SELECT MV1."VKONTO", INS.*
            FROM "INSTLN" INS
                INNER JOIN 
            (SELECT DISTINCT MV."ANLAGE", MV."VKONTO"
            FROM "MOVE-IN" MV
            WHERE MV."ANLAGE" IS NOT NULL) AS MV1
            ON INS."ANLAGE" = MV1.ANLAGE
          WHERE INS."SPARTE" = "20"
          AND INS."TARIFTYP" NOT LIKE "AL%CLOI%"
          GROUP BY MV1."VKONTO"	 
            ORDER BY INS."BIS" DESC, INS."ANLAGE" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."INS-ANLAGE_2" IS NULL;
        COMMIT;
        ''');
    db.execute('''
        BEGIN;
      -- 3.3 INSTALACIÓN ALCANTARILLADO SIN MEDIDOR
      UPDATE "TABLA_Z"
        SET "INS-ANLAGE_3" = T."ANLAGE",
            "INS-SPARTE_3" = T."SPARTE",
            "INS-AB_3" = T."AB",
            "INS-BIS_3" = T."BIS",
            "INS-AKLASSE_3" = T."AKLASSE", 
            "INS-TARIFTYP_3" = T."TARIFTYP",
            "INS-BRANCHE_3" = T."BRANCHE", 
            "INS-ABLEINH_3" = T."ABLEINH", 
            "INS-ANLART_3" = T."ANLART",
            "INS-TEMP_AREA_3" = T."TEMP_AREA", 
            "INS-KONDIGR_3"	= T."KONDIGR", 
            "INS-TARIFART_3" =  T."TARIFART",
            "PRM-VSTELLE" = IFNULL("PRM-VSTELLE", T."VSTELLE")
      FROM (SELECT MV1."VKONTO", INS.*
            FROM "INSTLN" INS
                INNER JOIN 
            (SELECT DISTINCT MV."ANLAGE", MV."VKONTO"
            FROM "MOVE-IN" MV
            WHERE MV."ANLAGE" IS NOT NULL) AS MV1
            ON INS."ANLAGE" = MV1.ANLAGE
          WHERE INS."SPARTE" = "20"
          AND INS."TARIFTYP" LIKE "AL%CLOI%"
          GROUP BY MV1."VKONTO"	 
            ORDER BY INS."BIS" DESC, INS."ANLAGE" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."INS-ANLAGE_3" IS NULL;
      COMMIT;''');
    db.execute('''
      BEGIN;
      -- 4.1 ALTA DE INSTALACIÓN ACUEDUCTO
      UPDATE "TABLA_Z"
        SET "MOV-STAGRUVER_1" = T."STAGRUVER",
          "MOV-EINZDAT_1" = T."EINZDAT",
          "MOV-AUSZDAT_1" = T."AUSZDAT",
          "EVR-VERTRAG_1" = T."VERTRAG"
      FROM (SELECT MI.*
            FROM "MOVE-IN" MI 
          WHERE MI.SPARTE = "10"
          GROUP BY MI."VKONTO" 
          ORDER BY MI."AUSZDAT" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."INS-ANLAGE_1" = T."ANLAGE"
        AND "TABLA_Z"."EVR-VERTRAG_1" IS NULL;

      -- 4.2 ALTA DE INSTALACIÓN ALCANTARILLADO CON MEDIDOR
      UPDATE "TABLA_Z"
        SET "MOV-STAGRUVER_2" = T."STAGRUVER",
          "MOV-EINZDAT_2" = T."EINZDAT",
          "MOV-AUSZDAT_2" = T."AUSZDAT",
          "EVR-VERTRAG_2" = T."VERTRAG"
      FROM (SELECT MI.*
            FROM "MOVE-IN" MI 
          WHERE MI.SPARTE = "20"
          GROUP BY MI."VKONTO" 
          ORDER BY MI."AUSZDAT" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."INS-ANLAGE_2" = T."ANLAGE"
        AND "TABLA_Z"."EVR-VERTRAG_2" IS NULL;
        
      -- 4.3 ALTA DE INSTALACIÓN ALCANTARILLADO SIN MEDIDOR
      UPDATE "TABLA_Z"
        SET "MOV-STAGRUVER_3" = T."STAGRUVER",
          "MOV-EINZDAT_3" = T."EINZDAT",
          "MOV-AUSZDAT_3" = T."AUSZDAT",
          "EVR-VERTRAG_3" = T."VERTRAG"
      FROM (SELECT MI.*
            FROM "MOVE-IN" MI 
          WHERE MI.SPARTE = "20"
          GROUP BY MI."VKONTO" 
          ORDER BY MI."AUSZDAT" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."INS-ANLAGE_3" = T."ANLAGE"
        AND "TABLA_Z"."EVR-VERTRAG_3" IS NULL;
      COMMIT;''');
    db.execute('''
      BEGIN;
      -- 5. PUNTO DE SUMINSTRO
      UPDATE "TABLA_Z"
        SET "PRM-VBSART" = T."VBSART",
          "PRM-HAUS_NUM2" = T."HAUS_NUM2",
          "PRM-FLOOR"	= T."FLOOR",
          "PRM-ROOMNUMBER" = T."ROOMNUMBER",
          "PRM-ANZPERS" = T."ANZPERS",
          "PRM-LGZUSATZ" = T."LGZUSATZ",
          "COB-HAUS" = T."HAUS"
      FROM (SELECT PR.* 
            FROM "PREMISE" PR 
          GROUP BY PR.VSTELLE
          ORDER BY PR.LGZUSATZ DESC) AS T
      WHERE "TABLA_Z"."PRM-VSTELLE" = T."VSTELLE"
        AND "TABLA_Z"."COB-HAUS" IS NULL;

      -- 6.1 CONTRATO ACUEDUCTO
      UPDATE "TABLA_Z"
        SET "EVR-GEMFAKT_1"	= T."GEMFAKT",
          "EVR-ABRSPERR_1" = T."ABRSPERR",
          "EVR-ABRFREIG_1" = T."ABRFREIG",
          "EVR-COKEY_1" = T."COKEY",
          "EVR-BSTATUS_1"	= T."BSTATUS",
          "EVR-FAKTURIERT_1" = T."FAKTURIERT",
          "EVR-EINZDAT_1" = T."EINZDAT",
          "EVR-AUSZDAT_1"	= T."AUSZDAT"
      FROM (SELECT EV.* 
            FROM "EVER" EV
            GROUP BY EV."VKONTO", EV."VERTRAG"
          ORDER BY EV."AUSZDAT" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."EVR-VERTRAG_1" = T."VERTRAG"
        AND "TABLA_Z"."EVR-AUSZDAT_1" IS NULL;

      -- 6.2 CONTRATO ALCANTARILLADO CON MEDIDOR
      UPDATE "TABLA_Z"
        SET "EVR-GEMFAKT_2"	= T."GEMFAKT",
          "EVR-ABRSPERR_2" = T."ABRSPERR",
          "EVR-ABRFREIG_2" = T."ABRFREIG",
          "EVR-COKEY_2" = T."COKEY",
          "EVR-BSTATUS_2"	= T."BSTATUS",
          "EVR-FAKTURIERT_2" = T."FAKTURIERT",
          "EVR-EINZDAT_2" = T."EINZDAT",
          "EVR-AUSZDAT_2"	= T."AUSZDAT"
      FROM (SELECT EV.* 
            FROM "EVER" EV
            GROUP BY EV."VKONTO", EV."VERTRAG"
          ORDER BY EV."AUSZDAT" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."EVR-VERTRAG_2" = T."VERTRAG"
        AND "TABLA_Z"."EVR-AUSZDAT_2" IS NULL;

      -- 6.3 CONTRATO ALCANTARILLADO SIN MEDIDOR
      UPDATE "TABLA_Z"
        SET "EVR-GEMFAKT_3"	= T."GEMFAKT",
          "EVR-ABRSPERR_3" = T."ABRSPERR",
          "EVR-ABRFREIG_3" = T."ABRFREIG",
          "EVR-COKEY_3" = T."COKEY",
          "EVR-BSTATUS_3"	= T."BSTATUS",
          "EVR-FAKTURIERT_3" = T."FAKTURIERT",
          "EVR-EINZDAT_3" = T."EINZDAT",
          "EVR-AUSZDAT_3"	= T."AUSZDAT"
      FROM (SELECT EV.* 
            FROM "EVER" EV
            GROUP BY EV."VKONTO", EV."VERTRAG"
          ORDER BY EV."AUSZDAT" DESC) AS T
      WHERE "TABLA_Z"."ACC-VKONT" = T."VKONTO"
        AND "TABLA_Z"."EVR-VERTRAG_3" = T."VERTRAG"
        AND "TABLA_Z"."EVR-AUSZDAT_3" IS NULL;
        COMMIT;''');
    db.execute('''
      -- 7 MEDIDOR
      BEGIN;
      UPDATE "TABLA_Z"
        SET "DEV-EQUNR" = T."EQUNR",
          "DEV-HERST" = T."HERST",
          "DEV-MATNR" = T."MATNR",
          "DEV-SWERK" = T."SWERK",
          "DEV-SERNR" = T."SERNR",
          "DEV-EQTYP" = T."EQTYP",
          "DEV-STTXT" = T."STTXT",
          "DEV-INGRP" = T."INGRP"
      FROM (SELECT DV.* 
            FROM "DEVICE" DV
            GROUP BY DV."VSTELLE"
          ORDER BY DV."DATAB" DESC) AS T
      WHERE "TABLA_Z"."PRM-VSTELLE" = T."VSTELLE"
        AND "TABLA_Z"."DEV-EQUNR" IS NULL;

      -- 8 OBJETO DE CONEXION
      UPDATE "TABLA_Z"
        SET "COB-HAUS" = T."HAUS",
          "COB-STREET" = T."STREET",
          "COB-REGPOLIT" = T."REGPOLIT",
          "COB-REGIOGROUP" = T."REGIOGROUP",
          "COB-SWERK" = T."SWERK",
          "COB-PLTXT" = T."PLTXT",
          "COB-STR_SUPPL2"	= T."STR_SUPL2",
          "COB-HOUSE_NUM1"	= T."HOUSE_NUM1",
          "COB-CITY1" = T."CITY1",
          "COB-REGION"	= T."REGION"
      FROM (SELECT OC.* 
            FROM "CONNOBJ" OC
            GROUP BY OC."HAUS") AS T
      WHERE "TABLA_Z"."COB-HAUS" = T."HAUS"
        AND "TABLA_Z"."COB-STREET" IS NULL;
        UPDATE "TABLA_Z"
     SET "OTR-LOCALIDAD" = T."COD_LOCALIDAD"
      FROM "REF_BARRIO" AS T
      WHERE "TABLA_Z"."COB-REGPOLIT" = T."COD_BARRIO"
        AND "TABLA_Z"."OTR-LOCALIDAD" IS NULL;
      COMMIT;''');
    db.execute('''
        BEGIN;
        DROP VIEW IF EXISTS VW_TABLAZ;
        CREATE VIEW VW_TABLAZ AS 
          SELECT 
            -- DATOS DE CUENTA CONTRATO
          "ACC-VKONT" AS "CTACTO", "ACC-VKTYP" AS "CTA_TIPO", "ACC-VKONA" AS "CTA_INTERNA", 
          "ACC-REGIOGROUP_CA" AS "CTA_EST_REGIONAL_1", "ACC-KOFIZ_SD" AS "CTA_CLAUSO", "ACC-KTOKL" AS "CTA_ESTRATO", 
          "ACC-ABWVK" AS "CTA_FAC_COLECTIVA", "ACC-ZZDIR" AS "CTA_DIR_CORRESP", "ACC-ZPORTION" AS "PORCION_CTACTO", 
          "ACC-REGIOGROUP" AS "ESTREGIONAL_CTACTO_2", "ACC-MANSP" AS "CTA_MOTBLQREC", "ACC-FICA_INV_REASON" AS "CTA_MOTBLQFICA", 
          "ACC-LOEVM" AS "CTA_PET_BORRADO",
          -- INSTALACION DE ACUEDUCTO
          "INS-ANLAGE_1" AS "INSTALACION_AC", "INS-SPARTE_1" AS "SECTOR_AC", "INS-AB_1" AS "ALTA_INS_AC", "INS-BIS_1" AS "BAJA_INS_AC", 
          "INS-AKLASSE_1" AS "INS_CLASE_CALCULO_AC", "INS-TARIFTYP_1" AS "INS_CLASE_TARIFA_AC", "INS-BRANCHE_1" AS "INS_SOLSECTORIAL_AC", 
          "INS-ABLEINH_1" AS "INS_UNILECTURA_AC", "INS-ANLART_1" AS "INS_CLASE_INSTALACION_AC", "INS-TEMP_AREA_1" AS "INS_ZONA_TEMPERATURA_AC", 
          "INS-KONDIGR_1" AS "INS_GRP_VAL_CONCRETOS_AC", 	"INS-TARIFART_1" AS "INS_TARIFA_AC", "MOV-STAGRUVER_1" AS "MOV_GRP_ESTADISTICA_AC",  
          "MOV-EINZDAT_1" AS "MOV_FALTA_AC", "MOV-AUSZDAT_1" AS "MOV_FBAJA_AC", 
          "REC-OPERAND_1" AS "INS_VLR_OPERANDO_AC", "REC-AB_1" AS "INS_OPERANDO_FINI_AC", "REC-BIS_1" AS "INS_OPERANDO_FFIN_AC", 
          -- INSTALACION DE ALCANTARILLADO CON MEDIDOR
          "INS-ANLAGE_2" AS "INSTALACION_AL_1", "INS-SPARTE_2" AS "SECTOR_AL_1", "INS-AB_2" AS "ALTA_INS_AL_1", "INS-BIS_2" AS "BAJA_INS_AL_1", 
          "INS-AKLASSE_2" AS "INS_CLASE_CALCULO_AL_1", "INS-TARIFTYP_2" AS "INS_CLASE_TARIFA_AL_1", "INS-BRANCHE_2" AS "INS_SOLSECTORIAL_AL_1", 
          "INS-ABLEINH_2" AS "INS_UNILECTURA_AL_1", "INS-ANLART_2" AS "INS_CLASE_INSTALACION_AL_1", "INS-TEMP_AREA_2" AS "INS_ZONA_TEMPERATURA_AL_1", 
          "INS-KONDIGR_2" AS "INS_GRP_VAL_CONCRETOS_AL_1", "INS-TARIFART_2" AS "INS_TARIFA_AL_1", "MOV-STAGRUVER_2" AS "MOV_GRP_ESTADISTICA_AL_1", 
          "MOV-EINZDAT_2" AS "MOV_FALTA_AL_1", "MOV-AUSZDAT_2" AS "MOV_FBAJA_AL_1", 
          "REC-OPERAND_2" AS "INS_VLR_OPERANDO_AL_1", "REC-AB_2" AS "INS_OPERANDO_FINI_AL_1", "REC-BIS_2" AS "INS_OPERANDO_FFIN_AL_1", 
          -- INSTALACION DE ALCANTARILLADO FUENTES ALTERNAS
          "INS-ANLAGE_3" AS "INSTALACION_AL_2", "INS-SPARTE_3" AS "SECTOR_AL_2", "INS-AB_3" AS "ALTA_INS_AL_2", "INS-BIS_3" AS "BAJA_INS_AL_2", 
          "INS-AKLASSE_3" AS "INS_CLASE_CALCULO_AL_2", "INS-TARIFTYP_3" AS "INS_CLASE_TARIFA_AL_2", "INS-BRANCHE_3" AS "INS_SOLSECTORIAL_AL_2", 
          "INS-ABLEINH_3" AS "INS_UNILECTURA_AL_2", "INS-ANLART_3" AS "INS_CLASE_INSTALACION_AL_2", "INS-TEMP_AREA_3" AS "INS_ZONA_TEMPERATURA_AL_2", 
          "INS-KONDIGR_3" AS "INS_GRP_VAL_CONCRETOS_AL_2", "INS-TARIFART_3" AS "INS_TARIFA_AL_2", "MOV-STAGRUVER_3"AS "MOV_GRP_ESTADISTICA_AL_2",  
          "MOV-EINZDAT_3" AS "MOV_FALTA_AL_2", "MOV-AUSZDAT_3" AS "MOV_FBAJA_AL_2", 
          "REC-OPERAND_3" AS "INS_VLR_OPERANDO_AL_2", "REC-AB_3" AS "INS_OPERANDO_FINI_AL_2", "REC-BIS_3" AS "INS_OPERANDO_FFIN_AL_2", 
          -- DATOS PUNTO DE SUMINISTRO
          "PRM-VSTELLE" AS "PRM_PUNTO_SUMINISTRO", "PRM-VBSART" AS "PRM_TPO_PUNTO_CONSUMO", "PRM-HAUS_NUM2" AS "PRM_AGREGACION", 
          "PRM-FLOOR" AS "PRM_UH", "PRM-ROOMNUMBER" AS "PRM_UNH", "PRM-ANZPERS" AS "PRM_NRO_PERSONAS", "PRM-LGZUSATZ" AS "PRM_CHIP_CATASTRAL", 
          -- OTROS DATOS
          "OTR-IND-RED_ASSIST" AS "IND_RED_ASSIST", "OTR-IND_FAC_VIRTUAL" AS "IND_FAC_VIRTUAL", "OTR-NPN" AS "NUM_PREDIO_NACIONAL", 
          "OTR-LONGITUD" AS "LONGITUD", "OTR-LATITUD" AS "LATITUD", "OTR-LOCALIDAD" AS "LOCALIDAD", 
          -- OBJETO DE CONEXIÓN
          "COB-HAUS" AS "COB_OBJETO_CONEXION", "COB-STREET" AS "COB_CALLE", "COB-REGPOLIT" AS "COB_BARRIO", "COB-REGIOGROUP" AS "COB_ESTREGIONAL", 
          "COB-SWERK" AS "COB_ZONA", "COB-PLTXT" AS "COB_DENOM_UBICACION", "COB-STR_SUPPL2" AS "COB_CALLE3", "COB-HOUSE_NUM1" AS "COB_NUMERO_PLACA", 
          "COB-CITY1" AS "COB_POBLACION", "COB-REGION" AS "COD_REGION",
          -- INTERLOCUTOR
          "PAR-PARTNER" AS "PAR_INTERLOCUTOR", "PAR-NAME_ORG1" AS "PAR_NME_EMPRESA", "PAR-BU_SORT1" AS "PAR_CONCEP_BUSQUEDA", 
          "PAR-TEL_NUMBER" AS "PAR_TELEFONO", "PAR-NAME_FIRST" AS "PAR_NOMBRE", "PAR-NAME_LAST" AS "PAR_APELLIDO", "PAR-MOB_NUMBER" AS "PAR_CELULAR", 
          "PAR-SMTP_ADDR" AS "PAR_EMAIL", "PAR-TYPE" AS "PAR_TIPO_DOCUMENTO", "PAR-IDNUMBER" AS "PAR_NRO_DOCUMENTO", 
          -- APARATO
          "DEV-EQUNR" AS "DEV_NRO_APARATO", "DEV-HERST" AS "DEV_MARCA", "DEV-MATNR" AS "DEV_MATERIAL", "DEV-SWERK" AS "DEV_CENTRO_EMPLAZAMIENTO", 
          "DEV-SERNR" AS "DEV_SERIAL_MEDIDOR", "DEV-EQTYP" AS "DEV_TIPO", "DEV-STTXT" AS "DEV_STATUS", "DEV-INGRP" AS "DEV_GRP_PLANIFICACION", 
          "DEV-AB" AS "DEV_FINI", "DEV-BIS" AS "DEV_FFIN", 
          -- CONTRATO ACUEDUCTO
          "EVR-VERTRAG_1" AS "EVR_CONTRATO_AC", "EVR-BUKRS_1" AS "EVR_SOCIEDAD_AC", "EVR-GEMFAKT_1" AS "EVR_FAC_CONJUNTA_AC", 
          "EVR-ABRSPERR_1" AS "EVR_MOT_BLOQ_AC", "EVR-ABRFREIG_1" AS "EVR_MOT_LIB_BLOQ_AC", "EVR-COKEY_1" AS "EVR_CENTRO_IMPUTACION_AC", 
          "EVR-BSTATUS_1" AS "EVR_TRATAMIENTO_AC", "EVR-FAKTURIERT_1" AS "EVR_ULT_FACTURA_AC", "EVR-EINZDAT_1" AS "EVR_FALTA_AC", 
          "EVR-AUSZDAT_1" AS "EVR_FBAJA_AC", 
          -- CONTRATO ALCANTARILLADO CON MEDIDOR
          "EVR-VERTRAG_2" AS "EVR_CONTRATO_AL_1", "EVR-BUKRS_2" AS "EVR_SOCIEDAD_AL_1", "EVR-GEMFAKT_2" AS "EVR_FAC_CONJUNTA_AL_1", 
          "EVR-ABRSPERR_2" AS "EVR_MOT_BLOQ_AC", "EVR-ABRFREIG_2" AS "EVR_MOT_LIB_BLOQ_AL_1", "EVR-COKEY_2" AS "EVR_CENTRO_IMPUTACION_AL_1", 
          "EVR-BSTATUS_2" AS "EVR_TRATAMIENTO_AL_1", "EVR-FAKTURIERT_2" AS "EVR_ULT_FACTURA_AL_1", "EVR-EINZDAT_2" AS "EVR_FALTA_AL_1", 
          "EVR-AUSZDAT_2" AS "EVR_FBAJA_AL_1",
          -- CONTRATO ALCANTARILLADO FUENTE ALTERNA
          "EVR-VERTRAG_3" AS "EVR_CONTRATO_AL_2", "EVR-BUKRS_3" AS "EVR_SOCIEDAD_AL_2", "EVR-GEMFAKT_3" AS "EVR_FAC_CONJUNTA_AL_2",
          "EVR-ABRSPERR_3" AS "EVR_MOT_BLOQ_AC", "EVR-ABRFREIG_3" AS "EVR_MOT_LIB_BLOQ_AL_2", "EVR-COKEY_3" AS "EVR_CENTRO_IMPUTACION_AL_2", 
          "EVR-BSTATUS_3" AS "EVR_TRATAMIENTO_AL_2", "EVR-FAKTURIERT_3" AS "EVR_ULT_FACTURA_AC", "EVR-EINZDAT_3" AS "EVR_FALTA_AL_2", 
          "EVR-AUSZDAT_3" AS "EVR_FBAJA_AL_2",  
          -- DATOS FACTURACIÓN
          "FAC-ZZCODCON_1" AS "FAC_COD_CONSUMO_1", "FAC-ZZCODCON_2" AS "FAC_COD_CONSUMO_2", "FAC-ZZCODCON_3" AS "FAC_COD_CONSUMO_3",  
          "FAC-ZZCODCON_4" AS "FAC_COD_CONSUMO_4", "FAC-ZZCODCON_5" AS "FAC_COD_CONSUMO_5",  "FAC-ZZCODCON_6" AS "FAC_COD_CONSUMO_6",  
          "FAC-PERVERBR_1" AS "FAC_CONSUMO_1", "FAC-PERVERBR_2" AS "FAC_CONSUMO_2", "FAC-PERVERBR_3" AS "FAC_CONSUMO_3",  
          "FAC-PERVERBR_4" AS "FAC_CONSUMO_4", "FAC-PERVERBR_5" AS "FAC_CONSUMO_5", "FAC-PERVERBR_6" AS "FAC_CONSUMO_6",  
          "FAC-ZZCONPROM" AS "FAC_CONS_PROM", "FAC-ZZVIGENCIA" AS "FAC_VIG_ACTUAL", "FAC-ZZCMO_PATRON" AS "FAC_CONSUMO_PATRON", 
          "FAC-I_ZWSTAND" AS "FAC_LECTURA_ACT", "FAC-I_ZWSTVOR" AS "FAC_LECTURA_ANT"
        FROM "TABLA_Z" AS TZ;	 
      COMMIT;
      VACUUM;
      ''');
  }
}
