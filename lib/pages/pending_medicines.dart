import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/providers/medicine_provider.dart';
import 'package:admin_panel/model/medicine_model.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/subpage/pending_medicine_details.dart';

class PendingMedicines extends StatefulWidget {
  @override
  _PendingMedicinesState createState() => _PendingMedicinesState();
}

class _PendingMedicinesState extends State<PendingMedicines> {

  List<MedicineModel> pendingMedicineList=[];
  @override
  Widget build(BuildContext context) {
    final MedicineProvider provider = Provider.of<MedicineProvider>(context);
    return Scaffold(
      body: _bodyUI(provider),
    );
  }

  Widget _bodyUI(MedicineProvider provider) {
    return RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: ()=>provider.getPendingMedicine(),
    child: ListView.builder(
    itemCount: provider.pendingMedicineList.length,
    itemBuilder: (BuildContext context, int index) {
      return MedicineTile(
        id: provider.pendingMedicineList[index].id,
        name: provider.pendingMedicineList[index].name,
        strength: provider.pendingMedicineList[index].strength,
        genericName: provider.pendingMedicineList[index].genericName,
        dosage: provider.pendingMedicineList[index].dosage,
        manufacturer: provider.pendingMedicineList[index].manufacturer,
        price: provider.pendingMedicineList[index].price,
        indications: provider.pendingMedicineList[index].indications,
        adultDose: provider.pendingMedicineList[index].adultDose,
        childDose: provider.pendingMedicineList[index].childDose,
        renalDose: provider.pendingMedicineList[index].renalDose,
        administration: provider.pendingMedicineList[index].administration,
        contradiction: provider.pendingMedicineList[index].contradiction,
        sideEffect: provider.pendingMedicineList[index].sideEffect,
        precautions: provider.pendingMedicineList[index].precautions,
        pregnancy: provider.pendingMedicineList[index].pregnancy,
        therapeutic: provider.pendingMedicineList[index].therapeutic,
        modeOfAction: provider.pendingMedicineList[index].modeOfAction,
        interaction: provider.pendingMedicineList[index].interaction,
        darNo: provider.pendingMedicineList[index].darNo,
      );
    })
  );

  }

}

// ignore: must_be_immutable
class MedicineTile extends StatelessWidget {
  String id;
  String name;
  String strength;
  String genericName;
  String dosage;
  String manufacturer;
  String price;
  String indications;
  String adultDose;
  String childDose;
  String renalDose;
  String administration;
  String contradiction;
  String sideEffect;
  String precautions;
  String pregnancy;
  String therapeutic;
  String modeOfAction;
  String interaction;
  String darNo;
  MedicineTile({
    this.id,
    this.name,
    this.strength,
    this.genericName,
    this.dosage,
    this.manufacturer,
    this.price,
    this.indications,
    this.adultDose,
    this.childDose,
    this.renalDose,
    this.administration,
    this.contradiction,
    this.sideEffect,
    this.precautions,
    this.pregnancy,
    this.therapeutic,
    this.modeOfAction,
    this.interaction,
    this.darNo});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], offset: Offset(1, 1), blurRadius: 2)
            ]),
        child: ListTile(
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingMedicineDetails(
            id: id,
              name:name,
              strength:strength,
              genericName:genericName,
              dosage:dosage,
              manufacturer:manufacturer,
              price:price,
              indications:indications,
              adultDose:adultDose,
              childDose:childDose,
              renalDose:renalDose,
              administration:administration,
              contradiction:contradiction,
              sideEffect:sideEffect,
              precautions:precautions,
              pregnancy:pregnancy,
              therapeutic:therapeutic,
              modeOfAction:modeOfAction,
              interaction:indications,
              darNo:darNo
          )
          )),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                style: TextStyle(fontSize: 17, color: Colors.grey[900]),
              ),
              SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '$strength mg',
                  maxLines: 1,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                genericName,
                maxLines: 1,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),

              Text(
                dosage,
                maxLines: 1,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '৳ $price',
                maxLines: 1,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),

              SizedBox(
                height: 2,
              ),
              Text(
                manufacturer,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ));
  }
}