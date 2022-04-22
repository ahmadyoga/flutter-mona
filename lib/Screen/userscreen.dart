import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/splashscreen.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/model/usermodel.dart';
import 'package:flutter_mona/services/auth_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.remove('api_token');
    await localStorage.remove('id');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SplashScreen()));
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
                  height: MediaQuery.of(context).size.height * 0.965,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset('assets/svg/backdrop2.svg'),
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child:
                          const Icon(Icons.arrow_back_ios, color: kWhiteColor),
                    )),
                Positioned(
                  left: 35,
                  top: 55,
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
                  top: 170,
                  child: Container(
                      padding: const EdgeInsets.only(
                        top: 70,
                        left: 30,
                        right: 30,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 700,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(70)),
                        color: kWhiteColor,
                      ),
                      child: FutureBuilder<User>(
                          future: AuthServices.info(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                color: kWhiteColor,
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 400,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: const SpinKitRotatingCircle(
                                  color: kPrimaryColor,
                                  size: 35.0,
                                ),
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nama',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(snapshot.data!.name,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text('Email',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(snapshot.data!.email,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    height: 10,
                                    width: MediaQuery.of(context).size.width,
                                    color: kBaseColor,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      logout();
                                    },
                                    child: SizedBox(
                                      height: 60,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: FittedBox(
                                              child: Icon(Icons.logout,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text('logout',
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          })),
                ),
                Positioned(
                  left: 40,
                  top: 115,
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 181, 222, 255),
                    ),
                    child: SvgPicture.asset('assets/svg/icon_user.svg'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
