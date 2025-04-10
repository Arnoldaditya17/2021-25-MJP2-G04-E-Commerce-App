part of 'app_pages.dart';

abstract class Routes {
  Routes._(); // Private constructor to prevent instantiation

  static const login = _Paths.login;
  static const signup = _Paths.signup;
  static const forgetPassword = _Paths.forgetPassword;
  static const resetPassword = _Paths.resetPassword;
  static const home = _Paths.home;
  static const notification = _Paths.notification;
  static const appNavigation = _Paths.appNavigation;
  static const sideMenu = _Paths.sideMenu;
  static const onBoarding = _Paths.onBoarding;
  static const cartScreen=_Paths.cartScreen;
  static const allProductScreen=_Paths.allProductScreen;
  static const productDetailScreen=_Paths.productDetailScreen;
  static const productRatingScreen= _Paths.productRatingScreen;
  static const addressScreen= _Paths.addressScreen;
  static const addNewAddressScreen= _Paths.addNewAddressScreen;
}

abstract class _Paths {
  _Paths._(); // Private constructor to prevent instantiation

  static const login = '/login_screen';
  static const signup = '/signup_screen';
  static const forgetPassword = '/forgetPassword_screen';
  static const resetPassword = '/resetPassword_screen';
  static const home = '/bottom_navigation_bar';
  static const notification = '/notification_screen';
  static const appNavigation = '/navigation_screen';
  static const sideMenu = '/side_menu_drawer';
  static const onBoarding = '/onboarding_screen';
  static const cartScreen = '/cart_screen';
  static const allProductScreen = '/all_product_screen';
  static const productDetailScreen = '/product_detail_screen';
  static const productRatingScreen = '/product_rating_screen';
  static const addressScreen = '/user_address_screen';
  static const addNewAddressScreen = '/add_new_address_screen';

}
