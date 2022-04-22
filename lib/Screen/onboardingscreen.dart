import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/loginscreen.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_mona/model/data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final CarouselController _carouselController = CarouselController();
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                width: 15,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 45,
                          width: 45,
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
                            fontSize: 22,
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
              const SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                        height: 500,
                        viewportFraction: 1.0,
                        // enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        onPageChanged: (index, _) {
                          setState(() {
                            currentSlider = index;
                          });
                        }),
                    items: data.map((e) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxHeight: double.infinity,
                        ),
                        // color: Colors.white,
                        padding:
                            const EdgeInsets.only(left: 24, top: 12, right: 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(e['image'], height: 250),
                            const SizedBox(height: 30),
                            Text(e['title'],
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              e['deskripsi'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CarouselIndicator(activePage: currentSlider),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: 40,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white),
                      left: BorderSide(color: Colors.white),
                      right: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: 80,
                    height: 50,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    color: kButtonColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Yuk Atur Keuanganmu',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({Key? key, required this.activePage})
      : super(key: key);

  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [0, 1, 2].map((e) {
            return Container(
                height: 6,
                width: (e == activePage) ? 28 : 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: (e == activePage) ? kWhiteColor : kShadowColor,
                ));
          }).toList(),
        ),
      ),
    );
  }
}
