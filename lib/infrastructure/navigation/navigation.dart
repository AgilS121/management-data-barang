import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingScreen(),
      binding: OnboardingControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding(),
    ),
    GetPage(
      name: Routes.LUPASANDI,
      page: () => const LupasandiScreen(),
      binding: LupasandiControllerBinding(),
    ),
    GetPage(
      name: Routes.RESETPASSWORD,
      page: () => const ResetpasswordScreen(),
      binding: ResetpasswordControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.HOMECUSTOMER,
      page: () => const HomecustomerScreen(),
      binding: HomecustomerControllerBinding(),
    ),
    GetPage(
      name: Routes.SEMUA_PRODUCT,
      page: () => const SemuaProductScreen(),
      binding: SemuaProductControllerBinding(),
    ),
    GetPage(
      name: Routes.BELANJA,
      page: () => const BelanjaScreen(),
      binding: BelanjaControllerBinding(),
    ),
    GetPage(
      name: Routes.KERANJANG,
      page: () => const KeranjangScreen(),
      binding: KeranjangControllerBinding(),
    ),
    GetPage(
      name: Routes.AKUN,
      page: () => const AkunScreen(),
      binding: AkunControllerBinding(),
    ),
    GetPage(
      name: Routes.DETAILPRODUK,
      page: () => const DetailprodukScreen(),
      binding: DetailprodukControllerBinding(),
    ),
    GetPage(
      name: Routes.PEMBAYARAN,
      page: () => PembayaranScreen(),
      binding: PembayaranControllerBinding(),
    ),
    GetPage(
      name: Routes.ADDALAMAT,
      page: () => const AddalamatScreen(),
      binding: AddalamatControllerBinding(),
    ),
    GetPage(
      name: Routes.KONFIRMASIPEMBAYARAN,
      page: () => const KonfirmasipembayaranScreen(),
      binding: KonfirmasipembayaranControllerBinding(),
    ),
    GetPage(
      name: Routes.PENGATURANCUSTOMER,
      page: () => const PengaturancustomerScreen(),
      binding: PengaturancustomerControllerBinding(),
    ),
    GetPage(
      name: Routes.TENTANGAPLIKASI,
      page: () => const TentangaplikasiScreen(),
      binding: TentangaplikasiControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTDETAIL,
      page: () => const ProductdetailScreen(),
      binding: ProductdetailControllerBinding(),
    ),
  ];
}
