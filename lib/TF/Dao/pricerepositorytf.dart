import 'package:mimos/TF/Dao/pricedaotf.dart';

//import 'package:mimos/TF/Model/materialmodeltf.dart';
class PriceRepositoryTF {
  final _priceDao = PriceDaoTF();
  Future getAllPrice({String query}) =>
      _priceDao.getSelectPriceTF(query: query);
  Future getJumlahPrice() => _priceDao.countDataPriceTF();
}
