import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/src/tx_dropdown_menu_item.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';

class TxDropdownMenuHeader extends StatefulWidget {
  final TxDropDownMenuController controller;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? dividerBuilder;
  final List<ListTitleFilter> items;
  final void Function(dynamic index) onScrollToIndex;
  final int? currentIndexSelected;

  const TxDropdownMenuHeader({
    super.key,
    required this.controller,
    this.itemBuilder,
    this.dividerBuilder,
    required this.items,
    required this.onScrollToIndex,
    this.currentIndexSelected,
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
    widget.controller.addListener(dropDownListener);
  }

  void dropDownListener() {
    if (expand != widget.controller.isExpand) {
      expand = widget.controller.isExpand;
    }
    if (mounted) setState(() {});
  }

  void handleTapItem(index) {
    final statusToggle = widget.controller.isExpand;
    widget.onScrollToIndex(index);

    if (!statusToggle) {
      widget.controller.show(index);
    }

    if (currentIndexExpand == index && statusToggle) {
      widget.controller.hide();
    }

    setState(() {
      currentIndexExpand = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: ColorData.colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 28,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return TxDropdownMenuHeaderItem(
                    title: widget.items[index].name,
                    onPressed: () {
                      handleTapItem(index);
                    },
                    listTitle: widget.items,
                    countFilter: widget.items[index].countFilter,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
