import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/chat/screens/IndividualPage.dart';
import 'package:realm/realm.dart';

import '../../../data/model/assets.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import '../../chat/screens/CreateGroupPages.dart';

class FriendsListScreen extends StatelessWidget {
  final NguoiDung currentUser;
  const FriendsListScreen({super.key, required this.currentUser,});

  List<NguoiDung> getAcceptedFriends(Realm realm, NguoiDung currentUser) {
    final allKetBans = realm.all<KetBan>();
    final accepted = allKetBans.where((kb) => kb.trangThai == 'accepted' &&
        (kb.nguoiGui?.maNguoiDung == currentUser.maNguoiDung || kb.nguoiNhan?.maNguoiDung == currentUser.maNguoiDung)
    );

    return accepted.map((kb) {
      if (kb.nguoiGui?.maNguoiDung == currentUser.maNguoiDung) {
        return kb.nguoiNhan;
      } else {
        return kb.nguoiGui;
      }
    }).whereType<NguoiDung>().toList();
  }


  @override
  Widget build(BuildContext context) {
    final realm = RealmService().realm;
    final friends = getAcceptedFriends(realm, currentUser)
        .where((friend) => friend.hoTen != null)
        .toList();
    return DefaultTabController(
      length: 2,
      child: Container(
        color: AppColors.bodyBG,
        child: Column(
          children: [
            // TabBar nằm ngoài AppBar nè
            Container(
              color: AppColors.bodyBG,
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: 'Chat'),
                  Tab(text: 'Nhóm'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //TODO: Trang danh sách bạn bè
                  Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            print("Tap!");
                          },
                          child: Container(
                            height: 65,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(Icons.person_add_alt_1, color: Colors.blue,),
                                SizedBox(width: 16),
                                Text("Lời mời kết bạn"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade100, thickness: 7,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: friends.length,
                          itemBuilder: (context, index) {
                            final friend = friends[index];
                            return ListTile(
                              leading: CircleAvatar(
                                child: Text(friend.hoTen!.substring(0, 1).toUpperCase()),
                              ),
                              title: Text(friend.hoTen!),
                              onTap: () {
                                print("nhắn tin với ${friend.hoTen!}");
                              },
                            );
                          },
                        ),
                      ),

                    ],
                  ),
                  Column(
                    //TODO: Trang danh sách nhóm
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupPages()));
                          },
                          child: Container(
                            height: 65,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [ //Icon(Icons.group_add_rounded, color: Colors.white,)
                                Icon(Icons.group_add_rounded, color: Colors.blue,),
                                SizedBox(width: 16),
                                Text("Tạo nhóm mới"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade100, thickness: 7,)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
