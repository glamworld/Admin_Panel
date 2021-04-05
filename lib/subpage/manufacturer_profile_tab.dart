import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/subpage/manufacturer_add_medicine_list.dart';
import 'package:admin_panel/subpage/manufacturer_representator_profile.dart';

class ManufacturerProfileTab extends StatefulWidget {
  String companyName;
  String representatorName;
  String date;
  String phoneNumber;
  String address;
  String email;
  ManufacturerProfileTab(
      {this.companyName,
        this.representatorName,
        this.date,
        this.phoneNumber,
        this.address,
        this.email
      }
      );
  @override
  _ManufacturerProfileTabState createState() => _ManufacturerProfileTabState();
}

class _ManufacturerProfileTabState extends State<ManufacturerProfileTab> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Representative Profile",style: TextStyle(
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
                  text: 'Add Medicine Details',
                ),

              ]),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(

              children: [
                ManufacturerRepresentatorProfile(
                  companyName:widget.companyName,
                  representatorName:widget.representatorName,
                  date:widget.date,
                  phoneNumber:widget.phoneNumber,
                  address:widget.address,
                  email: widget.email,
                ),
                ManufacturerRepresentativeDetails(representativePhone: widget.phoneNumber,),
              ]
          ),
        ),
      ),
    );
  }
}
