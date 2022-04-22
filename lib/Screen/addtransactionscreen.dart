// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/constants/widget.dart';
import 'package:flutter_mona/services/auth_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String _id = '';
  String _jmluang = '';
  String _note = '';
  bool isGetScreen = true;
  bool _isloading = false;

  @override
  void initState() {
    getapi();
    super.initState();
  }

  getapi() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var id = localStorage.getString('id');
    setState(() {
      _id = id!;
    });
  }

  addTransactionPressed() async {
    setState(() {
      _isloading = true;
    });
    Response response = await AuthServices.storeadd(_id, _jmluang, _note);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _isloading = false;
      });
      successSnackBar(context, responseMap.values.first);
    } else {
      setState(() {
        _isloading = false;
      });
      errorSnackBar(context, responseMap.values.first);
    }
  }

  getTransactionPressed() async {
    setState(() {
      _isloading = true;
    });
    Response response = await AuthServices.storeget(_id, _jmluang, _note);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _isloading = false;
      });
      successSnackBar(context, responseMap.values.first);
    } else {
      setState(() {
        _isloading = false;
      });
      errorSnackBar(context, responseMap.values.first);
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
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset('assets/svg/backdrop2.svg'),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'),
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
                              fontSize: 20,
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
                Positioned(
                  top: 150,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 600,
                    margin: const EdgeInsets.only(bottom: 100),
                    decoration: const BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 60,
                        right: 60,
                      ),
                      child: _isloading == true
                          ? const SpinKitRotatingCircle(
                              color: kPrimaryColor,
                              size: 25,
                            )
                          : Column(
                              children: [
                                const SizedBox(height: 20),
                                Container(
                                  height: 39,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: kShadowColor),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isGetScreen = true;
                                            });
                                          },
                                          child: Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: !isGetScreen
                                                    ? kWhiteColor
                                                    : kButtonColor),
                                            child: Center(
                                              child: Text(
                                                'Pemasukan',
                                                style: GoogleFonts.roboto(
                                                    fontWeight: !isGetScreen
                                                        ? FontWeight.w500
                                                        : FontWeight.bold,
                                                    fontSize: 18,
                                                    color: !isGetScreen
                                                        ? kButtonColor
                                                        : kWhiteColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isGetScreen = false;
                                            });
                                          },
                                          child: Container(
                                            height: 38,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: !isGetScreen
                                                    ? kButtonColor
                                                    : kWhiteColor),
                                            child: Center(
                                              child: Text('Pengeluaran',
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: !isGetScreen
                                                        ? FontWeight.bold
                                                        : FontWeight.w500,
                                                    fontSize: 18,
                                                    color: !isGetScreen
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
                                if (isGetScreen) addScreen(),
                                if (!isGetScreen) getScreen(),
                              ],
                            ),
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

  Column getScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        customInputFieldFb1(
            hintText: "Rp.",
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _jmluang = value;
            }),
        const SizedBox(
          height: 8,
        ),
        customInputFieldFb1(
          hintText: "Note",
          keyboardType: TextInputType.text,
          onChanged: (value) {
            _note = value;
          },
        ),
        const SizedBox(height: 5),
        const SizedBox(height: 70),
        MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            getTransactionPressed();
          },
          color: kButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Ambil',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Column addScreen() {
    return Column(
      children: [
        const SizedBox(
          height: 45,
        ),
        customInputFieldFb1(
            hintText: "Rp.",
            onChanged: (value) {
              _jmluang = value;
            },
            keyboardType: TextInputType.number),
        const SizedBox(
          height: 8,
        ),
        customInputFieldFb1(
            hintText: "Note",
            keyboardType: TextInputType.text,
            onChanged: (value) {
              _note = value;
            }),
        const SizedBox(height: 5),
        const SizedBox(height: 70),
        MaterialButton(
          minWidth: double.infinity,
          height: 40,
          onPressed: () {
            addTransactionPressed();
          },
          color: kButtonColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Tambah',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
