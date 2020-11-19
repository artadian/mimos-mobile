import 'package:mimos/TF/Dao/materialdaotf.dart';

//import 'package:mimos/TF/Model/materialmodeltf.dart';
class MaterialRepositoryTF {
  final _materialDao = MaterialDaoTF();
  Future getAllMaterial({String query}) =>
      _materialDao.getSelectMaterialTF(query: query);
  Future getJumlahMaterial() => _materialDao.countDataMaterialTF();
}
