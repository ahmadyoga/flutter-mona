import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/homescreen.dart';
import 'package:flutter_mona/constants/widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/model/detailmodel.dart';
import 'package:flutter_mona/services/auth_services.dart';
import 'package:http/http.dart';

class DetailTransaction extends StatefulWidget {
  final int id;
  const DetailTransaction({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DetailTransaction> createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  late String _id;

  delete() async {
    setState(() {
      _id = widget.id.toString();
    });
    Response response = await AuthServices.destroy(_id);
    Map responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      successSnackBar(context, responseMap.values.first);
    } else {
      errorSnackBar(context, responseMap.values.first);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Hapus"),
      onPressed: () {
        delete();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'ONA',
                style: GoogleFonts.roboto(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ],
      ),
      content: Text(
        'Apakah anda yakin ingin menghapus catatan ini',
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: kBlackColor,
        ),
      ),
      actions: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              cancelButton,
              continueButton,
            ],
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                  height: MediaQuery.of(context).size.height * 0.96,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      'assets/svg/backdrop_detail.svg',
                      fit: BoxFit.cover,
                    ),
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
                FutureBuilder<Detail>(
                  future: AuthServices.show(widget.id.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Positioned(
                        top: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: kWhiteColor,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 400,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: const SpinKitRotatingCircle(
                              color: kPrimaryColor,
                              size: 35.0,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Positioned(
                        top: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: kWhiteColor,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 400,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: ListView(
                              children: [
                                Text(
                                  snapshot.data!.createdAt,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: kTenBlackColor,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 10),
                                Row(
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
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor,
                                            letterSpacing: 5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Transaction Type',
                                        style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: kTenBlackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        snapshot.data!.type == "add"
                                            ? "Pemasukan"
                                            : "Penarikan",
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                          color: kBlackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Jumlah Uang',
                                        style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: kTenBlackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Rp ' +
                                            snapshot.data!.jmlUang.toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                          color: kBlackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        'note',
                                        style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: kTenBlackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        snapshot.data!.note,
                                        style: GoogleFonts.roboto(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                          color: kBlackColor,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
