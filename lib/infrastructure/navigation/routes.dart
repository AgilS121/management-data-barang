import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Routes {
  static Future<String> get initialRoute async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return ONBOARDING;
    }

    String role = await _getUserRole(user.email!);
    print("data role $role");
    return _getRouteBasedOnRole(role);
  }

  static Future<String> _getUserRole(String email) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      return userDoc['role'] ?? 'customer';
    } catch (e) {
      print('Error getting user role: $e');
      return 'customer'; // Default role
    }
  }

  static String _getRouteBasedOnRole(String role) {
    switch (role) {
      case 'admin':
        return HOMEADMIN;
      case 'karyawan':
        return HOMEKARYAWAN;
      default:
        return HOMECUSTOMER;
    }
  }

  static const ADDALAMAT = '/addalamat';
  static const ADDKARYAWAN = '/addkaryawan';
  static const ADDKAYU = '/addkayu';
  static const AKUN = '/akun';
  static const BELANJA = '/belanja';
  static const CUSTOMDIVIDER = '/customdivider';
  static const DATAKARYAWAN = '/datakaryawan';
  static const DATAKAYU = '/datakayu';
  static const DETAILPESANAN = '/detailpesanan';
  static const DETAILPRODUK = '/detailproduk';
  static const EDITKARYAWAN = '/editkaryawan';
  static const HOME = '/home';
  static const HOMEADMIN = '/homeadmin';
  static const HOMECUSTOMER = '/homecustomer';
  static const HOMEKARYAWAN = '/homekaryawan';
  static const KERANJANG = '/keranjang';
  static const KONFIRMASIPEMBAYARAN = '/konfirmasipembayaran';
  static const LOGIN = '/login';
  static const LUPASANDI = '/lupasandi';
  static const ONBOARDING = '/onboarding';
  static const PEMBAYARAN = '/pembayaran';
  static const PENDAPATAN = '/pendapatan';
  static const PENGATURANCUSTOMER = '/pengaturancustomer';
  static const PRODUCTDETAIL = '/productdetail';
  static const PRODUCTDETAILKARYAWAN = '/productdetailkaryawan';
  static const PROFILADMIN = '/profiladmin';
  static const PROFILEKARYAWAN = '/profilekaryawan';
  static const REGISTER = '/register';
  static const RESETPASSWORD = '/resetpassword';
  static const SEARCHVIEW = '/search';
  static const SEARCHVIEWBELANJA = '/search-belanja';
  static const SEMUA_PRODUCT = '/semua-product';
  static const STOKKAYU = '/stokkayu';
  static const TENTANGAPLIKASI = '/tentangaplikasi';
  static const PURCHASE_DETAIL_SCREEN = '/purchase-detail-screen';
}
