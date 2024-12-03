import 'package:flutter/material.dart';
import 'package:tx_dropdown_menu/theme/theme_data.dart';

class TxDropdownMenuHeaderItem extends StatelessWidget {
  const TxDropdownMenuHeaderItem({
    Key? key,
    this.onPressed,
    required this.title,
    required this.countFilter,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final int countFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.0,
      child: InkWell(
        onTap: onPressed,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(right: countFilter > 0 ? 16.0 : 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorData.colorPrimary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 0.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                      color: ColorData.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (countFilter > 0)
              Positioned(
                right: 6.0,
                top: -6.0,
                child: Container(
                  height: 16.0,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: ColorData.colorPrimary,
                  ),
                  child: Text(
                    countFilter > 9 ? "9+" : countFilter.toString(),
                    style: const TextStyle(
                      color: ColorData.colorWhite,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
