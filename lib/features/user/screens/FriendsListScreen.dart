import 'package:flutter/material.dart';
import 'package:nhan_tin_noi_bo/features/chat/screens/IndividualPage.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/utils/FriendWithStatus.dart';
import '../../../core/utils/connection.dart';
import '../../../core/utils/FriendsStatusProvider.dart';
import '../../../data/model/assets.dart';
import '../../../data/realm/realm_models/models.dart';
import '../../../data/realm/realm_services/realm.dart';
import '../../chat/screens/CreateGroupPages.dart';

class FriendsListScreen extends StatefulWidget {
  final NguoiDung currentUser;
  final IO.Socket socket;
  const FriendsListScreen({super.key, required this.currentUser, required this.socket,});

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {
  late Realm realm;
  late final ObjectId currentUserId;
  // late List<NguoiDung> friends;
  // late List<FriendWithStatus> friends;


  // List<NguoiDung> getAcceptedFriends(Realm realm, NguoiDung currentUser) {
  //   final allKetBans = realm.all<KetBan>();
  //   final accepted = allKetBans.where(
  //     (kb) =>
  //       kb.trangThai == 'accepted' &&
  //       (kb.nguoiGui?.maNguoiDung == currentUser.maNguoiDung ||
  //         kb.nguoiNhan?.maNguoiDung == currentUser.maNguoiDung),
  //   );
  //
  //   return accepted
  //     .map((kb) {
  //       if (kb.nguoiGui?.maNguoiDung == currentUser.maNguoiDung) {
  //         return kb.nguoiNhan;
  //       } else {
  //         return kb.nguoiGui;
  //       }
  //     })
  //     .whereType<NguoiDung>()
  //     .toList();
  // }

  // void listenSocketStatus() {
  //   widget.socket.on("capNhatTrangThai", (data) {
  //     final userId = data['userId'];
  //     final isOnline = data['trangThai'];
  //     final index = friends.indexWhere((f) =>
  //     f.nguoiDung.maNguoiDung == ObjectId.fromHexString(userId));
  //     if (index != -1) {
  //       setState(() {
  //         friends[index].isOnline = isOnline;
  //       });
  //     }
  //
  //   });
  // }


  @override
  void initState() {
    super.initState();
    realm = RealmService().realm;
    currentUserId = widget.currentUser.maNguoiDung;
    // friends = friends = getAcceptedFriends(realm, widget.currentUser)
    //     .map((f) => FriendWithStatus(nguoiDung: f))
    //     .toList();

    // listenSocketStatus();

    // final friendsProvider = Provider.of<FriendsProvider>(context, listen: false);
    // friendsProvider.loadFriends();

    widget.socket.emit("yeuCauTrangThaiOnline", {
      "userId": currentUserId,
    });

    widget.socket.on("capNhatTrangThai", (data) {
      if (!mounted) return;
      final provider = context.read<FriendsProvider>();
      final userId = ObjectId.fromHexString(data['userId']);
      final isOnline = data['trangThai'];
      provider.updateOnlineStatus(userId, isOnline);
    });

    widget.socket.on("danhSachTrangThaiOnline", (data) {
      if (!mounted) return;
      final provider = context.read<FriendsProvider>();

      for (var item in data) {
        final userId = ObjectId.fromHexString(item['userId']);
        final isOnline = item['trangThai'];
        provider.updateOnlineStatus(userId, isOnline);
      }
    });


  }

  @override
  void dispose() {
    // widget.socket.emit('offline', {
    //   'userId': currentUserId,
    // });
    widget.socket.off("capNhatTrangThai");
    widget.socket.off("danhSachTrangThaiOnline");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
                tabs: [Tab(text: 'Chat'), Tab(text: 'Nhóm')],
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
                                Icon(
                                  Icons.person_add_alt_1,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 16),
                                Text("Lời mời kết bạn"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade100, thickness: 7),
                      Expanded(
                        child: Consumer<FriendsProvider>(
                          builder: (context, friendsProvider, _) {
                            final friendsProvider = Provider.of<FriendsProvider>(context);
                            final friends = friendsProvider.friends;

                            if (friends.isEmpty) {
                              return Center(child: Text('Không có bạn bè nào.'));
                            }

                            return ListView.builder(
                              itemCount: friends.length,
                              itemBuilder: (context, index) {
                                final friend = friends[index];

                                return Stack(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Text(
                                          friend.nguoiDung.hoTen!.substring(0, 1).toUpperCase(),
                                        ),
                                      ),
                                      title: Text(friend.nguoiDung.hoTen!),
                                      onTap: () {
                                        print(
                                            "nhắn tin với ${friend.nguoiDung.hoTen!}, Trạng thái ${friend.nguoiDung.trangThai}");
                                      },
                                    ),
                                    Positioned(
                                      child: Icon(
                                        friend.isOnline ? Icons.circle : Icons.circle,
                                        color: friend.isOnline ? Colors.green : Colors.grey.shade400,
                                        size: 16,
                                      ),
                                      top: 5,
                                      left: 13,
                                    ),
                                  ],
                                );
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateGroupPages(),
                              ),
                            );
                          },
                          child: Container(
                            height: 65,
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                //Icon(Icons.group_add_rounded, color: Colors.white,)
                                Icon(
                                  Icons.group_add_rounded,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 16),
                                Text("Tạo nhóm mới"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey.shade100, thickness: 7),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
