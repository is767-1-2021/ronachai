import 'package:flutter/material.dart';
import 'package:icovid/constants/color_constant.dart';
import 'package:icovid/controllers/user_controller.dart';
import 'package:icovid/models/user_class_model.dart';
import 'package:icovid/models/user_provider.dart';
import 'package:icovid/services/user_service.dart';
import 'package:provider/provider.dart';

import 'add_user_page.dart';
import 'bottom_nav_page.dart';
import 'login_page.dart';

class ListUser extends StatefulWidget {
  var service = UserServices();
  var controller;
  ListUser() {
    controller = UserController(service);
  }

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<User> _userList = List.empty();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.controller.onSync.listen((bool syncState) => setState(() => isLoading = syncState));
    _getUsers();
  }
  void _getUsers() async {
    var newUserList = await widget.controller.fecthUsers();
    setState(() {
      _userList   = newUserList;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, int index) {
          //User data = provider.users[index];
          return Dismissible(
            key: ValueKey(_userList[index]),
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                //UserProvider().RemoveUserList(_userList[index]);
                _userList.removeAt(index);
              });

              // Then show a snackbar.
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${_userList[index].email} ถูกลบ')));
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Icon(Icons.person),
                  ),
                ),
                title: Text('${_userList[index].email}'),
                subtitle: Text('${_userList[index].position}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetail(user: _userList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    List<User> _userList = [];
    if (context.read<UserProvider>().userList != null) {
      _userList = context.read<UserProvider>().userList;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('รายชื่อผู้ใช้งาน'),
        backgroundColor: iBlueColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavScreen()),
              );
            },
            icon: Icon(Icons.home_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFormPage()),
              );
            },
            icon: Icon(Icons.person_add),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: body,)
    );
  }
}

// class UserTile extends StatelessWidget {
//   final User items;
//   const UserTile({Key? key, required this.items}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: ListTile(
//           leading: CircleAvatar(
//             radius: 30,
//             child: FittedBox(
//               child: Icon(Icons.person),
//             ),
//           ),
//           title: Text('${items.username}'),
//           subtitle: Text('${items.position}'),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => UserDetail(user: items),
//               ),
//             );
//           },
//         ),
//     );
//   }
// }

class UserDetail extends StatelessWidget {
  final User user;
  const UserDetail({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้งาน'),
        backgroundColor: iBlueColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ชื่อผู้ใช้',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${user.email}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ชื่อ-นามสกุล',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${user.firstName} ${user.lastName}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ตำแหน่ง',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${user.position}',
            ),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'สังกัดโรงพยาบาล',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: user.hospitalName ==null ? '':'${user.hospitalName}',
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     border: UnderlineInputBorder(),
            //     enabled: false,
            //     labelText: 'รหัสผ่าน',
            //     labelStyle: TextStyle(
            //         color: iBlackColor,
            //         fontWeight: FontWeight.w700,
            //         fontSize: 16),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: iBlueColor),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(color: iBlueColor),
            //     ),
            //   ),
            //   initialValue: '${user.password}',
            // ),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                enabled: false,
                labelText: 'ประเภทผู้ใช้งาน',
                labelStyle: TextStyle(
                    color: iBlackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: iBlueColor),
                ),
              ),
              initialValue: '${user.roleName}',
            ),
          ],
        ),
      ),
    );
  }
}
