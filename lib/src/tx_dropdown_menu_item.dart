import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';

class TxDropdownMenuHeaderItem extends StatelessWidget {
  const TxDropdownMenuHeaderItem({
    Key? key,
    this.onPressed,
    required this.title,
    required this.countFilter,
    required this.listTitle,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final int countFilter;
  final List<ListTitleFilter> listTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorData.colorPrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: ColorData.colorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
