import 'package:admin_panel/subpage/patient_details/patient_appointment_list.dart';
import 'package:admin_panel/subpage/patient_details/patient_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientProfileTab extends StatefulWidget {
  String id;
  String image;
  String name;
  String joinDate;
  String age;
  String phoneNum;
  String email;
  String gender;
  String address;
  String bloodGroup;
  PatientProfileTab(
      {this.id,
        this.image,
        this.name,
        this.joinDate,
        this.age,
        this.phoneNum,
        this.email,
        this.gender,
        this.address,
        this.bloodGroup,
      }
      );
  @override
  _PatientProfileTabState createState() => _PatientProfileTabState();
}

class _PatientProfileTabState extends State<PatientProfileTab> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,

      child: Scaffold(

        appBar: AppBar(
          title: Text("Patient Profile",style: TextStyle(
              fontSize: size.width * .040
          ),),
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: size.width * .035
              ),
              tabs: [
                Tab(
                  text: 'Profile',
                ),
                Tab(
                  text: 'Appointment List',
                ),

              ]),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(

              children: [
                PatientsProfile(
                  name:widget.name,
                  image: widget.image,
                  date:widget.joinDate,
                  age:widget.age,
                  phoneNum:widget.phoneNum,
                  email:widget.email,
                  gender:widget.gender,
                  address:widget.address,
                  bloodGroup:widget.bloodGroup,
                ),
                PatientAppointmentList(id: widget.id),
              ]
          ),
        ),
      ),
    );
  }
}