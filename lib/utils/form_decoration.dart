import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const FormDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.white,
  // hintText: "Enter Mobile Number",
  // prefixIcon: Icon(Icons.phone_iphone),
  border: InputBorder.none,
  filled: true,
);

const FormDecorationWithoutPrefix = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.white,
  hintText: "Write Title",
  border: InputBorder.none,
  filled: true,
);

const modalDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

// ignore: non_constant_identifier_names
Widget Button(BuildContext context, String ButtonName) {
  Size size = MediaQuery.of(context).size;
  return Material(
    elevation: 0,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        ButtonName,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: size.width / 20),
      ),
    ),
  );
}

whiteButton(BuildContext context, String ButtonName) {
  Size size = MediaQuery.of(context).size;
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    child: Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Text(
        ButtonName,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: size.width / 20),
      ),
    ),
  );
}

Widget outlineIconButton(
    BuildContext context, IconData iconData, String buttonName, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: color),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 16,
          color: color,
        ),
        SizedBox(width: 5),
        Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 13, color: color),
        )
      ],
    ),
  );
  }

Widget bigOutlineIconButton(
    BuildContext context, IconData iconData, String buttonName, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: color),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 22,
          color: color,
        ),
        SizedBox(width: 5),
        Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 17, color: color),
        )
      ],
    ),
  );
}


Widget miniOutlineButton(
    BuildContext context, String buttonName, Color color) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: color),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Text(
      buttonName,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: size.width*.03, color: color),
    ),
  );
}

Widget miniOutlineIconButton(
    BuildContext context, String buttonName,  IconData iconData, Color color) {
  Size size = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: color),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData,color: color,size: size.width*.04),
        SizedBox(width: 5),
        Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: size.width*.03, color: color),
        ),
      ],
    ),
  );
}

Widget socialButton(
    BuildContext context, String iconUrl, String buttonName, Color color) {
  return Container(
    width: 150,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
        border: Border.all(width: 2, color: color),
        borderRadius: BorderRadius.all(Radius.circular(5))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(iconUrl,height: 18,),
        SizedBox(width: 8),
        Text(
          buttonName,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: color),
        )
      ],
    ),
  );
}
final simpleCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: [
      BoxShadow(color: Colors.grey[300], offset: Offset(1, 1), blurRadius: 2)
    ]);
final cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: [
      BoxShadow(blurRadius: 2, offset: Offset(0.3, 0.5), color: Colors.grey)
    ]);
