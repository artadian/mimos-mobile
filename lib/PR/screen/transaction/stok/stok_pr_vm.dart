import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StokPRVM with ChangeNotifier {
  final keyForm = GlobalKey<FormState>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  onRefresh() {
    print("onRefresh");
  }

}