import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';

typedef OnDropDownHeaderItemTap = void Function(int index);
typedef OnDropDownHeaderUpdate = TxDropDownMenuHeaderStatus? Function(List<TxDropDownMenuItem> checkedItems);
typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index, bool check);
typedef OnDropDownItemLimitExceeded = void Function(List<Widget> items);
typedef OnDropDownItemTap = void Function(int index, Widget item);
typedef OnDropDownItemChanged = void Function(int index);
typedef OnDropDownBlockItemChanged = void Function(int blockIndex, int index, List<Widget> items);
typedef OnDropDownItemsReset = void Function(List<Widget> items);
typedef OnDropDownItemsConfirm = void Function(List<Widget> checkedItems);
typedef OnDropDownExpandStateChanged = void Function(bool expand);

abstract class DropDownViewProperty extends Widget {
  const DropDownViewProperty({super.key});

  double get actualHeight;
}

abstract class DropDownViewStatefulWidget extends StatefulWidget implements DropDownViewProperty {
  const DropDownViewStatefulWidget({Key? key}) : super(key: key);
}

abstract class DropDownViewStatelessWidget extends StatelessWidget implements DropDownViewProperty {
  const DropDownViewStatelessWidget({super.key});
}
