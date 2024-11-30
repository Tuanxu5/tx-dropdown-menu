import 'package:flutter/material.dart';

class TxDropDownMenuHeaderStatus {
  TxDropDownMenuHeaderStatus({
    this.text = "",
    this.highlight = false,
  });

  String text;
  bool highlight;
}

class ListTitleFilter {
  final int id;
  final String name;
  final bool status;
  final int countFilter;
  const ListTitleFilter({required this.id, required this.name, required this.status, required this.countFilter});
}

class TxDropDownMenuItem<T> {
  final String? text;
  final Widget? icon;
  final Widget? activeIcon;
  final T? data;
  bool check;

  TxDropDownMenuItem({
    this.text,
    this.icon,
    this.activeIcon,
    this.data,
    this.check = false,
  });

  TxDropDownMenuItem<T> copyWith({
    String? text,
    Widget? icon,
    Widget? activeIcon,
    T? data,
    bool? check,
  }) {
    return TxDropDownMenuItem<T>(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      activeIcon: activeIcon ?? this.activeIcon,
      data: data ?? this.data,
      check: check ?? this.check,
    );
  }
}
