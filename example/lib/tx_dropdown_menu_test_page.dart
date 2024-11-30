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
  List<ListTitleFilter> listTitle = [];
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
    final realIndex = index == 0 ? 1 : index;
    await controllerTitle.scrollToIndex(realIndex, preferPosition: AutoScrollPosition.begin).then((value) => {
          setState(() {
            currentIndexSelected = realIndex;
          })
        });
    await controller.scrollToIndex(realIndex, preferPosition: AutoScrollPosition.begin);
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
        listTitle: listTitle,
        onScrollToIndex: handleScrollToIndex,
      ),
      TxDropDownMenuView(
        controller: dropDownController,
        currentIndexSelected: currentIndexSelected,
        // filters: ProductFiltersNormal(
        //   heightScreen: widget.heightScreen,
        //   controllerTitle: controllerTitle,
        //   listTitle: listTitle,
        //   onScrollToIndex: handleScrollToIndex,
        //   currentIndexSelected: currentIndexSelected,
        //   controller: controller,
        //   cubit: cubit,
        //   productListCubit: widget.productListCubit,
        //   param: widget.param,
        //   searchOptions: widget.searchOptions,
        //   dropDownController: dropDownController,
        //   initial: widget.initial,
        //   viewModel: viewModel,
        //   onShowLoading: handleShowLoading,
        //   onFetchAllFilter: handleFetchAllFilter,
        //   onResetCurrentPage: widget.onResetCurrentPage,
        //   searchOptionsInitial: widget.searchOptionsInitial,
        // ),
        // sorts: ProductFilterSort(
        //   cubit: cubit,
        //   productListCubit: widget.productListCubit,
        //   searchOptions: widget.searchOptions,
        //   dropDownController: dropDownController,
        //   onFetchAllFilter: handleFetchAllFilter,
        //   param: widget.param,
        //   viewModel: viewModel,
        //   onResetCurrentPage: widget.onResetCurrentPage,
        // ),
      ),
    ]);
  }
}
