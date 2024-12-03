import 'package:flutter/material.dart';

enum TypeActionButton { primary, secondary }

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

class TxDropDownMenuAction {
  final int id;
  final String label;
  final TypeActionButton type;
  final void Function() action;

  const TxDropDownMenuAction({
    required this.id,
    required this.label,
    required this.type,
    required this.action,
  });
}
