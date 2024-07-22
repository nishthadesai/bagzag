import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/extensions/widget_ext.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/my_data/bagzag_mall_data.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../../values/colors.dart';
import '../../../../values/style.dart';
import '../../../../widget/base_app_bar.dart';

@RoutePage()
class BagzagMallPage extends StatefulWidget {
  const BagzagMallPage({super.key});

  @override
  State<BagzagMallPage> createState() => _BagzagMallPageState();
}

class _BagzagMallPageState extends State<BagzagMallPage> {
  final Map<int, PageRouteInfo> routePage = {0: MallDetailsRoute()};

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: buildAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: buildView(height),
    );
  }

  Widget buildAppBar() {
    return BaseAppBar(
      leadingIcon: true,
      leadingWidget: GestureDetector(
        onTap: () {
          appRouter.maybePop();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 17.r,
          color: Colors.black,
        ),
      ),
      titleWidget: Text(
        S.of(context).bagzagMall,
        style: textMedium.copyWith(fontSize: 20.spMin, color: AppColor.black),
      ),
      action: [
        Image.asset(
          Assets.imageSearch,
          height: 20.r,
          width: 20.r,
        ).wrapPaddingOnly(left: 11, top: 12, bottom: 12, right: 12),
      ],
      showTitle: true,
      centerTitle: true,
      backgroundColor: AppColor.white,
    );
  }

  Widget buildView(double height) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: bagzagMallList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: height < 600 ? 135 : 175,
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7),
            itemBuilder: (context, index) {
              BagzagMallData data = bagzagMallList[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3).r,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        appRouter.push(routePage[index]!);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3).r,
                        child: Image.asset(
                          data.image,
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      data.name,
                      style: textMedium.copyWith(
                          fontSize: 14.spMin, color: AppColor.black),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    ).wrapPaddingHorizontal(15);
  }
}
