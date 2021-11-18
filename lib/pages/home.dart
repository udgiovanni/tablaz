import 'package:flutter/material.dart';
import 'package:tablaz/ui/encabezado.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  //Borde Container
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Encabezado(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF103462),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.black54)
                        ]),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 550,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Acceso Rápido',
                            style: titulo,
                          ),
                          const Divider(color: Colors.white),
                          Text(
                            'Procesos Masivos',
                            style: titulo2,
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.folder_open,
                              size: 50,
                              color: Colors.white,
                            ),
                            title: const Text(
                              'Cargar Datos Tabla ACCOUNT  (1)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Importar Archivo TXT con los datos de la Tabla Account con los datos unificados en un solo archivo\nRuta cargada: $pathAccount',
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                            onTap: () async {},
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF103462),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 0.5,
                              offset: Offset(3, 3),
                              color: Colors.black54)
                        ]),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 550,
                    child: Column(
                      children: [
                        Text(
                          'Documentación',
                          style: titulo,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
