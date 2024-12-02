import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';

class TxDropDownMenuView extends StatefulWidget {
  final Widget? sorts;
  final Duration animationDuration;
  final double offsetY;
  final int? currentIndexSelected;
  final double heightScreen;
  final List<ListTitleFilter> items;
  final AutoScrollController controllerTitle;
  final void Function() onShowLoading;
  final void Function(dynamic index) onScrollToIndex;
  final TxDropDownMenuController dropDownController;
  final AutoScrollController controller;

  const TxDropDownMenuView({
    super.key,
    this.sorts,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetY = 0,
    this.currentIndexSelected,
    required this.heightScreen,
    required this.items,
    required this.controllerTitle,
    required this.onShowLoading,
    required this.onScrollToIndex,
    required this.dropDownController,
    required this.controller,
  });

  @override
  State<TxDropDownMenuView> createState() => _TxDropDownMenuViewState();
}

class _TxDropDownMenuViewState extends State<TxDropDownMenuView> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  double viewHeight = 0;
  double animationViewHeight = 0;
  double animationSortHeight = 0;

  double maskHeight = 0;
  int currentIndex = 0;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(dropDownListener);
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
  }

  void dropDownListener() async {
    currentIndex = widget.dropDownController.headerIndex;
    if (isExpand && widget.dropDownController.isExpand) {
      await animationController?.reverse();
      maskHeight = 0;
    }

    isExpand = widget.dropDownController.isExpand;
    viewHeight = 615;
    animation?.removeListener(animationListener);
    animation = Tween<double>(begin: 0, end: viewHeight).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeInOut,
      ),
    )..addListener(animationListener);
    if (isExpand) {
      maskHeight = MediaQuery.of(context).size.height;
      await animationController?.forward();
    } else {
      await animationController?.reverse();
      maskHeight = 0;
    }
    if (mounted) setState(() {});
  }

  void animationListener() {
    animationViewHeight = animation?.value ?? 0;
    animationSortHeight = animation?.value ?? 0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double bodyHeight = MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0);

    return Column(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.2),
          width: MediaQuery.of(context).size.width,
          height: animationViewHeight,
          child: ClipRRect(
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
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.only(top: 16, bottom: 65, left: 4, right: 12),
                        decoration: const BoxDecoration(
                          color: ColorData.colorLight,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                          ),
                        ),
                        child: ListView.builder(
                          controller: widget.controllerTitle,
                          itemCount: widget.items.length,
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
                                    bottom: 16,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: index == widget.currentIndexSelected
                                            ? ColorData.colorPrimary
                                            : Colors.transparent,
                                        width: 2.5,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    widget.items[index].name,
                                    style: TextStyle(
                                      fontWeight:
                                          index == widget.currentIndexSelected ? FontWeight.w600 : FontWeight.w500,
                                      color: index == widget.currentIndexSelected
                                          ? ColorData.colorPrimary
                                          : ColorData.colorGrey,
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
                      flex: 10,
                      child: Container(
                        padding: const EdgeInsets.only(top: 16, bottom: 65, left: 12, right: 12),
                        height: widget.heightScreen,
                        decoration: const BoxDecoration(
                          color: ColorData.colorWhite,
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
                              for (var i = 0; i < widget.items.length; i++)
                                AutoScrollTag(
                                  controller: widget.controller,
                                  index: i,
                                  key: ValueKey(i),
                                  child: Container(
                                    height: i * 100,
                                    width: double.infinity,
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
                    height: 65,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorData.colorWhite,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 3),
                          color: ColorData.colorBlack.withOpacity(0.1),
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
                                color: ColorData.colorPrimary,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: ColorData.colorPrimary,
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
                                color: ColorData.colorPrimary,
                                width: 1,
                              ),
                              color: ColorData.colorPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: const Text(
                              "Apply",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: ColorData.colorWhite,
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
          ),
        ),
        if (widget.dropDownController.isExpand && viewHeight == animationViewHeight)
          GestureDetector(
            onTap: () {
              widget.dropDownController.hide();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: bodyHeight - animationViewHeight - 42,
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    animation?.removeListener(animationListener);
    widget.controller.removeListener(dropDownListener);
    animationController?.dispose();
    super.dispose();
  }
}
