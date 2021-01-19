import 'package:mimos/PR/dao/brand_competitor_dao.dart';
import 'package:mimos/PR/dao/customer_introdeal_dao.dart';
import 'package:mimos/PR/dao/customer_pr_dao.dart';
import 'package:mimos/PR/dao/introdeal_dao.dart';
import 'package:mimos/PR/dao/lookup_dao.dart';
import 'package:mimos/PR/dao/material_price_dao.dart';
import 'package:mimos/PR/dao/posm_dao.dart';
import 'package:mimos/PR/dao/posm_detail_dao.dart';
import 'package:mimos/PR/dao/sellin_dao.dart';
import 'package:mimos/PR/dao/sellin_detail_dao.dart';
import 'package:mimos/PR/dao/stock_dao.dart';
import 'package:mimos/PR/dao/stock_detail_dao.dart';
import 'package:mimos/PR/dao/trial_dao.dart';
import 'package:mimos/PR/dao/visibility_dao.dart';
import 'package:mimos/PR/dao/visibility_detail_dao.dart';
import 'package:mimos/PR/dao/visit_dao.dart';

class DbDao {
  var lookupDao = LookupDao();
  var introdealDao = IntrodealDao();
  var brandCompetitorPRDao = BrandCompetitorDao();
  var materialPriceDao = MaterialPriceDao();
  var customerPRDao = CustomerPRDao();
  // Transaction
  var visitDao = VisitDao();
  var stockDao = StockDao();
  var sellinDao = SellinDao();
  var posmDao = PosmDao();
  var visibilityDao = VisibilityDao();
  var stockDetailDao = StockDetailDao();
  var sellinDetailDao = SellinDetailDao();
  var posmDetailDao = PosmDetailDao();
  var visibilityDetailDao = VisibilityDetailDao();
  var trialDao = TrialDao();
  var customerIntrodealDao = CustomerIntrodealDao();

  Future<bool> needSyncSellin() async {
    var res = await Future.wait([
      sellinDao.countNeedSync(),
      sellinDetailDao.countNeedSync(),
    ]);

    if (res.reduce((a, b) => a + b) > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> needSyncStock() async {
    var res = await Future.wait([
      stockDao.countNeedSync(),
      stockDetailDao.countNeedSync(),
    ]);

    if (res.reduce((a, b) => a + b) > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> needSyncVisibility() async {
    var res = await Future.wait([
      visibilityDao.countNeedSync(),
      visibilityDetailDao.countNeedSync(),
    ]);

    if (res.reduce((a, b) => a + b) > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> needSyncPosm() async {
    var res = await Future.wait([
      posmDao.countNeedSync(),
      posmDetailDao.countNeedSync(),
    ]);

    if (res.reduce((a, b) => a + b) > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> needSyncTransaction() async {
    var res = await Future.wait([
      visitDao.countNeedSync(),
      sellinDao.countNeedSync(),
      sellinDetailDao.countNeedSync(),
      stockDao.countNeedSync(),
      stockDetailDao.countNeedSync(),
      visibilityDao.countNeedSync(),
      visibilityDetailDao.countNeedSync(),
      posmDao.countNeedSync(),
      posmDetailDao.countNeedSync(),
      customerIntrodealDao.countNeedSync(),
    ]);

    if (res.reduce((a, b) => a + b) > 0) {
      return true;
    } else {
      return false;
    }
  }

  truncateAll({bool all = true}) async {
    await lookupDao.truncate();
    await introdealDao.truncate();
    await brandCompetitorPRDao.truncate();
    await materialPriceDao.truncate();
    await customerPRDao.truncate();
    // Transaction
    await (all ? visitDao.truncate() : visitDao.truncateSync());
    await (all ? stockDao.truncate() : stockDao.truncateSync());
    await (all ? sellinDao.truncate() : sellinDao.truncateSync());
    await (all ? posmDao.truncate() : posmDao.truncateSync());
    await (all ? visibilityDao.truncate() : visibilityDao.truncateSync());
    await (all ? stockDetailDao.truncate() : stockDetailDao.truncateSync());
    await (all ? sellinDetailDao.truncate() : sellinDetailDao.truncateSync());
    await (all ? posmDetailDao.truncate() : posmDetailDao.truncateSync());
    await (all ? visibilityDetailDao.truncate() : visibilityDetailDao.truncateSync());
    await (all ? trialDao.truncate() : trialDao.truncateSync());
    await (all ? customerIntrodealDao.truncate() : customerIntrodealDao.truncateSync());
  }

  truncateAllTransaction({bool all = true}) async {
    await customerPRDao.truncate();
    await (all ? visitDao.truncate() : visitDao.truncateSync());
    await (all ? stockDao.truncate() : stockDao.truncateSync());
    await (all ? sellinDao.truncate() : sellinDao.truncateSync());
    await (all ? posmDao.truncate() : posmDao.truncateSync());
    await (all ? visibilityDao.truncate() : visibilityDao.truncateSync());
    await (all ? stockDetailDao.truncate() : stockDetailDao.truncateSync());
    await (all ? sellinDetailDao.truncate() : sellinDetailDao.truncateSync());
    await (all ? posmDetailDao.truncate() : posmDetailDao.truncateSync());
    await (all ? visibilityDetailDao.truncate() : visibilityDetailDao.truncateSync());
    await (all ? trialDao.truncate() : trialDao.truncateSync());
    await (all ? customerIntrodealDao.truncate() : customerIntrodealDao.truncateSync());
  }
}
