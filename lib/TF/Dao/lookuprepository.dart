import 'package:mimos/TF/Dao/lookupdao.dart';
class LookupRepository {
  final _lookupDao = LookupDao();
  Future getAllLookup({String query}) =>
      _lookupDao.getSelectLookup(query: query);
  Future getJumlahLookup() => _lookupDao.countDataLookup();
}
