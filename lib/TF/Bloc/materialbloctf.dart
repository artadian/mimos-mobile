import 'dart:async';
import 'package:mimos/TF/Dao/materialrepositorytf.dart';
import 'package:mimos/TF/Model/materialmodeltf.dart';

class MaterialBlocTF {
  final _materialRepo = MaterialRepositoryTF();
  final _materialTFController =
      StreamController<List<MaterialModelTF>>.broadcast();
  get materialTF => _materialTFController.stream;

  MaterialBlocTF() {
    getMaterialTF();
  }
  getMaterialTF({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _materialTFController.sink
        .add(await _materialRepo.getAllMaterial(query: query));
  }

  getJumlahDataMaterialTF() async {
    _materialRepo.getJumlahMaterial();
    // getCustomerS();
  }

  dispose() {
    _materialTFController.close();
  }
}
