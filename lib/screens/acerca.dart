// Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class Acerca extends StatefulWidget {
  const Acerca({super.key});

  @override
  _AcercaState createState() => _AcercaState();
}

class _AcercaState extends State<Acerca> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/me.jpg'),
                backgroundColor: Colors.black,
              ),
              const SizedBox(height: 21),
              const Text(
                'Nombre: ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 34, 59),
                    fontSize: 25),
              ),
              const SizedBox(height: 10),
              const Text(
                'Jean Luis De Los Santos Garabito',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              const Text(
                'Matrícula: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 34, 59),
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '2022-0442  ',
                style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 60),
              Container(
                width: double.infinity,
                height: 4,
                color: const Color.fromARGB(255, 2, 34, 59), // Color de la línea azul
              ),
              const SizedBox(height: 10),
              const Text(
                'Reflexión',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 34, 59),
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '"La democracia es la mejor forma de gobierno que existe, siempre que el pueblo sea capaz de gobernarse a sí mismo." - Abraham Lincoln',
                style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 4,
                color: const Color.fromARGB(255, 2, 34, 59), // Color de la línea azul
              ),
            ],
          ),
        ),
      ),
    );
  }
}
