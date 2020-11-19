import 'dart:async';
import 'package:mimos/TF/Dao/introdealrepositorytf.dart';
import 'package:mimos/TF/Model/introdealmodeltf.dart';

class IntrodealBlocTF {
  final _introdealRepo = IntrodealRepositoryTF();
  final _introdealTFController =
      StreamController<List<IntrodealModelTF>>.broadcast();
  get introdealTF => _introdealTFController.stream;

  IntrodealBlocTF() {
    getIntrodealTF();
  }
  getIntrodealTF({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _introdealTFController.sink
        .add(await _introdealRepo.getAllIntrodeal(query: query));
  }

  getJumlahDataIntrodealTF() async {
    _introdealRepo.getJumlahIntrodeal();
    // getCustomerS();
  }

  dispose() {
    _introdealTFController.close();
  }
}
