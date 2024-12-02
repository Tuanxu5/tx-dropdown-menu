library tx_dropdown_menu;

import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tx_dropdown_menu/controller/tx_drop_down_menu_controller.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/src/tx_dropdown_menu_header.dart';
import 'package:tx_dropdown_menu/src/tx_dropdown_menu_view.dart';

class TxDropDownMenu extends StatefulWidget {
  const TxDropDownMenu({
    super.key,
    required this.context,
    required this.heightScreen,
    required this.items,
  });

  final BuildContext context;
  final double heightScreen;
  final List<ListTitleFilter> items;

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
  OverlayEntry? _loadingOverlay;

  @override
  void initState() {
    super.initState();

    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    controllerTitle = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
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

  void handleShowLoading() {
    final overlay = Overlay.of(context);
    _loadingOverlay = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.1),
          child: const Text("loading"),
        ),
      ),
    );

    overlay.insert(_loadingOverlay!);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TxDropdownMenuHeader(
        controller: dropDownController,
        items: widget.items,
        onScrollToIndex: handleScrollToIndex,
      ),
      TxDropDownMenuView(
        dropDownController: dropDownController,
        currentIndexSelected: currentIndexSelected,
        heightScreen: widget.heightScreen,
        controllerTitle: controllerTitle,
        items: widget.items,
        onScrollToIndex: handleScrollToIndex,
        controller: controller,
        onShowLoading: handleShowLoading,
      ),
    ]);
  }
}
