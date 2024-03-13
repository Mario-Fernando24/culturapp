
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/directorio_artista.dart';
import 'package:culturappco/domain/repositories/directoryArtistaRepositoty.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DirectoriArtistaRepositoryImp implements DirectoryArtistaRepository {
  
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<DirectorioArtista>> getDirectorioArtista(String search, String parametro) async {

    List<DirectorioArtista> directoryModelo = [];

    try {
      //QuerySnapshot querySnapshot = await firestore.collection('DirectoriArtista')
     // .where('categoria', isEqualTo: parametro).get();

        QuerySnapshot querySnapshot = await firestore.collection('DirectoriArtista').get();

      if (search == '') {
        directoryModelo = querySnapshot.docs.map((doc) {
          return DirectorioArtista.fromDocumentSnapshot(doc);
        }).toList();
      }
      if (search != '') {
        directoryModelo = querySnapshot.docs
            .map((doc) => DirectorioArtista.fromDocumentSnapshot(doc))
            .where((evento) => evento.name!
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }

      return directoryModelo;

    } catch (e) {
      print('Error al obtener las products: $e');
      return directoryModelo;
    }

  }


  @override
  Future<String> getCurrentUserUid() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
    } else {
      return "null";
    }
  }

  }