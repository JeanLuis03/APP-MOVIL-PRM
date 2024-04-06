//Jean Luis De Los Santos Garabito (2022-0442)

// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarea_8/models/event_model.dart';
import 'dart:io';
import 'package:tarea_8/screens/my_views.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as o_path;

class RegistrarEvento extends StatefulWidget {
  const RegistrarEvento({super.key});

  @override
  _RegistrarEventoState createState() => _RegistrarEventoState();
}

class _RegistrarEventoState extends State<RegistrarEvento> {
  // Definición de variables y métodos para la selección de imágenes y audio.

  final _picker = ImagePicker(); // Selector de imágenes
  File? _imageFile; // Archivo de imagen seleccionado
  File? _audioFile; // Archivo de audio seleccionado
  final TextEditingController _tituloController =
      TextEditingController(); // Controlador para el campo de título
  final TextEditingController _descripcionController =
      TextEditingController(); // Controlador para el campo de descripción

// Método para obtener una imagen desde la galería
  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery); // Obtener imagen desde la galería
    if (pickedFile != null) {
      setState(() {
        _imageFile =
            File(pickedFile.path); // Actualizar archivo de imagen seleccionado
      });
    }
  }

// Método para obtener un archivo de audio desde la galería
  Future<void> _getAudioFromGallery() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio); // Obtener audio desde la galería
    if (result != null) {
      setState(() {
        _audioFile = File(result
            .files.single.path!); // Actualizar archivo de audio seleccionado
      });
    }
  }

  // Método para guardar un evento registrado.
  Future<void> _guardarEvento() async {
    // Obtener el título y la descripción del evento
    final String titulo = _tituloController.text.trim();
    final String descripcion = _descripcionController.text.trim();

    // Obtener el directorio de la aplicación para guardar archivos
    final appDir = await getApplicationDocumentsDirectory();

    // Generar nombres de archivo únicos para la imagen y el audio
    final imageFileName = '${DateTime.now()}.png';
    final audioFileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';

    // Guardar la imagen y el audio en el directorio de la aplicación
    final savedImage = await _imageFile!.copy('${appDir.path}/$imageFileName');
    final savedAudio = await _audioFile!.copy('${appDir.path}/$audioFileName');

    // Crear un nuevo objeto Evento con los datos proporcionados
    final evento = Evento(
      titulo: titulo,
      descripcion: descripcion,
      fecha: DateTime.now(),
      fotoPath: savedImage.path,
      audioPath: savedAudio.path,
    );

    // Obtener SharedPreferences para guardar el evento en la lista de eventos
    final prefs = await SharedPreferences.getInstance();
    final eventoString = prefs.getStringList('eventos') ?? [];
    eventoString.add(evento.toJson()); // Agregar evento a la lista de eventos
    prefs.setStringList('eventos',
        eventoString); // Guardar lista de eventos en SharedPreferences

    // Cerrar la vista de registro de evento
    Navigator.of(context).pop();

    // Mostrar mensaje de confirmación de registro exitoso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 2, 34, 59),
        content: Text(
          'Registro exitoso',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
      ),
    );

    // Navegar a la lista de eventos después del registro
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MisVistas(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _getImageFromGallery,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : const Icon(Icons.add_photo_alternate_outlined,
                            size: 50, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _getAudioFromGallery,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: _audioFile != null
                        ? const Color.fromARGB(255, 2, 34, 59)
                        : Colors.grey[200],
                    child: _audioFile != null
                        ? Center(
                            child: Text(
                            o_path.basename(_audioFile!.path),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                            textAlign: TextAlign.center,
                          ))
                        : const Center(
                            child: Text(
                              'Seleccionar Audio',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                      labelText: 'Título de la Vivencia',
                      labelStyle: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(
                      labelText: 'Descripción de la Vivencia',
                      labelStyle: TextStyle(fontSize: 18)),
                  maxLines: null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _guardarEvento,
                  child: const Text(
                    'Guardar Vivencia',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
