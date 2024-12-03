import 'package:flutter/foundation.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';

class TxDropDownMenuController extends ChangeNotifier {
  bool isExpand = false;
  int headerIndex = 0;
  List<TxDropDownMenuHeaderStatus> headerStatus = [];
  double viewOffsetY = -1;

  void show(int index, {double? offsetY}) {
    isExpand = true;
    headerIndex = index;
    viewOffsetY = offsetY ?? -1;
    notifyListeners();
  }

  void hide({int? index, TxDropDownMenuHeaderStatus? status}) {
    if (index != null && status != null) {
      headerStatus[index] = status;
    }
    isExpand = false;
    notifyListeners();
  }

  void toggle(int index, {double? offsetY, TxDropDownMenuHeaderStatus? status}) {
    if (isExpand && headerIndex == index) {
      hide(index: index, status: status);
    } else {
      show(index, offsetY: offsetY);
    }
  }
}

