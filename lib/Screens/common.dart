import 'package:flutter/material.dart';

import 'package:loginandregister_flutter/Screens/drwar.dart';

import 'package:url_launcher/url_launcher.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showScaffoldSnackBar(SnackBar snackBar) =>
    rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);

void showScaffoldSnackBarMessage(String message) =>
    rootScaffoldMessengerKey.currentState
        ?.showSnackBar(SnackBar(content: Text(message)));

void launchUrl(String url) async {
  if (!await launch(url))
    showScaffoldSnackBarMessage('Could not open url: "$url"');
}

Widget buildAppScaffold(BuildContext context, Widget child,
    {isLoggedIn = true}) {
  final isLocationFixed = true;
  return Scaffold(
    floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    floatingActionButton: Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FloatingActionButton(
          mouseCursor: SystemMouseCursors.click,
          child: Icon(
            Icons.menu,
          ),

          onPressed: () =>
              Scaffold.of(context).openDrawer(), // <-- Opens drawer.
        ),
      );
    }),
    drawer: mainDrawer(context, isLoggedIn: isLoggedIn),
    body: SafeArea(child: child),
  );
}
