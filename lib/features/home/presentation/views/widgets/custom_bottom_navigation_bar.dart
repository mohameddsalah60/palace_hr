import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domin/entites/bottom_navigation_bar_entity.dart';
import 'navigation_bar_item_bottom.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * .10,
      padding: EdgeInsets.symmetric(horizontal: 9.r),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 25,
            color: Color(0x19000000),
            spreadRadius: 0,
          ),
        ],
        shape: RoundedRectangleBorder(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            bottomNavigationBarItem.asMap().entries.map((e) {
              var index = e.key;
              var entity = e.value;
              return GestureDetector(
                onTap: () => onTap(index),
                child: NavigationBarItem(
                  isSelected: currentIndex == index,
                  bottomNavigationBarItem: entity,
                ),
              );
            }).toList(),
      ),
    );
  }
}
