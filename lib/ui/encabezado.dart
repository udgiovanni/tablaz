import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tablaz/pages/home.dart';
import 'package:tablaz/pages/procesos_masivos/procesos_masivos.dart';
import 'package:tablaz/pages/utilidades/utilidades.dart';
import 'package:google_fonts/google_fonts.dart';

class Encabezado extends StatelessWidget {
  const Encabezado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF091d36),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
      ),
      child: Column(children: [
        const SizedBox(height: 30),
        Row(
          children: [
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width - 130 - 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      autofocus: false,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProcesosMasivos()));
                      },
                      child: Text('Procesos Masivos',
                          style: GoogleFonts.barlow(
                              color: Colors.white, fontSize: 16))),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Utilidades()));
                      },
                      child: Text('Utilidades',
                          style: GoogleFonts.barlow(
                              color: Colors.white, fontSize: 16))),
                  TextButton(
                      onPressed: () {
                        showToast("Modulo en desarrollo", context: context);
                      },
                      child: Text('Reportes',
                          style: GoogleFonts.barlow(
                              color: Colors.white, fontSize: 16))),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home(
                                      title: '',
                                    )));
                      },
                      child: Text('Inicio',
                          style: GoogleFonts.barlow(
                              color: Colors.white, fontSize: 16))),
                  const SizedBox(width: 30)
                ],
              ),
            )
          ],
        ),
      ]),
    );
  }
}
