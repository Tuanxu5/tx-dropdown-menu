import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';

class TxDropDownMenuView extends StatefulWidget {
  final TxDropDownMenuController controller;
  final Widget? filters;
  final Widget? sorts;
  final Duration animationDuration;
  final double offsetY;
  final int? currentIndexSelected;

  const TxDropDownMenuView({
    super.key,
    required this.controller,
    this.filters,
    this.sorts,
    this.animationDuration = const Duration(milliseconds: 150),
    this.offsetY = 0,
    this.currentIndexSelected,
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
    currentIndex = widget.controller.headerIndex;

    if (isExpand && widget.controller.isExpand) {
      await animationController?.reverse();
      maskHeight = 0;
    }

    isExpand = widget.controller.isExpand;
    viewHeight = 615;
    animation?.removeListener(animationListener);
    animation = Tween<double>(begin: 0, end: viewHeight)
        .animate(CurvedAnimation(parent: animationController!, curve: Curves.easeInOut))
      ..addListener(animationListener);
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
          color: Colors.black12,
          width: MediaQuery.of(context).size.width,
          height: animationViewHeight,
          child: widget.filters,
        ),
        if (widget.controller.isExpand && viewHeight == animationViewHeight)
          GestureDetector(
            onTap: () {
              widget.controller.hide();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: bodyHeight - animationViewHeight - 42,
              color: Colors.grey.shade200,
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
