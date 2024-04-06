// Jean Luis De Los Santos Garabito (2022-0442)

// Clase DetallesEvento: Representa la pantalla de detalles de un evento.

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tarea_8/models/event_model.dart';
import 'package:just_audio/just_audio.dart';

class DetallesEvento extends StatefulWidget {
  final Evento evento; // Evento para mostrar detalles

  const DetallesEvento({Key? key, required this.evento}) : super(key: key);

  @override
  _DetallesEventoState createState() => _DetallesEventoState();
}

class _DetallesEventoState extends State<DetallesEvento> {
  late AudioPlayer _player; // Reproductor de audio

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer(); // Inicialización del reproductor de audio
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _player.setFilePath(widget.evento.audioPath!); // Configuración del archivo de audio
  }

  @override
  void dispose() {
    _player.dispose(); // Liberar recursos del reproductor de audio
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Vivencia'), // Título de la AppBar
        backgroundColor: const Color.fromARGB(255, 2, 34, 59), // Color de fondo de la AppBar
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Espacio vacío
              Center(
                child: Image.file(File(widget.evento.fotoPath), // Imagen del evento
                    width: 400, height: 300),
              ),
              const SizedBox(height: 20), // Espacio vacío
              Text( // Título del evento
                widget.evento.titulo,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 2, 34, 59)),
              ),
              const SizedBox(height: 16), // Espacio vacío
              Text( // Fecha del evento
                'Fecha: ${widget.evento.fecha.day}/${widget.evento.fecha.month}/${widget.evento.fecha.year}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20), // Espacio vacío
              Text( // Descripción del evento
                '${widget.evento.descripcion}.',
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20), // Espacio vacío
              const Center(
                child: Text(
                  'Reproducir Audio Debajo',
                  style: TextStyle(
                      color: Color.fromARGB(255, 2, 34, 59),
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              if (widget.evento.audioPath != null) ...[
                Center(
                  child: StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return const CircularProgressIndicator(); // Indicador de carga
                      } else if (playing != true) {
                        return IconButton( // Botón de reproducción
                          icon: const Icon(Icons.play_arrow),
                          color: const Color.fromARGB(255, 2, 34, 59),
                          iconSize: 64,
                          onPressed: () => _player.play(),
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return IconButton( // Botón de pausa
                          icon: const Icon(Icons.pause),
                          color: const Color.fromARGB(255, 2, 34, 59),
                          iconSize: 64,
                          onPressed: () => _player.pause(),
                        );
                      } else {
                        return IconButton( // Botón de reinicio
                          icon: const Icon(Icons.replay),
                          color: const Color.fromARGB(255, 2, 34, 59),
                          iconSize: 64,
                          onPressed: () => _player.seek(Duration.zero),
                        );
                      }
                    },
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
