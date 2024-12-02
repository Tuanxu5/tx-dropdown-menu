import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';
import 'package:tx_dropdown_menu/tx_dropdown_menu.dart';

void main() {
  runApp(const TxDropdownMenuDemo());
}

class TxDropdownMenuDemo extends StatefulWidget {
  const TxDropdownMenuDemo({super.key});

  @override
  State<TxDropdownMenuDemo> createState() => _TxDropdownMenuDemoState();
}

class _TxDropdownMenuDemoState extends State<TxDropdownMenuDemo> {
  List<ListTitleFilter> listMenuItems = [
    const ListTitleFilter(id: 1, name: 'Items 1', countFilter: 5),
    const ListTitleFilter(id: 2, name: 'Items 2', countFilter: 3),
    const ListTitleFilter(id: 3, name: 'Items 3', countFilter: 8),
  ];

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorData.colorPrimary,
          foregroundColor: ColorData.colorWhite,
          title: const Text("Tx dropdown menu Demo"),
        ),
        body: TxDropDownMenu(
          context: context,
          heightScreen: heightScreen,
          items: listMenuItems,
        ),
      ),
    );
  }
}
