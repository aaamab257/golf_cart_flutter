import 'package:flutter/material.dart';
import 'package:loginandregister_flutter/Screens/Home.dart';
import 'package:loginandregister_flutter/Screens/Login.dart';
import 'package:loginandregister_flutter/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_snackbar.dart';
import '../model/register_request.dart';
import 'MainScreen.dart';

enum Type {
  student,
  driver,
}

class RegisterPageScreen extends StatefulWidget {
  RegisterPageScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageScreenScreen createState() => _RegisterPageScreenScreen();
}

class _RegisterPageScreenScreen extends State<RegisterPageScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();

  bool _showPassword = false;
  String type = 'Select account type';
  Type _type;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.blueAccent, //change your color here
          ),
          backgroundColor: Colors.white,
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Consumer<AuthProvider>(
              builder: (context, register, child) {
                return Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Text(
                      'SignUp Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                    Center(
                      child: Text(
                        'Kindly Fill all the details to get started',
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
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Name Field must not be empty';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                labelText: 'Name',
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
                            child: new TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Phone Field must not be empty';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                labelText: 'Phone Number ex 5*******',
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
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15.0),
                                      ),
                                    ),
                                    builder: (context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Type',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            ListTile(
                                              title: Text(
                                                'Student',
                                              ),
                                              leading: Radio<Type>(
                                                value: Type.student,
                                                groupValue: _type,
                                                onChanged: (Type value) {
                                                  setState(() {
                                                    _type = value;
                                                    type = 'Student';
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  type = 'Student';
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              title: Text(
                                                'Driver',
                                              ),
                                              leading: Radio<Type>(
                                                value: Type.driver,
                                                groupValue: _type,
                                                onChanged: (Type value) {
                                                  setState(() {
                                                    _type = value;
                                                    type = 'Driver';
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  type = 'Driver';
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${type}',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey, spreadRadius: 1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
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
                              controller: _passwordController,
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
                                hintText: "Password",
                                border: OutlineInputBorder(),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglevisibility();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 70,
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
                            child: TextFormField(
                              controller: _password2Controller,
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
                                hintText: "Confirm Password",
                                border: OutlineInputBorder(),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _togglevisibility();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 70,
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextButton(
                                onPressed: () {
                                  if (_nameController.text.isEmpty) {
                                    showCustomSnackBar(
                                        'Please Enter your name', context);
                                  } else if (_phoneController.text.isEmpty) {
                                    showCustomSnackBar(
                                        'Please Enter your Phone number',
                                        context);
                                  } else if (_passwordController.text.isEmpty) {
                                    showCustomSnackBar(
                                        'Please Enter your Password', context);
                                  } else if (_password2Controller
                                      .text.isEmpty) {
                                    showCustomSnackBar(
                                        'Please Confirm your password',
                                        context);
                                  } else if (_passwordController.text !=
                                      _password2Controller.text) {
                                    showCustomSnackBar(
                                        'Passwords do not match', context);
                                  } else if (_phoneController.text.length >
                                          10 &&
                                      _phoneController.text.length < 10) {
                                    showCustomSnackBar(
                                        'Phone Number not valid', context);
                                  } else if (!_phoneController.text
                                      .startsWith('05')) {
                                    showCustomSnackBar(
                                        'Phone Number Must start with 05',
                                        context);
                                  } else {
                                    String email = _emailController.text;
                                    String name = _nameController.text;
                                    String phone = _phoneController.text;
                                    String password = _passwordController.text;
                                    String password2 =
                                        _password2Controller.text;
                                    bool accountType =
                                        type == 'Student' ? false : true;
                                    SignUpModel signUpModel = SignUpModel(
                                        email: email,
                                        name: name,
                                        phone: phone,
                                        password: password,
                                        password2: password2,
                                        is_driver: accountType,
                                        is_admin: false);
                                    register
                                        .register(signUpModel)
                                        .then((status) {
                                      if (register.code == 201) {
                                        showCustomSnackBar(
                                            'Your account created successfully',
                                            context);
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainScreen()),
                                            (route) => false);
                                      } else {
                                        showCustomSnackBar(
                                            'Something Error , please try again',
                                            context);
                                      }
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text('Register',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPageScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(30),
                              child: Text('Have an Account? Log In'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
