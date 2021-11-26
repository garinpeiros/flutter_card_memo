import '../model/dorama.dart';
import '../service/firestore_service.dart';

class DoramaDao {
  final dbProvider = FirestoreService();

  Future create(Dorama dorama) async {
    var result = dbProvider.createDorama(dorama);
    return result;
  }

  Future fetchFirsList() async {
    var result = dbProvider.fetchFirstDoramaList();
    return result;
  }

  Future fetchNextList() async {
    var result = dbProvider.fetchNextDoramaList();
    return result;
  }

  Future delete(String documentId) async {
    dbProvider.deleteDorama(documentId);
  }

  Future update(Dorama dorama) async {
    dbProvider.updateDorama(dorama);
  }
}
