import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';

class ProductFiltersNormal extends StatefulWidget {
  final double heightScreen;
  final AutoScrollController controllerTitle;
  final List<ListTitleFilter> listTitle;
  final void Function(dynamic index) onScrollToIndex;
  final int? currentIndexSelected;
  final AutoScrollController controller;
  final TxDropDownMenuController dropDownController;
  final void Function() onShowLoading;

  const ProductFiltersNormal({
    super.key,
    required this.heightScreen,
    required this.controllerTitle,
    required this.listTitle,
    required this.onScrollToIndex,
    this.currentIndexSelected,
    required this.controller,
    required this.dropDownController,
    required this.onShowLoading,
  });

  @override
  State<ProductFiltersNormal> createState() => _ProductFiltersNormalState();
}

class _ProductFiltersNormalState extends State<ProductFiltersNormal> {
  void handleActionFilter() {}

  void handleApplyFilter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 70),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: ListView.builder(
                    controller: widget.controllerTitle,
                    itemCount: widget.listTitle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AutoScrollTag(
                        controller: widget.controllerTitle,
                        index: index,
                        key: ValueKey(index),
                        child: GestureDetector(
                          onTap: () async {
                            widget.onScrollToIndex(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              left: 12,
                              top: 8,
                              bottom: 8,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: index == widget.currentIndexSelected ? Colors.blue : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Text(
                              widget.listTitle[index].name,
                              style: TextStyle(
                                fontWeight: index == widget.currentIndexSelected ? FontWeight.w700 : FontWeight.w500,
                                color: index == widget.currentIndexSelected ? Colors.black : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 0, bottom: 65),
                  height: widget.heightScreen,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: widget.controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < 10; i++)
                          AutoScrollTag(
                            controller: widget.controller,
                            index: i,
                            key: ValueKey(i),
                            child: Container(
                              height: 200,
                              child: Text("block$i"),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.15),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 45,
                      width: 120,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 45,
                      width: 120,
                      child: Text(
                        "Apply",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
