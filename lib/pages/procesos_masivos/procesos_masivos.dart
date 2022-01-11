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
  Color azul02 = const Color.fromARGB(255, 23, 48, 83);
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [azul02, fondo],
                stops: const [0.1, 0.9]),
          ),
          child: Center(
            child: Column(
              children: [
                const Encabezado(),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black38,
                      ),
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 80,
                      child: ListTile(
                        leading: const Icon(
                          Icons.folder_open,
                          size: 50,
                          color: Colors.white,
                        ),
                        trailing: const Icon(Icons.navigate_next_rounded,
                            size: 50, color: Colors.green),
                        title: Text('Creación Tabla Z', style: titulo3),
                        subtitle: Text(
                            'Ingresa al modulo que automatiza la creación de la Tabla Z',
                            style: cuerpo),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreacionTablaZ()));
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
