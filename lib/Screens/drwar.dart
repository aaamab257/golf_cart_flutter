import 'package:flutter/material.dart';
import 'package:loginandregister_flutter/Screens/volunteer_screen.dart';

import 'package:provider/provider.dart';

Widget mainDrawer(BuildContext context, {bool isLoggedIn = true}) {
  bool is_driver = true;
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset('Assets/Main.jpg'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Golf Cart",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ],
            )),
        is_driver
            ? SizedBox()
            : ListTile(
                leading: const Icon(Icons.local_taxi),
                title: const Text('Join As Volunteer'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VolunteerForm()),
                  );
                },
              ),
        Divider(
          height: 10,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(Icons.local_taxi),
          title: const Text('My Trips'),
          onTap: () {},
        ),
        Divider(
          height: 10,
          thickness: 1,
        ),
      ],
    ),
  );
}
