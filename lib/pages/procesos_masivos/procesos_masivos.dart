import 'package:flutter/material.dart';
import 'package:tablaz/pages/procesos_masivos/creacion_tabla_z.dart';
import 'package:tablaz/ui/encabezado.dart';

class ProcesosMasivos extends StatefulWidget {
  ProcesosMasivos({Key? key}) : super(key: key);

  @override
  _ProcesosMasivosState createState() => _ProcesosMasivosState();
}

class _ProcesosMasivosState extends State<ProcesosMasivos> {
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
  TextStyle titulo3 = const TextStyle(
      fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle cuerpo = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
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
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFF103462),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 3),
                              color: Colors.black54)
                        ]),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ListTile(
                      leading: const Icon(
                        Icons.folder_open,
                        size: 50,
                        color: Colors.white,
                      ),
                      title: Text('Creación Tabla Z', style: titulo3),
                      subtitle: Text(
                          'Ingresa al modulo que automatiza la creación de la Tabla Z',
                          style: cuerpo),
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreacionTablaZ()));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
