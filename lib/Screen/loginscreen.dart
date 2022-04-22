import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_mona/Screen/homescreen.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/constants/widget.dart';
import 'package:flutter_mona/services/auth_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future data;
  String _name = '';
  String _email = '';
  String _password = '';
  bool isSignUpScreen = true;
  bool _passwordVisible = false;
  bool _isloading = false;

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      setState(() {
        _isloading = true;
      });
      Response response = await AuthServices.login(_email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await localStorage.setString(
            'api_token', json.encode(responseMap['token']));
        await localStorage.setString('id', json.encode(responseMap['id']));
        setState(() {
          _isloading = false;
        });
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        errorSnackBar(context, responseMap.values.first);
        setState(() {
          _isloading = false;
        });
      }
    } else {
      setState(() {
        _isloading = false;
      });
      errorSnackBar(context, "enter all required fields");
    }
  }

  createAccountPressed() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    if (emailValid) {
      setState(() {
        _isloading = true;
      });
      Response response = await AuthServices.register(_name, _email, _password);
      Map responseMap = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          _isloading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()));
      } else {
        setState(() {
          _isloading = false;
        });
        errorSnackBar(context, responseMap.values.first[0]);
      }
    } else {
      errorSnackBar(context, 'email not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColor,
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset('assets/svg/round.svg'),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'ONA',
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        _isloading == true
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: const SpinKitRotatingCircle(
                                        color: kPrimaryColor,
                                        size: 40.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 58, left: 38, right: 38, bottom: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 39,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border:
                                              Border.all(color: kShadowColor),
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isSignUpScreen = true;
                                                  });
                                                },
                                                child: Container(
                                                  height: 38,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.295,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: !isSignUpScreen
                                                          ? kWhiteColor
                                                          : kButtonColor),
                                                  child: Center(
                                                    child: Text(
                                                      'Login',
                                                      style: GoogleFonts.roboto(
                                                          fontWeight:
                                                              !isSignUpScreen
                                                                  ? FontWeight
                                                                      .w500
                                                                  : FontWeight
                                                                      .bold,
                                                          fontSize: 18,
                                                          color: !isSignUpScreen
                                                              ? kButtonColor
                                                              : kWhiteColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isSignUpScreen = false;
                                                  });
                                                },
                                                child: Container(
                                                  height: 38,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.295,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: !isSignUpScreen
                                                          ? kButtonColor
                                                          : kWhiteColor),
                                                  child: Center(
                                                    child: Text('Sign Up',
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontWeight:
                                                              !isSignUpScreen
                                                                  ? FontWeight
                                                                      .bold
                                                                  : FontWeight
                                                                      .w500,
                                                          fontSize: 18,
                                                          color: !isSignUpScreen
                                                              ? kWhiteColor
                                                              : kButtonColor,
                                                        )),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (isSignUpScreen) loginScreen(),
                                      if (!isSignUpScreen) signUpScreen(),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column loginScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        customInputFieldFb1(
          onChanged: (value) {
            _email = value;
          },
          hintText: 'support@google.com',
          label: 'email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 8,
        ),
        customInputFieldFb1(
          onChanged: (value) {
            _password = value;
          },
          hintText: 'password',
          label: 'password',
          obscure: !_passwordVisible,
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        const SizedBox(height: 5),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot your password?",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: kShadowColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            loginPressed();
          },
          color: kButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Masuk',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          'or',
          style: TextStyle(color: kShadowColor, fontSize: 19),
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 35,
          width: 35,
          child: SvgPicture.asset('assets/svg/google.svg'),
        ),
      ],
    );
  }

  Column signUpScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        customInputFieldFb1(
          onChanged: (value) {
            _name = value;
          },
          hintText: 'mona',
          label: 'nama',
        ),
        const SizedBox(
          height: 8,
        ),
        customInputFieldFb1(
          onChanged: (value) {
            _email = value;
          },
          hintText: 'support@google.com',
          label: 'email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 8,
        ),
        customInputFieldFb1(
          onChanged: (value) {
            _password = value;
          },
          hintText: 'password',
          label: 'password',
        ),
        const SizedBox(height: 30),
        MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            createAccountPressed();
          },
          color: kButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Daftar',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'or',
          style: TextStyle(color: kShadowColor, fontSize: 19),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 35,
          width: 35,
          child: SvgPicture.asset('assets/svg/google.svg'),
        ),
      ],
    );
  }
}
