import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/detail_transaction.dart';
import 'package:flutter_mona/Screen/userscreen.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/services/auth_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_mona/model/dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, dash}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColor,
      body: SafeArea(
        child: FutureBuilder<Dash>(
          future: AuthServices.dashboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: const SpinKitRotatingCircle(
                    color: kPrimaryColor,
                    size: 35.0,
                  ),
                ),
              );
            } else {
              return ListView(
                children: <Widget>[
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            margin: const EdgeInsets.only(top: 0),
                            child: SvgPicture.asset('assets/svg/backdrop.svg')),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          const SizedBox(
                            height: 295,
                            width: double.infinity,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Hi There',
                                      style: GoogleFonts.roboto(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                  Text('Welcome To MONA',
                                      style: GoogleFonts.roboto(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 25,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserScreen()));
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const FittedBox(
                                  child: Icon(Icons.account_circle,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Container(
                                  height: 120,
                                  padding: const EdgeInsets.only(
                                      left: 25, top: 12, bottom: 12, right: 25),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [kWhiteColor, kBaseColor]),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const FittedBox(
                                                      child: Icon(
                                                          Icons.payments,
                                                          color: kButtonColor),
                                                    ),
                                                  ),
                                                  Text('Saldo',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: kBlackColor,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Rp. ' +
                                                          snapshot.data!.balance
                                                              .toString(),
                                                      style: GoogleFonts.inter(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: kBlackColor),
                                                    ),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child:
                                                              const FittedBox(
                                                            child: Icon(
                                                                Icons
                                                                    .add_circle_outlined,
                                                                color:
                                                                    kButtonColor),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    213,
                                                                    235,
                                                                    253),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          213,
                                                                          235,
                                                                          253),
                                                                  blurRadius: 3,
                                                                  spreadRadius:
                                                                      0.1),
                                                            ],
                                                          ),
                                                          child:
                                                              const FittedBox(
                                                            child: Icon(
                                                                Icons
                                                                    .file_download_outlined,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 20,
                                                          width: 20,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    216,
                                                                    213),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          216,
                                                                          213),
                                                                  blurRadius: 3,
                                                                  spreadRadius:
                                                                      0.1),
                                                            ],
                                                          ),
                                                          child:
                                                              const FittedBox(
                                                            child: Icon(
                                                                Icons
                                                                    .file_upload_outlined,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, bottom: 20, top: 29, right: 10),
                    child: Text('Transaksi Terbaru',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  snapshot.data!.transaksi.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Center(
                                child: Text('tidak ada transaksi Terbaru',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.transaksi.length,
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailTransaction(
                                            id: int.parse(snapshot
                                                .data!.transaksi[index].id
                                                .toString()))));
                              },
                              child: Container(
                                height: 70,
                                margin: const EdgeInsets.only(bottom: 13),
                                padding: const EdgeInsets.only(
                                    left: 13, top: 12, bottom: 12, right: 22),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        snapshot.data!.transaksi[index].type ==
                                                "add"
                                            ? Container(
                                                height: 40,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromARGB(
                                                      255, 213, 235, 253),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 213, 235, 253),
                                                        blurRadius: 3,
                                                        spreadRadius: 0.1),
                                                  ],
                                                ),
                                                child: const Icon(
                                                    Icons
                                                        .file_download_outlined,
                                                    color: Colors.blue),
                                              )
                                            : Container(
                                                height: 35,
                                                width: 35,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromARGB(
                                                      255, 255, 216, 213),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Color.fromARGB(
                                                            255, 255, 216, 213),
                                                        blurRadius: 3,
                                                        spreadRadius: 0.1),
                                                  ],
                                                ),
                                                child: const Icon(
                                                    Icons.file_upload_outlined,
                                                    color: Colors.red),
                                              ),
                                        const SizedBox(
                                          width: 13,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              snapshot.data!.transaksi[index]
                                                          .type ==
                                                      "add"
                                                  ? "Pemasukan"
                                                  : "Penarikan",
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: kBlackColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              snapshot.data!.transaksi[index]
                                                  .createdAt
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: kBlackColor,
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.transaksi[index].note,
                                              style: GoogleFonts.inter(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: kBlackColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data!.transaksi[index]
                                                      .type ==
                                                  "add"
                                              ? "+ Rp. " +
                                                  snapshot.data!
                                                      .transaksi[index].jmlUang
                                                      .toString()
                                              : "- Rp. " +
                                                  snapshot.data!
                                                      .transaksi[index].jmlUang
                                                      .toString(),
                                          // snapshot.data!.transaksi[index].jmlUang.toString(),
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: snapshot
                                                        .data!
                                                        .transaksi[index]
                                                        .type ==
                                                    "add"
                                                ? kPrimaryColor
                                                : kRedColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
