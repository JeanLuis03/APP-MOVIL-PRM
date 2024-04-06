//Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tarea_8/screens/acerca.dart';
import 'package:tarea_8/screens/event_list.dart';
import 'package:tarea_8/screens/event_registration.dart';
import 'package:tarea_8/screens/home.dart';

// Definición de la clase MisVistas, un StatefulWidget que controla las vistas de la aplicación.
class MisVistas extends StatefulWidget {
  String title = 'APP Móvil PRM'; // Título predeterminado de la aplicación

  MisVistas({super.key,}); // Constructor de la clase MisVistas

  @override
  _MisVistasState createState() => _MisVistasState(); // Crea el estado de MisVistas
}

// Estado de MisVistas que maneja la lógica y el diseño de las vistas.
class _MisVistasState extends State<MisVistas> {
  int vistaActual = 0; // Índice de la vista actual

  // Método para obtener la vista correspondiente según el índice proporcionado.
  obtenerVista(int op) {
    switch (op) {
      case 0:
        return Inicio(); // Vista de Inicio
      case 1:
        return ListaEventos(); // Vista de Lista de Eventos
      case 2:
        return RegistrarEvento(); // Vista de Registro de Evento
      case 3:
        return Acerca(); // Vista "Acerca de"
      default:
    }
  }

  // Método para seleccionar una vista y actualizar el título de la aplicación.
  seleccionarVista(int op, String ntitle) {
    setState(() {
      vistaActual = op; // Actualizar índice de vista actual
      widget.title = ntitle; // Actualizar título de la aplicación
      Navigator.of(context).pop(); // Cerrar el menú desplegable
    });
  }

  @override
  Widget build(BuildContext context) {
    // Construcción de la pantalla con el menú desplegable y la vista actual.
    return Scaffold(
      // Menú desplegable lateral
      drawer: Drawer(
        backgroundColor: Colors.white, // Color de fondo del menú desplegable
        width: 250, // Ancho del menú desplegable
        child: ListView(
          children: <Widget>[
            // Encabezado del menú desplegable
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 2, 34, 59)),
              accountName: Text('Jean De Los Santos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              accountEmail: Text('jdelossantos@prm.do',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/logo_prm.jpg'), // Imagen de perfil
              ),
            ),
            // Elementos del menú desplegable
            ListTile(
              title: const Text('Inicio'), // Opción de Inicio
              leading: const Icon(Icons.home), // Icono de Inicio
              onTap: () {
                seleccionarVista(0, 'APP Móvil PRM'); // Navegar a la vista de Inicio
              },
            ),
            ListTile(
              title: const Text('Vivencias'), // Opción de Vivencias
              leading: const Icon(Icons.library_books), // Icono de Vivencias
              onTap: () {
                seleccionarVista(1, 'Vivencias Elecciones 2024'); // Navegar a la vista de Lista de Eventos
              },
            ),
            ListTile(
              title: const Text('Registrar Vivencia'), // Opción de Registrar Vivencia
              leading: const Icon(Icons.library_add), // Icono de Registrar Vivencia
              onTap: () {
                seleccionarVista(2, 'Agregar Nueva Vivencia'); // Navegar a la vista de Registro de Evento
              },
            ),
            ListTile(
              title: const Text('Acerca de'), // Opción de Acerca de
              leading: const Icon(Icons.badge), // Icono de Acerca de
              onTap: () {
                seleccionarVista(3, 'Información Delegado PRM'); // Navegar a la vista "Acerca de"
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text(widget.title), // Título de la aplicación
        backgroundColor: const Color.fromARGB(255, 2, 34, 59), // Color de fondo de la barra de navegación
        foregroundColor: Colors.white, // Color del texto en la barra de navegación
      ),

      body: obtenerVista(vistaActual), // Cuerpo de la aplicación con la vista actual
    );
  }
}
