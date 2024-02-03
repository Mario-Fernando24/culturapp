import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> saveImageStorage(File file) async{
   FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("images/${DateTime.now().toIso8601String()}");

// Establecer los metadatos para el tipo de contenido
    SettableMetadata metadata = SettableMetadata(
      contentType:
          'image/jpeg', // Asegúrate de cambiar esto según el tipo de tu imagen (por ejemplo, 'image/png' para imágenes PNG)
    );

    await ref.putFile(file, metadata);
    final fileURL = await ref.getDownloadURL();

    return fileURL.toString();
}