import 'dart:async';
import 'package:mimos/TF/Dao/lookuprepository.dart';
import 'package:mimos/TF/Model/lookupmodel.dart';

class LookupBloc {
  final _lookupRepo = LookupRepository();
  final _lookupController =
      StreamController<List<LookupModel>>.broadcast();
  get lookup => _lookupController.stream;

  LookupBloc() {
    getLookup();
  }

  getLookup({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _lookupController.sink
        .add(await _lookupRepo.getAllLookup(query: query));
  }

  getJumlahDataLookup() async {
    _lookupRepo.getJumlahLookup();
    // getCustomerS();
  }

  dispose() {
    _lookupController.close();
  }
}
