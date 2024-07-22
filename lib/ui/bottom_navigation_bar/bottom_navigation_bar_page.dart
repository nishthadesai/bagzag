import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/generated/assets.dart';
import 'package:flutter_demo_structure/ui/bottom_navigation_bar/feed/feed_page.dart';
import 'package:flutter_demo_structure/ui/bottom_navigation_bar/profile/profile_page.dart';
import 'package:flutter_demo_structure/ui/bottom_navigation_bar/sell/sell_page.dart';
import 'package:flutter_demo_structure/ui/bottom_navigation_bar/studio/studio_page.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';
import '../../router/app_router.dart';
import '../../values/app_class.dart';
import '../../values/colors.dart';
import '../../values/style.dart';
import 'home/home_page.dart';

@RoutePage()
class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  List pages = [
    HomePage(),
    StudioPage(),
    SellPage(),
    FeedPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return Scaffold(
          extendBody: true,
          body: pages[value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  color: AppColor.black.withOpacity(0.30),
                  blurRadius: 0.0,
                ),
              ],
            ),
            child: BottomNavigationBar(
              selectedItemColor: AppColor.pinkColor,
              unselectedItemColor: AppColor.black,
              selectedLabelStyle: textMedium.copyWith(
                fontSize: 11.spMin,
                color: AppColor.pinkColor,
              ),
              unselectedLabelStyle: textRegular.copyWith(
                  fontSize: 11.spMin, color: AppColor.black),
              selectedIconTheme: IconThemeData(
                color: AppColor.pinkColor,
                fill: 1,
              ),
              unselectedIconTheme:
                  IconThemeData(color: AppColor.black, fill: 0),
              iconSize: 20.r,
              currentIndex: value,
              onTap: (val) {
                if (val == 2) {
                  _openCamera();
                } else {
                  selectedIndex.value = val;
                }
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white.withOpacity(0.89),
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(Assets.imageBottomHome))
                        .wrapPaddingOnly(bottom: 4),
                    activeIcon:
                        ImageIcon(AssetImage(Assets.imageBottomFilledHome))
                            .wrapPaddingOnly(bottom: 4),
                    label: S.of(context).home),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(Assets.imageBottomStudio))
                        .wrapPaddingOnly(bottom: 4),
                    activeIcon:
                        ImageIcon(AssetImage(Assets.imageBottomStudioFilled))
                            .wrapPaddingOnly(bottom: 4),
                    label: S.of(context).studio),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(Assets.imageBottomCamera))
                        .wrapPaddingOnly(bottom: 4),
                    label: S.of(context).sell),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(Assets.imageBottomChart))
                        .wrapPaddingOnly(bottom: 4),
                    activeIcon:
                        ImageIcon(AssetImage(Assets.imageBottomChartFilled))
                            .wrapPaddingOnly(bottom: 4),
                    label: S.of(context).feed),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage(Assets.imageBottomProfile))
                        .wrapPaddingOnly(bottom: 4),
                    activeIcon:
                        ImageIcon(AssetImage(Assets.imageBottomProfileFilled))
                            .wrapPaddingOnly(bottom: 4),
                    label: S.of(context).me),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<void> _openCamera() async {
  AppClass().showLoading(true);
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);

  if (image != null) {
    AppClass().showLoading(false);
    final String path = image.path;

    appRouter.push(AddProductInfoRoute(path: '$path'));
  } else {
    AppClass().showLoading(false);
    appRouter.maybePop();
    print('No image selected.');
  }
}
