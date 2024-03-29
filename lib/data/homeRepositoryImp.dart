import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/categoria_models.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/models/evento_models.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/models/usuario.dart';
import 'package:culturappco/domain/repositories/homeRespository.dart';
import 'package:culturappco/utils/constants/constant_string.dart';
import 'package:culturappco/utils/function/preference.dart';
import 'package:culturappco/utils/function/saveImage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class HomeRespositoryImpl implements HomeRespository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  @override
  Future<Users> getProfile(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('Usuario').doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        final users = Users.fromJson(data);
        return users;
      } else {
        throw Exception('Perfil de usuario no encontrado.');
      }
    } catch (e) {
      // Manejar el error adecuadamente
      throw Exception('Error al obtener el perfil del usuario: $e');
    }
  }

  @override
  Future<bool> updateProfile(Users users) async {
    try {
      DocumentReference userReference =
          firestore.collection('Usuario').doc(users.uid);

      Map<String, dynamic> userData = {
        'username': users.username,
        'lastname': users.lastname,
        'telefono': users.telefono
      };

      await userReference.update(userData);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> saveEvento(Evento evento, File file) async {
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
    String uid = _uuid.v4();

    evento.imagen = fileURL;
    evento.estado = true;
    evento.uidEvento = uid;
    evento.uidUsers = UserPreferences.getPreference(usersUid);

    try {
      //var docRef =
      await firestore.collection('eventos').doc(uid).set(evento.toJson());
      // ignore: unnecessary_null_comparison
      //if (docRef != null) {
      return true;
      // } else {
      //   return false;
      // }
    } catch (error) {
      return false;
    }
  }

  @override
  Future<List<Evento>> getEvents(String search) async {
    print("object");
    print(search);
    print("object");
    List<Evento> eventModelo = [];

    try {
      QuerySnapshot querySnapshot = await firestore.collection('eventos').get();

      if (search == '') {
        eventModelo = querySnapshot.docs.map((doc) {
          return Evento.fromDocumentSnapshot(doc);
        }).toList();
      }
      if (search != '') {
        eventModelo = querySnapshot.docs
            .map((doc) => Evento.fromDocumentSnapshot(doc))
            .where((evento) => evento.tituloEvento
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }

      // Obtener la fecha actual y remover la hora, minutos y segundos para la comparación.
      /*
DateTime hoy = DateTime.now();
DateTime fechaHoy = DateTime(hoy.year, hoy.month, hoy.day);

List<Evento> eventModelo = querySnapshot.docs.map((doc) {
    return Evento.fromDocumentSnapshot(doc);
}).where((evento) {
    // Convertir la fecha del evento a medianoche para la comparación.
    DateTime fechaEvento = DateTime(evento.fechaEvento.year, evento.fechaEvento.month, evento.fechaEvento.day);
    return fechaEvento.compareTo(fechaHoy) >= 0;
}).toList();

// Ordenar la lista de eventos futuros por fechaEvento
eventModelo.sort((a, b) => a.fechaEvento.compareTo(b.fechaEvento));

*/

      eventModelo.sort((a, b) => DateTime.parse(a.fechaEvento)
          .compareTo(DateTime.parse(b.fechaEvento)));

      return eventModelo;
    } catch (e) {
      print('Error al obtener las products: $e');
      return eventModelo;
    }
  }

  @override
  Future<bool> updateEstadoEvents(String uidEvento, bool estado) async {
    try {
      bool estadoAux = false;
      if (estado) {
        estadoAux = false;
      } else {
        estadoAux = true;
      }
      firestore
          .collection('eventos')
          .doc(uidEvento)
          .update({'estado': estadoAux});

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CategoriaEvento>> getCategoria() async {
    List<CategoriaEvento> categoriaModelo = [];

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('Categoria').get();

      categoriaModelo = querySnapshot.docs.map((doc) {
        return CategoriaEvento.fromDocumentSnapshot(doc);
      }).toList();

      return categoriaModelo;
    } catch (e) {
      print('Error al obtener las products: $e');
      return categoriaModelo;
    }
  }

  @override
  Future<bool> saveOfertaCultural(
      OfertaCultural ofertaCultural, File file, File file2, File file3) async {
    String imgageuno = await saveImageStorage(file);
    String imagedos = await saveImageStorage(file2);
    String imagetres = await saveImageStorage(file3);

    String uid = _uuid.v4();
    ofertaCultural.uid = uid;
    ofertaCultural.image1 = imgageuno;
    ofertaCultural.image2 = imagedos;
    ofertaCultural.image3 = imagetres;

    try {
      await firestore
          .collection('OfertaCultural')
          .doc(uid)
          .set(ofertaCultural.toJson());
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> saveCategoryEvents(CategoriaEvento categoriaEvento) async {
    try {
      await firestore.collection('Categoria').add(categoriaEvento.toJson());

      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Future<bool> saveDirectorioArtista(DirectorioArtista ofertaCultural,
      File file, File file2, File file3) async {
    String imgageuno = await saveImageStorage(file);
    String imagedos = await saveImageStorage(file2);
    String imagetres = await saveImageStorage(file3);

    String uid = _uuid.v4();
    ofertaCultural.uid = uid;
    ofertaCultural.image1 = imgageuno;
    ofertaCultural.image2 = imagedos;
    ofertaCultural.image3 = imagetres;

    try {
      await firestore
          .collection('DirectoriArtista')
          .doc(uid)
          .set(ofertaCultural.toJson());

      print("TRUEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
      return true;
    } catch (error) {
      print("FALSEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
      return false;
    }
  }

  @override
  Future<List<DirectorioArtista>> getDirectorioArtista() async {
    List<DirectorioArtista> categoriaModelo = [];

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('DirectoriArtista').get();

      categoriaModelo = querySnapshot.docs.map((doc) {
        return DirectorioArtista.fromDocumentSnapshot(doc);
      }).toList();

      return categoriaModelo;
    } catch (e) {
      print('Error al obtener las products: $e');
      return categoriaModelo;
    }
  }

  @override
  Future<List<OfertaCultural>> getOfertaCultural() async {
    List<OfertaCultural> ofertaCultural = [];

    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('OfertaCultural').get();

      ofertaCultural = querySnapshot.docs.map((doc) {
        return OfertaCultural.fromDocumentSnapshot(doc);
      }).toList();

      return ofertaCultural;
    } catch (e) {
      print('Error al obtener las products: $e');
      return ofertaCultural;
    }
  }

  Future<List<String>> numeroEventos() async {
    final directorio =
        FirebaseFirestore.instance.collection('DirectoriArtista');
    final snapshotdirectorio = await directorio.get();

    final ofertaCultural =
        FirebaseFirestore.instance.collection('OfertaCultural');
    final snapshotofertaCultural = await ofertaCultural.get();

    final agenda = FirebaseFirestore.instance.collection('eventos');
    final agendaCultural = await agenda.get();

    return [
      snapshotdirectorio.docs.length.toString(),
      snapshotofertaCultural.docs.length.toString(),
      agendaCultural.docs.length.toString()
    ];
  }

  
}
