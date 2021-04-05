import 'package:admin_panel/pages/medicine_list.dart';
import 'package:admin_panel/pages/pending_medicines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MedicineTab extends StatefulWidget {
  @override
  _MedicineTabState createState() => _MedicineTabState();
}

class _MedicineTabState extends State<MedicineTab> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffF4F7F5),
        appBar: AppBar(
          title: Text("Medicines",style: TextStyle(
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
                  icon: Icon(Icons.account_box,),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(Icons.article_sharp,),
                  text: 'pending',
                ),

              ]),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(

              children: [
                MedicineList(),
                PendingMedicines()
              ]
          ),
        ),
      ),
    );
  }
}
