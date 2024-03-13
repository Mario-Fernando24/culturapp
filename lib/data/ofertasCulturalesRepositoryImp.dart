
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culturappco/domain/models/oferta_cultural_model.dart';
import 'package:culturappco/domain/repositories/ofertasCulturalesRepository.dart';
import 'package:uuid/uuid.dart';

class OfertasCulturalesRepositoryImp implements OfertasCulturalesRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  @override
  Future<List<OfertaCultural>> getOfertaCultural(String search) async {

     print("object");
    print(search);
    print("object");
    List<OfertaCultural> ofertaCultural = [];

    try {
      QuerySnapshot querySnapshot = await firestore.collection('OfertaCultural').get();

      if (search == '') {
        ofertaCultural = querySnapshot.docs.map((doc) {
          return OfertaCultural.fromDocumentSnapshot(doc);
        }).toList();
      }
      if (search != '') {
        ofertaCultural = querySnapshot.docs
            .map((doc) => OfertaCultural.fromDocumentSnapshot(doc))
            .where((evento) => evento.titleOfertaCultural!
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      }

      ofertaCultural.sort((a, b) => DateTime.parse(a.fecha!)
          .compareTo(DateTime.parse(b.fecha!)));

      return ofertaCultural;
    } catch (e) {
      print('Error al obtener las products: $e');
      return ofertaCultural;
    }

  }



  }