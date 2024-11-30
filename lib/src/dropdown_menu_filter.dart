// import 'package:flutter/material.dart';

// class DropDownMenuFilter extends StatefulWidget {
//   const DropDownMenuFilter({
//     super.key,
//     required this.context,
//     required this.param,
//     required this.heightScreen,
//     required this.initial,
//     required this.searchOptions,
//     required this.attributesMap,
//     required this.productListCubit,
//     required this.onResetCurrentPage,
//     required this.searchOptionsInitial,
//   });

//   final BuildContext context;
//   final ProductFilterParam param;
//   final ProductFilterParam initial;
//   final double heightScreen;
//   final ProductSearchOption searchOptions;
//   final Map<String, List<String>> attributesMap;
//   final ProductListCubit productListCubit;
//   final void Function() onResetCurrentPage;
//   final ProductSearchOption searchOptionsInitial;

//   @override
//   State<DropDownMenuFilter> createState() => _DropDownMenuFilterState();
// }

// class _DropDownMenuFilterState extends State<DropDownMenuFilter> with SingleTickerProviderStateMixin {
//   final DropDownController dropDownController = DropDownController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//   final ProductFilterCubit cubit = ProductFilterCubit();
//   ProductFilterViewModel viewModel = const ProductFilterViewModel();
//   List<ListTitleFilter> listTitle = [];
//   int? currentIndexSelected = 0;
//   bool isLoading = false;
//   bool isInit = false;
//   late AutoScrollController controller;
//   late AutoScrollController controllerTitle;
//   OverlayEntry? _loadingOverlay;

//   @override
//   void initState() {
//     super.initState();

//     controller = AutoScrollController(
//       viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//       axis: Axis.vertical,
//     );
//     controllerTitle = AutoScrollController(
//       viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//       axis: Axis.vertical,
//     );
//     handleFetchAllFilter();
//   }

//   void handleFetchAllFilter() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       cubit.fetchAllFilter(widget.searchOptions);
//     });
//   }

//   void handleScrollToIndex(index) async {
//     final realIndex = index == 0 ? 1 : index;
//     await controllerTitle.scrollToIndex(realIndex, preferPosition: AutoScrollPosition.begin).then((value) => {
//           setState(() {
//             currentIndexSelected = realIndex;
//           })
//         });
//     await controller.scrollToIndex(realIndex, preferPosition: AutoScrollPosition.begin);
//   }

//   void handleShowLoading() {
//     final overlay = Overlay.of(context);
//     _loadingOverlay = OverlayEntry(
//       builder: (context) => Positioned.fill(
//         child: Container(
//           color: ColorPalettes.whiteShadow1.withOpacity(0.1),
//           child: const Loading(),
//         ),
//       ),
//     );

//     overlay.insert(_loadingOverlay!);
//     setState(() {
//       isLoading = true;
//     });
//   }

//   bool checkActiveFilter({required String value, List<ProductFilterGroupItemViewModel>? items}) {
//     ProductSearchOption option = widget.searchOptions;

//     if (value == "sort") {
//       return option.orderBy != SearchOptionOrderBy.auto;
//     }

//     if (value == "category") {
//       return option.categoryIDs.isNotEmpty;
//     }

//     if (value == "cities") {
//       return (option.stockCityIDs ?? []).isNotEmpty;
//     }

//     if (value == "brand") {
//       return option.brandIDs.isNotEmpty;
//     }

//     if (value == "promotionCampaignTiers") {
//       return (option.promotionCampaignTierTypes ?? []).isNotEmpty;
//     }

//     if (value == "price") {
//       return option.priceRange.from != null || option.priceRange.to != null;
//     }

//     if (value == "attributes") {
//       return option.attributeValueIDs.any((i) => items?.any((element) => element.id == i) ?? false);
//     }

//     return false;
//   }

//   int countActiveFilter({required String value, List<ProductFilterGroupItemViewModel>? items}) {
//     ProductSearchOption option = widget.searchOptions;

//     if (value == "sort") {
//       return option.orderBy != SearchOptionOrderBy.auto ? 1 : 0;
//     }

//     if (value == "category") {
//       return option.categoryIDs.length;
//     }

//     if (value == "cities") {
//       return (option.stockCityIDs ?? []).length;
//     }

//     if (value == "brand") {
//       return option.brandIDs.length;
//     }

//     if (value == "promotionCampaignTiers") {
//       return (option.promotionCampaignTierTypes ?? []).length;
//     }

//     if (value == "price") {
//       return 0;
//     }

//     if (value == "attributes") {
//       return (items ?? []).where((element) => option.attributeValueIDs.contains(element.id)).length;
//     }

//     return 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//       bloc: cubit,
//       listener: (context, state) {
//         if (state is BlocStateError) {
//           showServerErrorSnackBar(context, state.error);
//           if (isLoading == true) {
//             _loadingOverlay?.remove();
//             _loadingOverlay = null;
//             setState(() {
//               isLoading = false;
//             });
//           }
//           return;
//         }

//         if (state is BlocStateSuccess) {
//           listTitle.clear();
//           if (isLoading == true) {
//             _loadingOverlay?.remove();
//             _loadingOverlay = null;
//             setState(() {
//               isLoading = false;
//             });
//           }
//           if (state.data is ProductFilter) {
//             final newVm = ProductFilterViewModel.fromDomain(state.data);
//             viewModel = ProductFilterViewModel(
//               category: newVm.category,
//               brand: newVm.brand,
//               attributes: newVm.attributes,
//               cities: newVm.cities,
//               promotionCampaignTiers: newVm.promotionCampaignTiers,
//               isStock: viewModel.isStock,
//               priceRange: viewModel.priceRange,
//             );
//             cubit.resolveConflictData(state.data);

//             setState(() {
//               listTitle.add(ListTitleFilter(
//                 id: 1,
//                 name: S.current.sort,
//                 status: checkActiveFilter(value: "sort"),
//                 countFilter: countActiveFilter(value: "sort"),
//               ));

//               if (viewModel.category.items.isNotEmpty) {
//                 listTitle.add(ListTitleFilter(
//                   id: 1,
//                   name: viewModel.category.name.toCapitalized(),
//                   status: checkActiveFilter(value: "category"),
//                   countFilter: countActiveFilter(value: "category"),
//                 ));
//               }

//               if (viewModel.cities.items.isNotEmpty) {
//                 listTitle.add(ListTitleFilter(
//                   id: 2,
//                   name: viewModel.cities.name.toCapitalized(),
//                   status: checkActiveFilter(value: "cities"),
//                   countFilter: countActiveFilter(value: "cities"),
//                 ));
//               }

//               if (viewModel.brand.items.isNotEmpty) {
//                 listTitle.add(ListTitleFilter(
//                   id: 3,
//                   name: viewModel.brand.name.toCapitalized(),
//                   status: checkActiveFilter(value: "brand"),
//                   countFilter: countActiveFilter(value: "brand"),
//                 ));
//               }

//               if (viewModel.promotionCampaignTiers.items.isNotEmpty) {
//                 listTitle.add(ListTitleFilter(
//                   id: 4,
//                   name: viewModel.promotionCampaignTiers.name.toCapitalized(),
//                   status: checkActiveFilter(value: "promotionCampaignTiers"),
//                   countFilter: countActiveFilter(value: "promotionCampaignTiers"),
//                 ));
//               }

//               listTitle.add(ListTitleFilter(
//                 id: 5,
//                 name: S.current.price.toCapitalized(),
//                 status: checkActiveFilter(value: "price"),
//                 countFilter: countActiveFilter(value: "price"),
//               ));

//               listTitle.addAll(viewModel.attributes.mapIndexed(
//                 (index, item) => ListTitleFilter(
//                   id: index + 6,
//                   name: item.name.toCapitalized(),
//                   status: checkActiveFilter(value: "attributes", items: item.items),
//                   countFilter: countActiveFilter(value: "attributes", items: item.items),
//                 ),
//               ));
//             });
//           }
//         }
//       },
//       builder: (context, state) {
//         return Column(children: [
//           DropDownHeader(
//             controller: dropDownController,
//             listTitle: listTitle,
//             onScrollToIndex: handleScrollToIndex,
//           ),
//           DropDownView(
//             controller: dropDownController,
//             currentIndexSelected: currentIndexSelected,
//             filters: ProductFiltersNormal(
//               heightScreen: widget.heightScreen,
//               controllerTitle: controllerTitle,
//               listTitle: listTitle,
//               onScrollToIndex: handleScrollToIndex,
//               currentIndexSelected: currentIndexSelected,
//               controller: controller,
//               cubit: cubit,
//               productListCubit: widget.productListCubit,
//               param: widget.param,
//               searchOptions: widget.searchOptions,
//               dropDownController: dropDownController,
//               initial: widget.initial,
//               viewModel: viewModel,
//               onShowLoading: handleShowLoading,
//               onFetchAllFilter: handleFetchAllFilter,
//               onResetCurrentPage: widget.onResetCurrentPage,
//               searchOptionsInitial: widget.searchOptionsInitial,
//             ),
//             sorts: ProductFilterSort(
//               cubit: cubit,
//               productListCubit: widget.productListCubit,
//               searchOptions: widget.searchOptions,
//               dropDownController: dropDownController,
//               onFetchAllFilter: handleFetchAllFilter,
//               param: widget.param,
//               viewModel: viewModel,
//               onResetCurrentPage: widget.onResetCurrentPage,
//             ),
//           ),
//         ]);
//       },
//     );
//   }
// }
