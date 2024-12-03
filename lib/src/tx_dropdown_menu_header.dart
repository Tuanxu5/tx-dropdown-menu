import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/src/tx_dropdown_menu_item.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';

class TxDropdownMenuHeader extends StatefulWidget {
  final List<TxDropDownMenuItem> items;
  final void Function(dynamic index) onScrollToIndex;
  final TxDropDownMenuController dropDownController;
  final Color colorPrimary;

  const TxDropdownMenuHeader({
    super.key,
    required this.items,
    required this.onScrollToIndex,
    required this.dropDownController,
    required this.colorPrimary,
  });

  @override
  State<TxDropdownMenuHeader> createState() => _TxDropdownMenuHeaderState();
}

class _TxDropdownMenuHeaderState extends State<TxDropdownMenuHeader> {
  bool expand = false;
  int currentIndexExpand = 0;

  @override
  void initState() {
    super.initState();
    widget.dropDownController.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (expand != widget.dropDownController.isExpand) {
      expand = widget.dropDownController.isExpand;
    }
  }

  void handleTapItem(index) {
    final statusToggle = widget.dropDownController.isExpand;
    widget.onScrollToIndex(index);
    if (!statusToggle) {
      widget.dropDownController.show(index);
    }

    if (currentIndexExpand == index && statusToggle) {
      widget.dropDownController.hide();
    }

    setState(() {
      currentIndexExpand = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      decoration: const BoxDecoration(
        color: ColorData.colorWhite,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index) {
          return TxDropdownMenuHeaderItem(
            title: widget.items[index].title,
            onPressed: () {
              handleTapItem(index);
            },
            countFilter: widget.items[index].countFilter,
            colorPrimary: widget.colorPrimary,
          );
        },
      ),
    );
  }
}
