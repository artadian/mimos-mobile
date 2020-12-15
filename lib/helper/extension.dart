import 'package:intl/intl.dart';

var money = NumberFormat("###,###,###", "en_us");
var dateFormat = DateFormat("yyyy-MM-dd");
var dateTimeFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
var dateViewFormat = DateFormat("dd MMMM yyyy");
var dateTimeViewFormat = DateFormat("dd MMMM yyyy hh:mm:ss");

extension StringExtension on String {
  int toInt() {
    if (this != null && this != "null") {
      return int.parse(this);
    } else {
      return null;
    }
  }

  double toDouble() {
    if (this != null && this != "null") {
      return double.parse(this);
    } else {
      return null;
    }
  }

  bool toBool() {
    if (this != null && this != "null") {
      return this == "0" ? false : true;
    } else {
      return false;
    }
  }

  int boolToInt() {
    if (this != null && this != "null") {
      return 1;
    } else {
      return 0;
    }
  }

  String clean() =>
      (this != null && this != "null" && this != "") ? this : null;

  String toNull() => (this != null &&
          this != "null" &&
          this != "" &&
          this != " " &&
          this != "0" &&
          this.length >= 0)
      ? this
      : null;

  bool isNull() => (this != null &&
          this != "null" &&
          this != "" &&
          this != " " &&
          this != "0" &&
          this.length >= 0)
      ? false
      : true;

  String cleanStr() => (this != null && this != "null") ? this : "";

  String dateStore() {
    if (this != null && this != "null" && this != "") {
      try {
        var date = dateViewFormat.parse(this);
        return dateFormat.format(date);
      } catch (e) {
        print(e);
        return this;
      }
    }
    {
      return null;
    }
  }

  String dateView() {
    if (this != null && this != "null" && this != "") {
      try {
        var date = dateFormat.parse(this);
        return dateViewFormat.format(date);
      } catch (e) {
        print(e);
        return this;
      }
    }
    {
      return null;
    }
  }

  String dateTimeView() {
    if (this != null && this != "null" && this != "") {
      try {
        var date = dateTimeFormat.parse(this);
        return dateTimeViewFormat.format(date);
      } catch (e) {
        print(e);
        return this;
      }
    }
    {
      return null;
    }
  }

  String clearMoney() => (this != null && this != "null" && this != "")
      ? this.replaceAll(",", "")
      : null;

  int clearMoneyInt() {
    if (this != null && this != "null" && this != "") {
      try {
        return int.parse(this.replaceAll(",", ""));
      } catch (e) {
        print(e);
        return 0;
      }
    } else {
      return 0;
    }
  }

  String toMoney() {
    if (this != null && this != "null") {
      try {
        return money.format(this.toDouble());
      } catch (e) {
        print(e);
        return this;
      }
    } else {
      return null;
    }
  }

  bool ynToBool() {
    if (this != null && this != "null") {
      return (this.toUpperCase() == "N") ? false : true;
    } else {
      return false;
    }
  }

  String boolToYN() {
    if (this != null && this != "null") {
      return (this == "true") ? "Y" : "N";
    } else {
      return "N";
    }
  }
}

extension BoolExtension on bool {
  String boolToYN() {
    if (this != null) {
      return (this) ? "Y" : "N";
    } else {
      return "N";
    }
  }
}

extension DateTimeExtension on DateTime {
  DateTime dateOnly() {
    if (this != null) {
      return DateTime.parse(dateFormat.format(this));
    } else {
      return null;
    }
  }
}

extension ListExtension on List<int> {
  String toValue() {
    if (this != null && this.isNotEmpty) {
      return this.toString().replaceAll("[", "(").replaceAll("]", ")");
      ;
    } else {
      return null;
    }
  }

  String toStr() {
    if (this != null && this.isNotEmpty) {
      return this.toString().replaceAll("[", "").replaceAll("]", "");
      ;
    } else {
      return null;
    }
  }
}
