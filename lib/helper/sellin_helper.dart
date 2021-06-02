import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/model/sellin_detail.dart';

class QtyPrice {
  double qty;
  double price;

  QtyPrice({
    this.qty,
    this.price,
  });
}

class SellinHelper {
  static Future<QtyPrice> getTotalQtyAndPrice(SellinDetail sellinDetail) async {
    var _materialPriceDao = MaterialPriceDao();

    var material = await _materialPriceDao
        .getByMaterialId(sellinDetail.materialid);

    var bal = (sellinDetail.bal ?? 0.0) * (material.bal / material.pac);
    var slof = (sellinDetail.slof ?? 0.0) * (material.slof / material.pac);
    var pac = (sellinDetail.pac ?? 0.0);

    var price = material.price;
    var qty = bal + slof + pac;
//    sellinDetail.price = price;
//    sellinDetail.qty = qty;
//    sellinDetail.sellinvalue = qty * price;
    return QtyPrice(qty: qty, price: qty * price);
  }
}
