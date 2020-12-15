import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DisplayPRVM with ChangeNotifier {
  final keyForm = GlobalKey<FormState>();
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  onRefresh() {
    print("onRefresh");
  }

}