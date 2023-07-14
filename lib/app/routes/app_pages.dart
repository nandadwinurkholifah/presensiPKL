import 'package:get/get.dart';

import '../modules/add_mahasiswa/bindings/add_mahasiswa_binding.dart';
import '../modules/add_mahasiswa/views/add_mahasiswa_view.dart';
import '../modules/add_pembimbing/bindings/add_pembimbing_binding.dart';
import '../modules/add_pembimbing/views/add_pembimbing_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/password_baru/bindings/password_baru_binding.dart';
import '../modules/password_baru/views/password_baru_view.dart';
import '../modules/pengenal_wajah/bindings/pengenal_wajah_binding.dart';
import '../modules/pengenal_wajah/views/pengenal_wajah_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.PENGENAL_WAJAH,
      page: () => const PengenalWajahView(),
      binding: PengenalWajahBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_BARU,
      page: () => const PasswordBaruView(),
      binding: PasswordBaruBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MAHASISWA,
      page: () => const AddMahasiswaView(),
      binding: AddMahasiswaBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PEMBIMBING,
      page: () => const AddPembimbingView(),
      binding: AddPembimbingBinding(),
    ),
  ];
}
