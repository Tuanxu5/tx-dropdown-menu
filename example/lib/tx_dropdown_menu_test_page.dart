import 'package:example/product_filters_normal.dart';
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tx_dropdown_menu/tx_dropdown_menu.dart';

class TxDropDownMenuTestPage extends StatefulWidget {
  const TxDropDownMenuTestPage({
    super.key,
    required this.context,
    required this.heightScreen,
  });

  final BuildContext context;
  final double heightScreen;

  @override
  State<TxDropDownMenuTestPage> createState() => _TxDropDownMenuTestPageState();
}

class _TxDropDownMenuTestPageState extends State<TxDropDownMenuTestPage> with SingleTickerProviderStateMixin {
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

  List<ListTitleFilter> filters = [
    const ListTitleFilter(id: 1, name: 'Filter 1', status: true, countFilter: 5),
    const ListTitleFilter(id: 2, name: 'Filter 2', status: false, countFilter: 3),
    const ListTitleFilter(id: 3, name: 'Filter 3', status: true, countFilter: 8),
    const ListTitleFilter(id: 4, name: 'Filter 4', status: false, countFilter: 2),
    const ListTitleFilter(id: 5, name: 'Filter 5', status: true, countFilter: 6),
    const ListTitleFilter(id: 6, name: 'Filter 6', status: false, countFilter: 4),
    const ListTitleFilter(id: 7, name: 'Filter 7', status: true, countFilter: 10),
    const ListTitleFilter(id: 8, name: 'Filter 8', status: false, countFilter: 1),
    const ListTitleFilter(id: 9, name: 'Filter 9', status: true, countFilter: 7),
    const ListTitleFilter(id: 10, name: 'Filter 10', status: false, countFilter: 9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Tx dropdown menu Demo"),
      ),
      body: Column(children: [
        TxDropdownMenuHeader(
          controller: dropDownController,
          listTitle: filters,
          onScrollToIndex: handleScrollToIndex,
        ),
        TxDropDownMenuView(
          controller: dropDownController,
          currentIndexSelected: currentIndexSelected,
          filters: ProductFiltersNormal(
            heightScreen: widget.heightScreen,
            controllerTitle: controllerTitle,
            listTitle: filters,
            onScrollToIndex: handleScrollToIndex,
            currentIndexSelected: currentIndexSelected,
            controller: controller,
            dropDownController: dropDownController,
            onShowLoading: handleShowLoading,
          ),
        ),
      ]),
    );
  }
}
