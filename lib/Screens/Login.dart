import 'package:flutter/material.dart';
import 'package:loginandregister_flutter/Screens/Register.dart';
import 'package:loginandregister_flutter/Screens/widgets/loading.dart';
import 'package:loginandregister_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_snackbar.dart';
import '../providers/user.dart';
import 'Home.dart';
import 'MainScreen.dart';
import 'helpers/screen_navigation.dart';

class LoginPageScreen extends StatefulWidget {
  LoginPageScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  bool _showPassword = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<ScaffoldState>();

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authsProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  'Login In Now',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
                Center(
                  child: Text(
                    'Kindly Login to continue using our app',
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new TextFormField(
                          controller: authsProvider.email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email Field must not be empty';
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .nextFocus(), // move focus to next
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: authsProvider.password,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .nextFocus(), // move focus to next
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password Field must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _togglevisibility();
                              },
                              child: Container(
                                height: 50,
                                width: 45,
                                padding: EdgeInsets.symmetric(vertical: 13),
                                child: Center(
                                  child: Text(
                                    _showPassword ? "Hide" : "Show",
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                            onPressed: () {},
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: TextButton(
                            onPressed: () async {
                              if (authsProvider.email.text == '') {
                                /*setState(() {
                                    _validateEmail = true;
                                  });*/
                                showCustomSnackBar(
                                    'Please enter your Email', context);
                              } else if (authsProvider.password.text == '') {
                                showCustomSnackBar(
                                    'Please enter your Password', context);
                              } else {
                                // String email = _emailController.text;
                                // String password = _passwordController.text;
                                // authProvider
                                //     .login(email, password)
                                //     .then((status) async {
                                //   if (authProvider.code == 200) {
                                //     showCustomSnackBar(
                                //         'Login successfully', context);
                                //     Navigator.pushAndRemoveUntil(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => MainScreen()),
                                //         (route) => false);
                                //   } else if (authProvider.code == 404) {
                                //     showCustomSnackBar(
                                //         'Email or Password is not Valid',
                                //         context);
                                //   }
                                // });
                                if (!await authsProvider.signIn()) {
                                  print('in fun');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Login failed")));
                                  return;
                                }
                                print('out of fun');
                                authsProvider.clearController();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()),
                                    (route) => false);
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              minimumSize:
                                  Size(MediaQuery.of(context).size.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          changeScreen(context, RegisterPageScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.all(30),
                          child: Text('Do not have an Account? SignUp'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
