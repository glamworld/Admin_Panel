import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/subpage/discount_shop_payment.dart';
import 'package:admin_panel/subpage/appointment_payment.dart';
class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffF4F7F5),
        appBar: AppBar(
          title: Text("Payment details",style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .040
          ),),
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              isScrollable: true,
              labelStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .035
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.house,),
                  text: 'DiscountShop Payment',
                ),
                Tab(
                  icon: Icon(Icons.book_online,),
                  text: 'Appointment Payment',
                ),

              ]),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(

              children: [
                DiscountShopPayment(),
                AppointmentPayment(),
              ]
          ),
        ),
      ),
    );
  }
}
