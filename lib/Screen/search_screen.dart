import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/detail_transaction.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/constants/widget.dart';
import 'package:flutter_mona/model/transactionmodel.dart';
import 'package:flutter_mona/services/auth_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Transaction> transactionOnsearch = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          children: [
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
                  return Column(
                    children: [
                      SizedBox(
                          height: 50,
                          child: roudedsearch(
                              hintText: 'Search by note',
                              textController: _textEditingController,
                              onChanged: (value) {
                                transactionOnsearch = snapshot.data!
                                    .where((element) => element.note
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                              })),
                      const SizedBox(
                        height: 20,
                      ),
                      transactionOnsearch.isEmpty
                          ? Text(
                              'Transaksi tidak ditemukan',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: kBlackColor,
                              ),
                            )
                          : Column(
                              children: [
                                ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: transactionOnsearch.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailTransaction(
                                                        id: int.parse(snapshot
                                                            .data![index].id
                                                            .toString()))));
                                      },
                                      child: Container(
                                        height: 70,
                                        margin:
                                            const EdgeInsets.only(bottom: 13),
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            top: 12,
                                            bottom: 12,
                                            right: 22),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                transactionOnsearch[index]
                                                            .type ==
                                                        "add"
                                                    ? Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color.fromARGB(
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
                                                        child: const Icon(
                                                            Icons
                                                                .file_download_outlined,
                                                            color: Colors.blue),
                                                      )
                                                    : Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color.fromARGB(
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
                                                        child: const Icon(
                                                            Icons
                                                                .file_upload_outlined,
                                                            color: Colors.red),
                                                      ),
                                                const SizedBox(
                                                  width: 13,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(
                                                      transactionOnsearch[index]
                                                                  .type ==
                                                              "add"
                                                          ? "Pemasukan"
                                                          : "Penarikan",
                                                      style: GoogleFonts.inter(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: kBlackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      snapshot.data![index]
                                                          .createdAt
                                                          .toString(),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kBlackColor,
                                                      ),
                                                    ),
                                                    Text(
                                                      transactionOnsearch[index]
                                                          .note,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                  transactionOnsearch[index]
                                                              .type ==
                                                          "add"
                                                      ? "+ Rp. " +
                                                          snapshot.data![index]
                                                              .jmlUang
                                                              .toString()
                                                      : "- Rp. " +
                                                          snapshot.data![index]
                                                              .jmlUang
                                                              .toString(),
                                                  // transactionOnsearch[index].jmlUang.toString(),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: transactionOnsearch[
                                                                    index]
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
                            ),
                    ],
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
