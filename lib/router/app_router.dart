import 'package:auto_route/auto_route.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_demo_structure/core/locator/locator.dart';
import 'package:flutter_demo_structure/ui/splash/splash_page.dart';

import '../data/my_data/feed_story_data.dart';
import '../ui/auth/forgot_password/forgot_password_page.dart';
import '../ui/auth/forgot_password/phone_verification_page.dart';
import '../ui/auth/forgot_password/reset_password_page.dart';
import '../ui/auth/sign_up/create_account.dart';
import '../ui/bottom_navigation_bar/bottom_navigation_bar_page.dart';
import '../ui/bottom_navigation_bar/feed/create_story_page.dart';
import '../ui/bottom_navigation_bar/feed/posted_product_details_page.dart';
import '../ui/bottom_navigation_bar/feed/story_view_page.dart';
import '../ui/bottom_navigation_bar/home/app_bar_search_page.dart';
import '../ui/bottom_navigation_bar/home/browse_categories_page.dart';
import '../ui/bottom_navigation_bar/home/categories_details_page.dart';
import '../ui/bottom_navigation_bar/home/favorites_page.dart';
import '../ui/bottom_navigation_bar/home/home_page.dart';
import '../ui/bottom_navigation_bar/home/searched_product_view_page.dart';
import '../ui/bottom_navigation_bar/profile/bagzag/bagzag_mall_page.dart';
import '../ui/bottom_navigation_bar/profile/bagzag/mall_details_page.dart';
import '../ui/bottom_navigation_bar/profile/profile_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/about_us_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/change_password_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/contact_us_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/policy_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/setting_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/shared_setting_page.dart';
import '../ui/bottom_navigation_bar/profile/settings/terms_page.dart';
import '../ui/bottom_navigation_bar/sell/add_product_info_page.dart';
import '../ui/bottom_navigation_bar/sell/brand_details_page.dart';
import '../ui/bottom_navigation_bar/sell/category_details_page.dart';
import '../ui/bottom_navigation_bar/sell/color_details_page.dart';
import '../ui/bottom_navigation_bar/sell/sell_page.dart';
import '../ui/bottom_navigation_bar/sell/size_details_page.dart';
import '../ui/bottom_navigation_bar/sell/subcategory_details_page.dart';
import '../ui/bottom_navigation_bar/studio/influencer_profile_page.dart';
import '../ui/walk_through/walk_through_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
// extend the generated private router
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: BottomNavigationBarRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: WalkThroughRoute.page),
    AutoRoute(page: PhoneVerificationRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
    AutoRoute(page: CreateAccountRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: AppBarSearchRoute.page),
    AutoRoute(page: SearchedProductViewRoute.page),
    AutoRoute(page: FavoritesRoute.page),
    AutoRoute(page: BrowseCategoriesRoute.page),
    AutoRoute(page: CategoriesDetailsRoute.page),
    AutoRoute(page: InfluencerProfileRoute.page),
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: BagzagMallRoute.page),
    AutoRoute(page: MallDetailsRoute.page),
    AutoRoute(page: SettingRoute.page),
    AutoRoute(page: ChangePasswordRoute.page),
    AutoRoute(page: ContactUsRoute.page),
    AutoRoute(page: AboutUsRoute.page),
    AutoRoute(page: PolicyRoute.page),
    AutoRoute(page: TermsRoute.page),
    AutoRoute(page: SharedSettingRoute.page),
    AutoRoute(page: AddProductInfoRoute.page),
    AutoRoute(page: CreatePostCategoryDetailsRoute.page),
    AutoRoute(page: CreatePostSubCategoryDetailsRoute.page),
    AutoRoute(page: CreatePostBrandDetailsRoute.page),
    AutoRoute(page: CreatePostColorDetailsRoute.page),
    AutoRoute(page: CreatePostSizeDetailsRoute.page),
    AutoRoute(page: SellRoute.page),
    AutoRoute(page: CreateStoryRoute.page),
    AutoRoute(page: StoryViewRoute.page),
    AutoRoute(page: PostedProductDetailsRoute.page),
  ];
}

final appRouter = locator<AppRouter>();
