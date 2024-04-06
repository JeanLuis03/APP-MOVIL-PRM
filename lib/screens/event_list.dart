// Jean Luis De Los Santos Garabito (2022-0442)

// Clase ListaEventos: Representa la pantalla de lista de eventos.

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tarea_8/models/event_model.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'event_details.dart';

class ListaEventos extends StatefulWidget {
  const ListaEventos({super.key});

  @override
  _ListaEventosState createState() => _ListaEventosState();
}

class _ListaEventosState extends State<ListaEventos> {
  List<Evento> _eventos = []; // Lista de eventos

  @override
  void initState() {
    super.initState();
    _cargarEventos(); // Cargar eventos al inicializar la pantalla
  }

  Future<void> _cargarEventos() async {
    final prefs = await SharedPreferences.getInstance();
    final eventosString = prefs.getStringList('eventos') ?? [];
    final List<Evento> eventos =
        eventosString.map((e) => Evento.fromJson(e)).toList(); // Convertir la lista de cadenas a objetos Evento
    setState(() {
      _eventos = eventos; // Actualizar la lista de eventos
    });
  }

  void mostrarDetallesEvento(Evento evento) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetallesEvento(evento: evento))); // Mostrar detalles del evento
  }

  Future<void> _eliminarTodosLosEventos() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('eventos'); // Eliminar todos los eventos guardados
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _eventos.isEmpty // Verificar si no hay eventos
          ? const Center(
              child: Text(
                'No hay vivencias registradas',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: _eventos.length,
              itemBuilder: (BuildContext context, int index) {
                final evento = _eventos[index];
                return ListTile(
                  title: Text(evento.titulo), // Título del evento
                  subtitle: Text(
                      'Fecha Vivencia: ${evento.fecha.day}/${evento.fecha.month}/${evento.fecha.year}'), // Fecha del evento
                  leading: CircleAvatar( // Imagen del evento
                    radius: 30,
                    backgroundImage: FileImage(File(evento.fotoPath)),
                  ),
                  onTap: () {
                    mostrarDetallesEvento(evento); // Mostrar detalles del evento al hacer clic
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton( // Botón flotante para eliminar todos los eventos
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Borrado de Emergencia",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 2, 34, 59)),
                  textAlign: TextAlign.center,
                ),
                content: const Text(
                  "¿Estás seguro de que deseas borrar todas las vivencias?",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cerrar el diálogo
                      _eliminarTodosLosEventos(); // Eliminar todos los eventos
                      _cargarEventos(); // Volver a cargar la lista de eventos
                    },
                    child: const Text("Sí", style: TextStyle(fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cerrar el diálogo
                    },
                    child: const Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.delete,
          size: 30,
          color: Color.fromARGB(255, 2, 34, 59),
        ),
      ),
    );
  }
}
