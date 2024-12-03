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
  final List<TxDropDownMenuItem> items;
  final AutoScrollController controllerTitle;
  final void Function(dynamic index) onScrollToIndex;
  final AutoScrollController controller;
  final TxDropDownMenuController dropDownController;
  final List<TxDropDownMenuAction> actionGroup;

  const TxDropDownMenuView({
    super.key,
    this.sorts,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetY = 0.0,
    this.currentIndexSelected,
    required this.heightScreen,
    required this.items,
    required this.controllerTitle,
    required this.onScrollToIndex,
    required this.controller,
    required this.dropDownController,
    required this.actionGroup,
  });

  @override
  State<TxDropDownMenuView> createState() => _TxDropDownMenuViewState();
}

class _TxDropDownMenuViewState extends State<TxDropDownMenuView> with SingleTickerProviderStateMixin {
  Animation<double>? animation;
  AnimationController? animationController;
  double viewHeight = 0.0;
  double animationViewHeight = 0.0;
  double animationSortHeight = 0.0;
  double maskHeight = 0.0;
  int currentIndex = 0;
  bool isExpand = false;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    animation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Curves.easeInOut,
      ),
    )..addListener(animationListener);

    widget.dropDownController.addListener(dropDownListener);
  }

  void dropDownListener() async {
    if (!mounted) return;

    currentIndex = widget.dropDownController.headerIndex;

    if (isExpand != widget.dropDownController.isExpand) {
      isExpand = widget.dropDownController.isExpand;
      viewHeight = 615.0;
      animation?.removeListener(animationListener);
      final tween = Tween<double>(begin: 0.0, end: viewHeight);
      animation = tween.animate(
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
        maskHeight = 0.0;
      }

      if (mounted) setState(() {});
    }
  }

  void animationListener() {
    animationViewHeight = animation?.value ?? 0.0;
    animationSortHeight = animation?.value ?? 0.0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double bodyHeight = MediaQuery.of(context).size.height - (Scaffold.of(context).appBarMaxHeight ?? 0.0);

    return Column(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.2),
          width: MediaQuery.of(context).size.width,
          height: animationViewHeight,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
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
                        padding: const EdgeInsets.only(top: 16.0, bottom: 65.0, left: 4.0, right: 12.0),
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
                                    left: 12.0,
                                    bottom: 16.0,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 6.0,
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
                                    widget.items[index].title,
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
                        padding: const EdgeInsets.only(top: 16.0, bottom: 32.0, left: 12.0, right: 12.0),
                        height: widget.heightScreen,
                        decoration: const BoxDecoration(
                          color: ColorData.colorWhite,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: ListView.builder(
                          controller: widget.controller,
                          itemCount: widget.items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: AutoScrollTag(
                                controller: widget.controller,
                                index: index,
                                key: ValueKey(index),
                                child: widget.items[index].section,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 65.0,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: ColorData.colorWhite,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          spreadRadius: 5.0,
                          offset: const Offset(0.0, 3.0),
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
                        for (var i = 0; i < widget.actionGroup.length; i++)
                          InkWell(
                            onTap: () {
                              widget.actionGroup[i].action.call();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: widget.actionGroup[i].type == TypeActionButton.primary
                                    ? ColorData.colorPrimary
                                    : ColorData.colorWhite,
                                border: Border.all(
                                  color: ColorData.colorPrimary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.only(left: 12.0),
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                widget.actionGroup[i].label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0,
                                  color: widget.actionGroup[i].type == TypeActionButton.primary
                                      ? ColorData.colorWhite
                                      : ColorData.colorPrimary,
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
              height: bodyHeight - animationViewHeight - 48.0,
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
