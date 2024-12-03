library tx_dropdown_menu;

import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/src/tx_dropdown_menu_header.dart';
import 'package:tx_dropdown_menu/src/tx_dropdown_menu_view.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';

class TxDropDownMenu extends StatefulWidget {
  const TxDropDownMenu({
    super.key,
    required this.items,
    required this.actionGroup,
    this.colorPrimary = ColorData.colorPrimary,
    this.viewHeight = 615.0,
  });

  final List<TxDropDownMenuItem> items;
  final List<TxDropDownMenuAction> actionGroup;
  final Color colorPrimary;
  final double viewHeight;

  @override
  State<TxDropDownMenu> createState() => _TxDropDownMenuState();
}

class _TxDropDownMenuState extends State<TxDropDownMenu> with SingleTickerProviderStateMixin {
  final TxDropDownMenuController dropDownController = TxDropDownMenuController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int? currentIndexSelected = 0;
  bool isLoading = false;
  bool isInit = false;
  late AutoScrollController controller;
  late AutoScrollController controllerTitle;

  @override
  void initState() {
    super.initState();

    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0.0, 0.0, 0.0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    controllerTitle = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0.0, 0.0, 0.0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
  }

  void handleScrollToIndex(index) async {
    await controllerTitle.scrollToIndex(index, preferPosition: AutoScrollPosition.begin).then((value) => {
          setState(() {
            currentIndexSelected = index;
          })
        });
    await controller.scrollToIndex(index, preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TxDropdownMenuHeader(
        dropDownController: dropDownController,
        items: widget.items,
        onScrollToIndex: handleScrollToIndex,
        colorPrimary: widget.colorPrimary,
      ),
      TxDropDownMenuView(
        dropDownController: dropDownController,
        currentIndexSelected: currentIndexSelected,
        controllerTitle: controllerTitle,
        items: widget.items,
        onScrollToIndex: handleScrollToIndex,
        controller: controller,
        actionGroup: widget.actionGroup,
        colorPrimary: widget.colorPrimary,
        viewHeight: widget.viewHeight,
      ),
    ]);
  }
}
