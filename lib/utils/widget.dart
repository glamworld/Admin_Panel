import 'package:flutter/material.dart';

simpleTextStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize: 16,
  );
}
colonTextStyle(){
  return TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Color(0xff00C5A4),
  );
}
boldTextStyle(){
  return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
  );
}
smallTextStyle(){
  return TextStyle(
      fontSize: 14,
  );
}
doctorListTextStyle(){
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
mainAppBar(String _title){
  return AppBar(
    title: Text(_title),
    backgroundColor: Color(0xff00C5A4),
    centerTitle: true,
  );
}

formInputTextField(String textFieldHintText){
  return  TextField(
    decoration: InputDecoration(
      hintText: textFieldHintText,

      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          ),

    ),
  );
}
mainGridStyle(String image,String directoryName){
  return Container(
    padding: EdgeInsets.all(5),
    child:Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: AssetImage(image),
                      alignment: Alignment.topCenter
                  )
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(directoryName,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(0xff00C5A4)),),

            ],
          )
        ],
      ),
    ),
  );
}
subGridStyle(String image,String directoryName){
  return Container(
    padding: EdgeInsets.all(5),
    child:Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: AssetImage(image),
                      alignment: Alignment.topCenter
                  )
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Text(directoryName,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Color(0xff00C5A4)),textAlign: TextAlign.center,),

            ],
          )
        ],
      ),
    ),
  );
}
//appoint Button
doctorAppointment(appointment,appointmentDetails){
  return Column(
    children: [

      Container(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(appointment),
      ),
      Text(appointmentDetails,textAlign: TextAlign.center),
    ],
  );
}

//heading
greyHeadingDecoration(context,headingText){
  Size size=MediaQuery.of(context).size;
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      width: size.width*.98,
      child: Text(headingText,style: colonTextStyle(),textAlign: TextAlign.center,),
      decoration: BoxDecoration(
        color: Color(0xffF4F7F5),
      )
  );
}

whiteHeadingDecoration(context,headingText){
  Size size=MediaQuery.of(context).size;
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      width: size.width*.98,
      child: Text(headingText,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
      decoration: BoxDecoration(
        color: Color(0xff00C5A4),
      )
  );
}



//Shopping Heading Decoration

shoppingHeadingDecoration(context,headingText){
  Size size=MediaQuery.of(context).size;
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      width: size.width*.98,
      child: Text(headingText,style: colonTextStyle(),textAlign: TextAlign.center,),
      decoration: BoxDecoration(
        color: Color(0xffF4F7F5),
      )
  );
}
headingDecoration(context,headingText,Color backColor,Color textColor){
  Size size=MediaQuery.of(context).size;
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      width: size.width,
      child: Text(headingText,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: textColor),textAlign: TextAlign.center,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backColor,
      )
  );
}
headingDecorationUnsized(context,headingText,Color backColor,Color textColor){
  Size size=MediaQuery.of(context).size;

  return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      width: size.width,
      child: Text(headingText,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: textColor),textAlign: TextAlign.center,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backColor,
      )
  );
}

InputDecoration shoppingFormInputDecoration(String hintText){
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      fillColor: Colors.white,
      filled: true,
      hintText:hintText
  );
}
