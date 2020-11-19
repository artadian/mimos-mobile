import 'package:mimos/TF/Dao/introdealdaotf.dart';

//import 'package:mimos/TF/Model/materialmodeltf.dart';
class IntrodealRepositoryTF {
  final _introdealDao = IntrodealDaoTF();
  Future getAllIntrodeal({String query}) =>
      _introdealDao.getSelectIntrodealTF(query: query);
  Future getJumlahIntrodeal() => _introdealDao.countDataIntrodealTF();
}
