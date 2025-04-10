import 'package:e_commerce_application_ui/features/personalization/screens/address/add_new_address_screen.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/address/user_address_screen.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/products/all_product_screen.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/products/product_detail_screen.dart';
import 'package:e_commerce_application_ui/features/personalization/screens/products/product_rating_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../bindings/login_binding.dart';
import '../../bindings/profile_binding.dart';
import '../../features/auth/screens/forget_password.dart';
import '../../features/auth/screens/login/login.dart';
import '../../features/auth/screens/signup/signup.dart';
import '../../features/cart/cart_screen.dart';
import '../../features/home/models/product_model.dart';
import '../../navigation_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;
  static const appNavigation = Routes.appNavigation; // Set the initial route

  static final routes = [
    // Login Page Route
    GetPage(
      name: _Paths.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),

    // Signup Page Route
    GetPage(
      name: _Paths.signup,
      page: () => const SignupScreen(),
      binding: BindingsBuilder(() => {
            // You can define the binding for signup here
          }),
    ),

    // Forget Password Page Route
    GetPage(
      name: _Paths.forgetPassword,
      page: () => const ForgetPassword(),
      binding: BindingsBuilder(() => {
            // You can define the binding for forget password here
          }),
    ),
    //
    // // Reset Password Page Route
    // GetPage(
    //   name: _Paths.resetPassword,
    //   page: () => const ResetPassword(),
    //   binding: BindingsBuilder(() => {
    //         // You can define the binding for reset password here
    //       }),
    // ),
    //
    // // Home Page Route
    GetPage(
      name: _Paths.appNavigation,
      page: () => const NavigationScreen(),
      binding:ProfileBinding(),
    ),
    GetPage(
      name: _Paths.productRatingScreen,
      page: () => const ProductRatingScreen(),
      binding: BindingsBuilder(
            () {},
      ),
    ),
    GetPage(
      name: _Paths.addressScreen,
      page: () => const UserAddressScreen(),
      binding: BindingsBuilder(
            () {},
      ),
    ),
    GetPage(
      name: _Paths.addNewAddressScreen,
      page: () => const AddNewAddressScreen(),
      binding: BindingsBuilder(
            () {},
      ),
    ),

    GetPage(
      name: _Paths.cartScreen,
      page: () => const CartScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() => {
        // You can define the binding for the side menu here
      }),
    ),
    GetPage(
      name: _Paths.allProductScreen,
      page: () => const AllProductScreen(),
      binding: BindingsBuilder(() => {
        // You can define the binding for the side menu here
      }),
    ),
    GetPage(
      name: _Paths.productDetailScreen,
      page: () {
        final Content? product = Get.arguments as Content?;
        if (product != null) {
          return ProductDetailScreen(product: product);
        }
        return ProductDetailScreen(product: Content()); // Provide a default or handle error
      },
      binding: BindingsBuilder(() => {
        // You can define the binding for the side menu here
      }),
    ),
    //
    // // Onboarding Page Route
    // GetPage(
    //   name: _Paths.onBoarding,
    //   page: () => const OnboardingScreen(),
    //   binding: BindingsBuilder(() => {
    //         // You can define the binding for onboarding here
    //       }),
    // ),
  ];
}
