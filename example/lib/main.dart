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
        height: 400,
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
        height: 200,
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
        height: 300,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section3"),
      ),
    ),
    TxDropDownMenuItem(
      id: 3,
      title: 'Items 4',
      countFilter: 8,
      section: Container(
        height: 150,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section4"),
      ),
    ),
    TxDropDownMenuItem(
      id: 3,
      title: 'Items 5',
      countFilter: 8,
      section: Container(
        height: 150,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section5"),
      ),
    ),
    TxDropDownMenuItem(
      id: 3,
      title: 'Items 6',
      countFilter: 8,
      section: Container(
        height: 150,
        alignment: Alignment.center,
        color: const Color(0xFFF2F2F2),
        child: const Text("Section6"),
      ),
    ),
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
          title: const Text("Tx dropdown menu demo"),
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
