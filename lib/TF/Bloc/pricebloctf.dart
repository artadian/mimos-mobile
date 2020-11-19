import 'dart:async';
import 'package:mimos/TF/Dao/pricerepositorytf.dart';
import 'package:mimos/TF/Model/pricemodeltf.dart';

class PriceBlocTF {
  final _priceRepo = PriceRepositoryTF();
  final _priceTFController =
      StreamController<List<PriceModelTF>>.broadcast();
  get priceTF => _priceTFController.stream;

  PriceBlocTF() {
    getPriceTF();
  }
  getPriceTF({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _priceTFController.sink
        .add(await _priceRepo.getAllPrice(query: query));
  }

  getJumlahDataPriceTF() async {
    _priceRepo.getJumlahPrice();
    // getCustomerS();
  }

  dispose() {
    _priceTFController.close();
  }
}
