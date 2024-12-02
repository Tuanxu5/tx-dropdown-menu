import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/model/tx_drop_down_menu_model.dart';

class ButtonFilter extends StatelessWidget {
  const ButtonFilter({
    Key? key,
    this.onPressed,
    required this.title,
    required this.status,
    required this.countFilter,
    required this.listTitle,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final bool status;
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
            color: Colors.grey,
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
              ((status && countFilter > 0) ? "($countFilter) " : "") + title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 2),
            Text("Icon"),
          ],
        ),
      ),
    );
  }
}
