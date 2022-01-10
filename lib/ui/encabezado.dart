import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tablaz/pages/home.dart';
import 'package:tablaz/pages/procesos_masivos/procesos_masivos.dart';
import 'package:tablaz/pages/utilidades/utilidades.dart';

class Encabezado extends StatelessWidget {
  const Encabezado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      const Text(
        'CATASTRO DE USUARIOS',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Reboto',
          fontSize: 24,
        ),
      ),
      const Text(
        'DIRECCIÓN DE APOYO COMERCIAL',
        style: TextStyle(
          color: Colors.white60,
          fontFamily: 'Reboto',
          fontSize: 14,
        ),
      ),
      Row(
        children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 160,
            decoration: const BoxDecoration(
              color: Color(0xFF103462),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home(
                                    title: '',
                                  )));
                    },
                    child: const Text('Inicio',
                        style: TextStyle(
                            fontFamily: 'Reboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            color: Colors.white))),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProcesosMasivos()));
                    },
                    child: const Text('Procesos Masivos',
                        style: TextStyle(
                            fontFamily: 'Reboto',
                            fontSize: 14.0,
                            color: Colors.white))),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Utilidades()));
                    },
                    child: const Text('Utilidades',
                        style: TextStyle(fontSize: 14.0, color: Colors.white))),
                const SizedBox(width: 20),
                TextButton(
                    onPressed: () {
                      showToast("Modulo en desarrollo", context: context);
                    },
                    child: const Text('Validaciones',
                        style: TextStyle(fontSize: 14.0, color: Colors.white))),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Image.asset('assets/images/logo.png', height: 150)
        ],
      ),
      const SizedBox(
        height: 30,
      ),
    ]);
  }
}
