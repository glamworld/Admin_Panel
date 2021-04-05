import 'package:admin_panel/utils/widget.dart';
import 'package:flutter/material.dart';

class ManufacturerRepresentatorProfile extends StatefulWidget {
  String companyName;
  String representatorName;
  String date;
  String phoneNumber;
  String address;
  String email;
  ManufacturerRepresentatorProfile(
      {this.companyName,
        this.representatorName,
        this.date,
        this.phoneNumber,
        this.address,
        this.email
      }
      );
  @override
  _ManufacturerRepresentatorProfileState createState() => _ManufacturerRepresentatorProfileState();
}

class _ManufacturerRepresentatorProfileState extends State<ManufacturerRepresentatorProfile> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyUI(),
    );
  }
  Widget _bodyUI(){
    Size size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.0,),
      child: Column(
        children: [
          SizedBox(height: 8.0,),
          Container(

              width: size.width,
              padding: EdgeInsets.only(left: 10,right: 5,top: 10,bottom: 10),
              decoration: BoxDecoration(
                //color: Color(0xff00C5A4),
                color: Color(0xffF4F7F5),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name : ${widget.representatorName??''}',maxLines:2,style: TextStyle(fontSize: size.width*.05,color: Colors.grey[900])),
                  Text('Joining Date : ${widget.date??''}',maxLines:1,style:  TextStyle(fontSize: size.width*.036,color: Colors.grey[600])),
                  Text('Company Name : ${widget.companyName??''}',maxLines:2,style: TextStyle(fontSize: size.width*.043,color: Colors.grey[800])),
                  Text('Phone : ${widget.phoneNumber??''}',maxLines:1,style: TextStyle(fontSize: size.width*.047,color: Colors.grey[800])),
                  widget.email!=null?Text('Email : ${widget.email}',maxLines:2,style: TextStyle(fontSize: size.width*.040,color: Colors.grey[900])):Text(''),
                  Text('Address : ${widget.address??''}',maxLines:2,style: TextStyle(fontSize: size.width*.039,color: Colors.grey[900]),),
                ],
              )
          ),
        ],
      ),
    );
  }
}
