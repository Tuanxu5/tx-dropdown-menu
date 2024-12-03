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
  List<TxDropDownMenuItem> listMenuItems = [
    TxDropDownMenuItem(
      id: 1,
      title: 'Items 1',
      countFilter: 12,
      section: Container(
        height: 400.0,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section1"),
      ),
    ),
    TxDropDownMenuItem(
      id: 2,
      title: 'Items 2',
      countFilter: 3,
      section: Container(
        height: 200.0,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section2"),
      ),
    ),
    TxDropDownMenuItem(
      id: 3,
      title: 'Items 3',
      countFilter: 8,
      section: Container(
        height: 300.0,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section3"),
      ),
    ),
    TxDropDownMenuItem(
      id: 4,
      title: 'Items 4',
      countFilter: 0,
      section: Container(
        height: 150.0,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section4"),
      ),
    ),
    TxDropDownMenuItem(
      id: 5,
      title: 'Items 5',
      countFilter: 8,
      section: Container(
        height: 150.0,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section5"),
      ),
    ),
    TxDropDownMenuItem(
      id: 6,
      title: 'Items 6',
      countFilter: 8,
      section: Container(
        height: 150.0,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section6"),
      ),
    ),
  ];

  List<TxDropDownMenuAction> actionGroup = [
    TxDropDownMenuAction(
      id: 1,
      label: 'Cancel',
      type: TypeActionButton.secondary,
      action: () {},
    ),
    TxDropDownMenuAction(
      id: 2,
      label: 'Apply',
      type: TypeActionButton.primary,
      action: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorData.colorPrimary,
          foregroundColor: ColorData.colorWhite,
          title: const Text("Tx dropdown menu demo"),
        ),
        body: TxDropDownMenu(
          items: listMenuItems,
          actionGroup: actionGroup,
          viewHeight: 500.0,
        ),
      ),
    );
  }
}
