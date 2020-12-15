import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisitPRVM with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  onRefresh() {
    print("onRefresh");
  }
}
