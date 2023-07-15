import 'package:chefio_recipe_app/src/config/app_session.dart';
import 'package:chefio_recipe_app/src/modules/profile/screens/profile_viewmodel.dart';
import 'package:chefio_recipe_app/src/shared/assets/icons.dart';
import 'package:chefio_recipe_app/src/shared/styles/colors.dart';
import 'package:chefio_recipe_app/src/modules/dashboard/screens/home/home_screen.dart';
import 'package:chefio_recipe_app/src/modules/notification/notification.dart';
import 'package:chefio_recipe_app/src/modules/profile/screens/profile_screen.dart';
import 'package:chefio_recipe_app/src/modules/scan/scan.dart';
import 'package:chefio_recipe_app/src/modules/upload/screens/upload.dart';
import 'package:chefio_recipe_app/src/shared/styles/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _selectedIndex = 0;

  late List<Widget?> _pages;

  @override
  void initState() {
    super.initState();

    final user = AppSession.user;

    if (user != null) {
      _pages = [
        const HomeScreen(),
        const UploadScreen(),
        null,
        const NotificationsScreen(),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(user),
          child: const ProfileScreen(),
        ),
      ];
    } else {
      _pages = [
        const HomeScreen(),
        const UploadScreen(),
        null,
        const NotificationsScreen(),
        const SizedBox.shrink(),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: AppText.bold500(context).copyWith(fontSize: 12.sp),
              unselectedLabelStyle: AppText.bold500(context).copyWith(fontSize: 12.sp),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.secondaryText,
              selectedIconTheme: const IconThemeData(color: AppColors.primary),
              unselectedIconTheme: const IconThemeData(color: AppColors.secondaryText),
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.home,
                    color:
                        _selectedIndex == 0 ? AppColors.primary : AppColors.secondaryText,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.upload,
                    color:
                        _selectedIndex == 1 ? AppColors.primary : AppColors.secondaryText,
                  ),
                  label: 'Upload',
                ),
                const BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.notification,
                    color:
                        _selectedIndex == 3 ? AppColors.primary : AppColors.secondaryText,
                  ),
                  label: 'Notification',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.profile,
                    color:
                        _selectedIndex == 4 ? AppColors.primary : AppColors.secondaryText,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _selectedIndex == 1
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: AppColors.primary,
                  elevation: 0.0,
                  child: SvgPicture.asset(AppIcons.scan),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const ScanScreen();
                      },
                    );
                  },
                ),
                SizedBox(height: 8.h),
                Text(
                  'Scan',
                  style: AppText.bold500(context).copyWith(
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 12.h),
              ],
            ),
    );
  }
}
