import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:palace_hr/core/utils/app_colors.dart';

import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/home_view_body.dart';
import 'widgets/quick_selfie_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_currentIndex == 0) {
      log('clicked');
    }
  }

  @override
  void initState() {
    quickSelfieDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.wheitDark,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [HomeViewBody()],
      ),
    );
  }
}
