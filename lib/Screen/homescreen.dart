import 'package:flutter/material.dart';
import 'package:flutter_mona/Screen/addtransactionscreen.dart';
import 'package:flutter_mona/Screen/dashboard.dart';
import 'package:flutter_mona/Screen/transactionscreen.dart';
import 'package:flutter_mona/constants/color_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final screen = [
    const Dashboard(),
    const AddTransactionScreen(),
    const TransactionsScreen(),
  ];

  final primaryColor = const Color(0xFFE3F2FD);
  final buttonColor = const Color(0xFF68E1FD);
  final secondaryColor = const Color(0x73000000);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = Colors.blue;

  final shadowColor = Colors.grey;
  double height = 60;
  double elevation = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBaseColor,
      body: screen[_selectedIndex],
      extendBody: true,
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: kWhiteColor,
          ),
          child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Center(
                    heightFactor: 0.1,
                    child: FloatingActionButton(
                        backgroundColor: kButtonColor,
                        child: const FittedBox(child: Icon(Icons.add_outlined)),
                        elevation: 1,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        }),
                  ),
                  SizedBox(
                    height: height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NavBarIcon(
                          text: "Home",
                          icon: Icons.home_outlined,
                          selected: _selectedIndex == 0,
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                          defaultColor: kTenBlackColor,
                          selectedColor: kButtonColor,
                        ),
                        const SizedBox(width: 56),
                        NavBarIcon(
                          text: "Calendar",
                          icon: Icons.payments,
                          selected: _selectedIndex == 2,
                          onPressed: () {
                            setState(() {
                              _selectedIndex = 2;
                            });
                          },
                          selectedColor: kButtonColor,
                          defaultColor: kTenBlackColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed,
      this.selectedColor = const Color(0xffFF8527),
      this.defaultColor = Colors.black54})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? selectedColor : defaultColor,
          ),
        ),
      ],
    );
  }
}
