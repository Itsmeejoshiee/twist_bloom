import 'package:flutter/material.dart';
import 'inner_shadow_painter.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double iconSize;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconSize = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2), // Shadow on top
          ),
        ],
        color: Colors.white, // Background color of the bar
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          _buildNavBarItem(
            iconPath: 'assets/icon/home.png',
            index: 0,
            isSelected: currentIndex == 0,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/all_products.png',
            index: 1,
            isSelected: currentIndex == 1,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/orders.png',
            index: 2,
            isSelected: currentIndex == 2,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/messages.png',
            index: 3,
            isSelected: currentIndex == 3,
          ),
          _buildNavBarItem(
            iconPath: 'assets/icon/settings.png',
            index: 4,
            isSelected: currentIndex == 4,
          ),
        ],
        selectedItemColor:
        Colors.transparent, // Transparent to allow custom icon styling
        unselectedItemColor: Colors.grey, // Color for unselected items
        showUnselectedLabels: false, // Hide labels
        showSelectedLabels: false, // Hide labels
        backgroundColor:
        Colors.transparent, // Transparent background for the bar
        elevation: 0, // No elevation for a flat bottom bar
      ),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required String iconPath,
    required int index,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: iconSize + 16, // Adjust size with padding
        height: iconSize + 16, // Adjust size with padding
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF92B2) : Colors.transparent,
          borderRadius:
          BorderRadius.circular(12), // Rounded corners for the square
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              _buildInnerShadow(), // Add inner shadow only if selected
            Center(
              child: Image.asset(
                iconPath,
                color: isSelected
                    ? Colors.white
                    : Colors.black, // Change icon color based on selection
                width: iconSize,
                height: iconSize,
              ),
            ),
          ],
        ),
      ),
      label: '', // No label to keep it icon-only
    );
  }

  Widget _buildInnerShadow() {
    return CustomPaint(
      size:
      Size(iconSize + 16, iconSize + 16), // Adjust size to match container
      painter: InnerShadowPainter(),
    );
  }
}