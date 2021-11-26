import '../dao/dorama_dao.dart';
import '../model/dorama.dart';

class DoramaRepository {
  final dao = DoramaDao();
  Future insert(Dorama data) => dao.create(data);
  Future fetchFirst() => dao.fetchFirsList();
  Future fetchNext() => dao.fetchNextList();
  Future delete(String id) => dao.delete(id);
  Future update(Dorama data) => dao.update(data);
}
