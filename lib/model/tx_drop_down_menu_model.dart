import 'package:flutter/material.dart';

class TxDropDownMenuHeaderStatus {
  TxDropDownMenuHeaderStatus({
    this.text = "",
    this.highlight = false,
  });

  String text;
  bool highlight;
}

class TxDropDownMenuItem {
  final int id;
  final String title;
  final int countFilter;
  final Widget section;

  const TxDropDownMenuItem({
    required this.id,
    required this.title,
    required this.countFilter,
    required this.section,
  });
}
