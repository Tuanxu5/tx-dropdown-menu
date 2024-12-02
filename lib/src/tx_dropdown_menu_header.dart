import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/src/button_filter.dart';

class TxDropdownMenuHeader extends StatefulWidget {
  final TxDropDownMenuController controller;
  final NullableIndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? dividerBuilder;
  final List<ListTitleFilter> listTitle;
  final void Function(dynamic index) onScrollToIndex;
  final int? currentIndexSelected;

  const TxDropdownMenuHeader({
    super.key,
    required this.controller,
    this.itemBuilder,
    this.dividerBuilder,
    required this.listTitle,
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

    if (index == -1) {
      widget.controller.toggle(index);
    } else {
      if (!statusToggle) {
        widget.controller.show(index);
      }

      if (currentIndexExpand == -1 && statusToggle) {
        widget.controller.show(index);
      }

      if (currentIndexExpand == index && statusToggle) {
        widget.controller.hide();
      }

      if (index == 0 && statusToggle) {
        widget.controller.hide();
      }
    }

    setState(() {
      currentIndexExpand = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int countFilterActive = widget.listTitle.where((element) => element.status == true).length;

    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              handleTapItem(0);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 28,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  child: Text("Icon"),
                ),
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue,
                    ),
                    alignment: Alignment.center,
                    width: 18,
                    height: 18,
                    child: Text(
                      countFilterActive.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 1.5,
            height: 24,
            color: Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: SizedBox(
              height: 28,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.listTitle.length,
                itemBuilder: (BuildContext context, int index) {
                  return ButtonFilter(
                    title: widget.listTitle[index].name,
                    status: widget.listTitle[index].status,
                    onPressed: () {
                      handleTapItem(index);
                    },
                    listTitle: widget.listTitle,
                    countFilter: widget.listTitle[index].countFilter,
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
