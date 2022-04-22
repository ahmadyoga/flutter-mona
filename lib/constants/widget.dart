// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_mona/constants/color_constant.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Category {
  final String title;
  bool isSelected;
  Category(this.title, this.isSelected);
}

List<Category> categoryList = [
  Category("Login", true),
  Category("Sign up", false),
];

class HorizontalCategoriesView extends StatefulWidget {
  const HorizontalCategoriesView({Key? key}) : super(key: key);

  @override
  State<HorizontalCategoriesView> createState() =>
      _HorizontalCategoriesViewState();
}

class _HorizontalCategoriesViewState extends State<HorizontalCategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: kShadowColor),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: categoryList[index],
            onPressed: (b) {
              // ignore: avoid_function_literals_in_foreach_calls
              categoryList.forEach((category) {
                category.isSelected = false;
              });
              setState(() {
                categoryList[index].isSelected = true;
              });
            },
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  final Category category;
  final Function(bool) onPressed;

  const CategoryCard(
      {required this.category, required this.onPressed, Key? key})
      : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.315,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:
                widget.category.isSelected ? kButtonColor : Colors.transparent),
        child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              widget.onPressed(true);
            },
            child: Text(widget.category.title,
                style: TextStyle(
                    color: widget.category.isSelected
                        ? kWhiteColor
                        : Colors.grey))),
      ),
    );
  }
}

Widget loading() {
  return ListView.builder(itemBuilder: (context, index) {
    return AlertDialog(
      content: Center(
        child: Container(
          height: 150,
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const SpinKitRotatingCircle(
            color: kPrimaryColor,
            size: 40.0,
          ),
        ),
      ),
    );
  });
}

Widget customInputFieldFb1(
    {onChanged, obscure = false, suffixIcon, hintText, keyboardType, label}) {
  return SizedBox(
    height: 50,
    child: TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
        fillColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: kShadowColor, width: 2.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kShadowColor, width: 2.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kShadowColor, width: 2.0),
        ),
      ),
    ),
  );
}

class DropDownMenuFb1 extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Color color;
  final Widget icon;
  const DropDownMenuFb1(
      {required this.menuList,
      this.color = Colors.white,
      this.icon = const Icon(
        Icons.arrow_drop_down,
        color: kButtonColor,
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => menuList,
    );
  }
}

Widget roudedsearch({onChanged, textController, hintText}) {
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          offset: const Offset(12, 26),
          blurRadius: 50,
          spreadRadius: 0,
          color: Colors.grey.withOpacity(.1)),
    ]),
    child: TextField(
      controller: textController,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[500]!,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(45.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(45.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(45.0)),
        ),
      ),
    ),
  );
}

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 5)));
}

errorSnackBar2(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      content: Text('gagal mengambil transaksi'),
      duration: Duration(seconds: 5)));
}

successSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 5)));
}
