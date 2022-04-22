import 'package:flutter/material.dart';
import 'package:flutter_mona/constants/widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_mona/Screen/detail_transaction.dart';
import 'package:flutter_mona/Screen/search_screen.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/model/transactionmodel.dart';
import 'package:flutter_mona/services/auth_services.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Batal"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Apply"),
      onPressed: () {
        Navigator.pop(context, true);
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
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Row(
              children: [
                Text('Type',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )),
                const DropDownMenuFb1(
                  menuList: [
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.add, color: kButtonColor),
                        title: Text('Type'),
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(child: Text('Pemasukan')),
                    PopupMenuItem(child: Text('Pengeluaran')),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Text('Tanggal masukan',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )),
                const DropDownMenuFb1(
                  menuList: [
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(Icons.add, color: kButtonColor),
                        title: Text('Tanggal masukan'),
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem(child: Text('This week')),
                    PopupMenuItem(child: Text('This Month')),
                    PopupMenuItem(child: Text('This year')),
                  ],
                ),
              ],
            ),
          ],
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          children: [
            Center(
              child: Text('Transaksi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Search()));
                      },
                      child: Container(
                          padding: const EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.0)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.grey[500]!,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text('Search by note',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w300))
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const FittedBox(
                          child: Icon(Icons.filter_list, color: kTenBlackColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            FutureBuilder<List<Transaction>>(
              future: AuthServices.transaction(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 100,
                    child:
                        SpinKitRotatingCircle(color: kPrimaryColor, size: 25),
                  );
                } else {
                  return snapshot.data!.isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada transaksi',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kBlackColor,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailTransaction(
                                            id: int.parse(snapshot
                                                .data![index].id
                                                .toString()))));
                              },
                              child: Container(
                                height: 70,
                                margin: const EdgeInsets.only(bottom: 13),
                                padding: const EdgeInsets.only(
                                    left: 10, top: 12, bottom: 12, right: 22),
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
                                        snapshot.data![index].type == "add"
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
                                              snapshot.data![index].type ==
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
                                              snapshot.data![index].createdAt
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: kBlackColor,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].note,
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
                                          snapshot.data![index].type == "add"
                                              ? "+ Rp. " +
                                                  snapshot.data![index].jmlUang
                                                      .toString()
                                              : "- Rp. " +
                                                  snapshot.data![index].jmlUang
                                                      .toString(),
                                          // snapshot.data![index].jmlUang.toString(),
                                          style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: snapshot.data![index].type ==
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
                        );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
