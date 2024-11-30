import 'package:flutter/material.dart';

import 'tx_dropdown_menu_test_page.dart';

void main() {
  runApp(const TxDropdownMenuDemo());
}

class TxDropdownMenuDemo extends StatelessWidget {
  const TxDropdownMenuDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Tx dropdown menu Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TxDropDownMenuTestPage(
        context: context,
        heightScreen: heightScreen,
      ),
    );
  }
}
