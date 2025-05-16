import 'package:get/get.dart';
import 'package:exam_prep_app/modules/splash/splash_binding.dart';
import 'package:exam_prep_app/modules/splash/splash_screen.dart';
import 'package:exam_prep_app/modules/auth/login/login_binding.dart';
import 'package:exam_prep_app/modules/auth/login/login_screen.dart';
import 'package:exam_prep_app/modules/auth/otp/otp_binding.dart';
import 'package:exam_prep_app/modules/auth/otp/otp_screen.dart';
import 'package:exam_prep_app/modules/profile/profile_binding.dart';
import 'package:exam_prep_app/modules/profile/profile_screen.dart';
import 'package:exam_prep_app/modules/dashboard/dashboard_binding.dart';
import 'package:exam_prep_app/modules/dashboard/dashboard_screen.dart';
import 'package:exam_prep_app/modules/game_room/game_room_binding.dart';
import 'package:exam_prep_app/modules/game_room/game_room_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpScreen(),
      binding: OtpBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.GAME_ROOM,
      page: () => const GameRoomScreen(),
      binding: GameRoomBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}