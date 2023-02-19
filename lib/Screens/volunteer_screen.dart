import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../helpers/custom_snackbar.dart';
import '../providers/auth_provider.dart';
import 'Login.dart';
import 'MainScreen.dart';

class VolunteerForm extends StatefulWidget {
  @override
  State<VolunteerForm> createState() => _VolunteerFormState();
}

class _VolunteerFormState extends State<VolunteerForm> {
  bool value = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  @override
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
                        'Kindly Fill all the details to be a Volunteer',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'Assets/upload.png',
                        scale: 30,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Please Upload Your License'),
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
                            child: new TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Student Id Field must not be empty';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                labelText: 'Student ID',
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
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: this.value,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.value = value;
                                  });
                                },
                              ),
                              Text('Do you suffer from any health diseases'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: TextButton(
                                onPressed: () {
                                  AlertDialog(
                                    title: Text('Volunteer Request'),
                                    content:
                                        Text('Your Request sent successfully'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()),
                                              (route) => false);
                                        },
                                        child: Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text('Send Request',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
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
