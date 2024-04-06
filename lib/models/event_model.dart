// Jean Luis De Los Santos Garabito (2022-0442)

import 'dart:convert';

class Evento {
  String titulo; // Título del evento
  String descripcion; // Descripción del evento
  DateTime fecha; // Fecha del evento
  String fotoPath; // Ruta de la foto asociada al evento
  String? audioPath; // Ruta opcional del audio asociado al evento

  Evento({
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.fotoPath,
    this.audioPath
  });

  // Constructor de fábrica para crear una instancia de Evento desde un mapa
  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      fecha: DateTime.parse(map['fecha']),
      fotoPath: map['fotoPath'],
      audioPath: map['audioPath'],
    );
  }

  // Método para convertir el objeto Evento en un mapa
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fecha': fecha.toIso8601String(),
      'fotoPath': fotoPath,
      'audioPath': audioPath,
    };
  }

  // Método para convertir el objeto Evento en formato JSON
  String toJson() => json.encode(toMap());

  // Constructor de fábrica para crear una instancia de Evento desde JSON
  factory Evento.fromJson(String source) => Evento.fromMap(json.decode(source));
}
