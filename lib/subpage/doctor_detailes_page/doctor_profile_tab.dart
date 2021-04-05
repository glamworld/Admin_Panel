import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/subpage/doctor_detailes_page/doctor_profile.dart';
import 'package:admin_panel/subpage/doctor_detailes_page/all_prescription_page.dart';
import 'package:admin_panel/subpage/doctor_detailes_page/faq_page.dart';
import 'doctor_review_page.dart';
class DoctorOwnDetails extends StatefulWidget {
  String id;
  String fullName;
  String phone;
  String email;
  String about;
  String country;
  String state;
  String city;
  String gender;
  String specification;
  List<dynamic> optionalSpecification;
  String degree;
  String bmdcNumber;
  String appFee;
  String teleFee;
  String experience;
  String photoUrl;
  String totalPrescribe;
  String totalTeleFee;
  String countryCode;
  String currency;
  bool provideTeleService;
  List<dynamic> sat;
  List<dynamic> sun;
  List<dynamic> mon;
  List<dynamic> tue;
  List<dynamic> wed;
  List<dynamic> thu;
  List<dynamic> fri;

  DoctorOwnDetails(
      {this.id,
        this.fullName,
        this.phone,
        this.email,
        this.about,
        this.gender,
        this.country,
        this.state,
        this.city,
        this.specification,
        this.optionalSpecification,
        this.degree,
        this.bmdcNumber,
        this.appFee,
        this.teleFee,
        this.experience,
        this.photoUrl,
        this.totalPrescribe,
        this.totalTeleFee,
        this.provideTeleService,
        this.currency,
        this.countryCode,
        this.sat,
        this.fri,
        this.mon,
        this.sun,
        this.thu,
        this.tue,
        this.wed});
  @override
  _DoctorOwnDetailsState createState() => _DoctorOwnDetailsState();
}

class _DoctorOwnDetailsState extends State<DoctorOwnDetails> {
  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    FirebaseOperationProvider operation=Provider.of<FirebaseOperationProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffF4F7F5),
        appBar: AppBar(
          title: Text("Doctor Profile",style: TextStyle(
              fontSize: size.width * .040
          ),),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: size.width * .030
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.account_box,),
                  text: 'Profile',
                ),
                Tab(
                  icon: Icon(Icons.article_sharp,),
                  text: 'Prescribed',
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text: 'Feedback',
                ),
                Tab(
                  icon: Icon(Icons.announcement_outlined),
                  text: 'FAQs',
                ),

              ]),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(

              children: [
                DoctorProfile(
                  id: widget.id,
                  photoUrl:widget.photoUrl,
                  fullName:widget.fullName,
                  degree:widget.degree,
                  bmdcNumber:widget.bmdcNumber,
                  teleFee:widget.teleFee,
                  appFee:widget.appFee,
                  experience:widget.experience,
                  currency:widget.currency,
                  about:widget.about,
                  country:widget.country,
                  state:widget.state,
                  city:widget.city,
                  email:widget.email,
                  phone:widget.phone,
                  totalPrescribed: widget.totalPrescribe,
                  totalTeleFee: widget.totalTeleFee,
                  provideTeleService:widget.provideTeleService,
                  countryCode:widget.countryCode,
                  specification:widget.specification,
                  optionalSpecification:widget.optionalSpecification,
                  sat:widget.sat,
                  sun:widget.sun,
                  mon:widget.mon,
                  tue:widget.tue,
                  wed:widget.wed,
                  thu:widget.thu,
                  fri:widget.fri,

                ),
                AllPrescription(
                 id: widget.id
                ),
                Reviews(id: widget.id,),
                FAQPage(id: widget.id,),
              ]
          ),
        ),
      ),
    );
  }
}
