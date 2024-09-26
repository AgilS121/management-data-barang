import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:dekaybaro/presentation/adminpage/datakaryawan/views/addkaryawan_view.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/views/addkayu_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/search_bar_belanja_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/search_bar_view.dart';

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
      name: Routes.SEARCHVIEW,
      page: () => const SearchBarView(),
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
      name: Routes.SEARCHVIEWBELANJA,
      page: () => const SearchBarBelanjaView(),
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
      page: () => AddalamatScreen(),
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
    GetPage(
      name: Routes.HOMEADMIN,
      page: () => const HomeadminScreen(),
      binding: HomeadminControllerBinding(),
    ),
    GetPage(
      name: Routes.DATAKARYAWAN,
      page: () => const DatakaryawanScreen(),
      binding: DatakaryawanControllerBinding(),
    ),
    GetPage(
      name: Routes.ADDKARYAWAN,
      page: () => const AddkaryawanView(),
      binding: DatakaryawanControllerBinding(),
    ),
    GetPage(
      name: Routes.DATAKAYU,
      page: () => const DatakayuScreen(),
      binding: DatakayuControllerBinding(),
    ),
    GetPage(
      name: Routes.ADDKAYU,
      page: () => const AddkayuView(),
      binding: DatakayuControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILADMIN,
      page: () => const ProfiladminScreen(),
      binding: ProfiladminControllerBinding(),
    ),
    GetPage(
      name: Routes.PENDAPATAN,
      page: () => const PendapatanScreen(),
      binding: PendapatanControllerBinding(),
    ),
    GetPage(
      name: Routes.HOMEKARYAWAN,
      page: () => const HomekaryawanScreen(),
      binding: HomekaryawanControllerBinding(),
    ),
    GetPage(
      name: Routes.STOKKAYU,
      page: () => const StokkayuScreen(),
      binding: StokkayuControllerBinding(),
    ),
    GetPage(
      name: Routes.DETAILPESANAN,
      page: () => const DetailpesananScreen(),
      binding: DetailpesananControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILEKARYAWAN,
      page: () => const ProfilekaryawanScreen(),
      binding: ProfilekaryawanControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTDETAILKARYAWAN,
      page: () => const ProductdetailkaryawanScreen(),
      binding: ProductdetailkaryawanControllerBinding(),
    ),
  ];
}
