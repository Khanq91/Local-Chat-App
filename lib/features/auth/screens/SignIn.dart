import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/data/realm/realm_models/models.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/HomeScreen.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/AddFriendScreen.dart';
import 'package:nhan_tin_noi_bo/features/auth/screens/SignUp.dart';
import 'package:nhan_tin_noi_bo/features/user/screens/SearchScreen.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/utils/FriendsStatusProvider.dart';
import '../../../core/utils/connection.dart';
import '../../../data/model/assets.dart';
import '../../../data/realm/realm_services/realm.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController taikhoanController = TextEditingController();
  TextEditingController matkhauController = TextEditingController();
  final realm = RealmService().realm;
  late final NguoiDung currentUser;

  void createUser(
    String tenDangNhap,
    String matKhau,
    String hoTen,
    bool trangThai,
    String vaiTro,
  ) {
    final newUser = NguoiDung(
      ObjectId(),
      tenDangNhap,
      matKhau,
      trangThai,
      vaiTro,
      DateTime.now(),
    );
    RealmService().add<NguoiDung>(newUser);
  }

  void clearAllRealmData(Realm realm) {
    realm.write(() {
      realm.deleteAll<NguoiDung>();
      realm.deleteAll<KetBan>();
    });
  }

  void _onLoginSuccess(NguoiDung user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => FriendsProvider(
                currentUser: user,
                realm: RealmService().realm,
              ),
            ),
          ],
          child: Home_Screen(currentUser: currentUser),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    RealmService realmService = RealmService();
    clearAllRealmData(realm);

    final nguoiGui = NguoiDung(ObjectId.fromHexString("60c72b2f9af1f34a2b6f7d89"), '1', '1', true, 'admin', DateTime.now(), hoTen: 'khanghah',);
    RealmService().add<NguoiDung>(nguoiGui);
    final nguoiNhan = NguoiDung(ObjectId.fromHexString("60c72b2f9af1f34a2b6f7d90"), '2', '2', true, 'admin', DateTime.now(), hoTen: 'khangheh',
    );
    final nguoiNhan1 = NguoiDung(ObjectId.fromHexString("60c72b2f9af1f34a2b6f7d90"), '3', '3', true, 'admin', DateTime.now(), hoTen: 'latuine',
    );
    RealmService().add<NguoiDung>(nguoiNhan);
    final nguoibar = NguoiDung(ObjectId.fromHexString("60c72b2f9af1f34a2b6f7d91"), '3', '3', true, 'admin', DateTime.now(), hoTen: 'khangh3h3',
    );
    RealmService().add<NguoiDung>(nguoibar);

    final moiKetBan = KetBan(ObjectId(), ObjectId.fromHexString("60c72b2f9af1f34a2b6f7d89"), ObjectId.fromHexString("60c72b2f9af1f34a2b6f7d90"), 'accepted', DateTime.now(), nguoiGui: nguoiGui, nguoiNhan: nguoiNhan,);
    RealmService().add<KetBan>(moiKetBan);

    var nguoiDung = realmService.realm.all<NguoiDung>();
    final allKetBans = realm.all<KetBan>();

    print('Có tất cả ${nguoiDung.length} người dùng');
    print('Tổng số kết bạn: ${allKetBans.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),

                //Tên app
                Image.asset(AppImages.logoPath, height: 70, width: 200),
                SizedBox(height: 20),
                //Trường nhập liệu
                TextField(
                  controller: taikhoanController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Nhập tài khoản...',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: matkhauController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Nhập mật khẩu...',
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      String tk = taikhoanController.text.trim();
                      String mk = matkhauController.text.trim();

                      if (tk.isEmpty || mk.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Vui lòng nhập đầy đủ thông tin"),
                          ),
                        );
                        return;
                      }
                      final user =
                          realm.all<NguoiDung>().query("tenDangNhap == \$0", [
                            tk,
                          ]).firstOrNull;

                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Tài khoản không tồn tại")),
                        );
                        return;
                      }

                      if (user.matKhau != mk) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Sai mật khẩu")));
                        return;
                      }
                      currentUser = user;
                      _onLoginSuccess(user);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 8, right: 8),
                  child: Divider(),
                ),
                SizedBox(height: 10),
                Text('or', style: TextStyle(fontSize: 18)),

                //Đăng nhập bằng gg
                SizedBox(height: 20),
                // ElevatedButton.icon(
                //   onPressed: () {
                //     // Google Sign-in
                //   },
                //   icon: Image.asset(
                //     'assets/icons/google_icon_24px.png',
                //     height: 24,
                //     width: 24,
                //   ),
                //   label: Text(
                //     "Đăng nhập bằng Google",
                //     style: TextStyle(fontSize: 16),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.white,
                //     foregroundColor: Colors.black,
                //     // minimumSize: Size(double.infinity, 50),
                //     side: BorderSide(color: Colors.grey.shade300),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // )
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                    children: [
                      TextSpan(
                        text: "Sign up.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => Signup()),
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
