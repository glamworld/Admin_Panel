import 'package:admin_panel/model/medicine_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_panel/model/manufacturer-representator_model.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:flutter/material.dart';

import '../notification_widget.dart';

class RepresentativeProvider extends AuthProvider{
  ManufacturerRepresentativeModel _manufacturerRepresentativeModel = ManufacturerRepresentativeModel();
  List<ManufacturerRepresentativeModel> _representativeList = List<ManufacturerRepresentativeModel>();
  List<MedicineModel> _representativeMedicineList = List<MedicineModel>();


  bool _isLoading = false;
  String _loadingMgs;

  get manufacturerRepresentativeModel => _manufacturerRepresentativeModel;
  get representativeList => _representativeList;
  get representativeMedicineList=> _representativeMedicineList;
  get isLoading => _isLoading;
  get loadingMgs => _loadingMgs;

  set manufacturerRepresentativeModel(
      ManufacturerRepresentativeModel representativeModel) {
    representativeModel = ManufacturerRepresentativeModel();
    _manufacturerRepresentativeModel = representativeModel;
    notifyListeners();
  }
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set loadingMgs(String val) {
    _loadingMgs = val;
    notifyListeners();
  }

  Future<bool> addRepresentative(
      ManufacturerRepresentativeModel representativeModel,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context,RepresentativeProvider operation) async {
    final id = representativeModel.phoneNumber + DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    try {
      String date = DateFormat("dd-MMM-yyyy/hh:mm:aa").format(DateTime.
      fromMicrosecondsSinceEpoch(DateTime
          .now()
          .microsecondsSinceEpoch));
      FirebaseFirestore.instance.collection('Representative').doc(id).set({
        'id': id,
        'representativeName': representativeModel.representativeName,
        'companyName': representativeModel.companyName,
        'phoneNumber': representativeModel.phoneNumber,
        'password': representativeModel.password,
        'email': representativeModel.email,
        'nid': representativeModel.nid,
        'dob': representativeModel.dob,
        'address': representativeModel.address,
        'executiveName': representativeModel.executiveName,
        'executivePhone': representativeModel.executivePhone,
        'date': date
      }).then((value) async{
        await operation.getRepresentative().then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
          showAlertDialog(context, 'Representative added');
        });
      }, onError: (error) {
        Navigator.pop(context);
        showSnackBar(scaffoldKey, error.toString());
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ManufacturerRepresentativeModel>> getRepresentative()async{

    try{
      await FirebaseFirestore.instance.collection('Representative').get().then((snapshot) {
        _representativeList.clear();
        snapshot.docChanges.forEach((element) {
          ManufacturerRepresentativeModel representatives = ManufacturerRepresentativeModel(
            id: element.doc['id'],
            representativeName: element.doc['representativeName'],
            companyName: element.doc['companyName'],
            phoneNumber: element.doc['phoneNumber'],
            password: element.doc['password'],
            email: element.doc['email'],
            nid: element.doc['nid'],
            dob: element.doc['dob'],
            address: element.doc['address'],
            executiveName: element.doc['executiveName'],
            executivePhone: element.doc['executivePhone'],
            date: element.doc['date'],
          );
          _representativeList.add(representatives);
          //print(_representativeList.length);
        });
      });
      notifyListeners();
      loadingMgs = '';
    }catch(error){
      print(error.toString());
      loadingMgs = '';
    }
  }

  Future<bool> deleteRepresentative(String id,BuildContext context,GlobalKey<ScaffoldState> scaffoldKey,RepresentativeProvider operation)async{
    await FirebaseFirestore.instance.collection('Representative').doc(id).delete().then((value) async{
      await operation.getRepresentative().then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
        showSnackBar(scaffoldKey, 'Representative deleted');
      });
    },onError: (error){
      Navigator.pop(context);
      //showSnackBar(scaffoldKey, error.toString());
    });
  }

  Future<void> getRepresentativeMedicine(String phone)async{

    try{
      await FirebaseFirestore.instance.collection('Medicines').where('representativePhone',isEqualTo: phone).get().then((snapshot) {
        _representativeMedicineList.clear();
        snapshot.docChanges.forEach((element) {
          MedicineModel medicines = MedicineModel(
            id: element.doc['id'],
            name: element.doc['name'],
            strength: element.doc['strength'],
            genericName: element.doc['genericName'],
            dosage: element.doc['dosage'],
            manufacturer: element.doc['manufacturer'],
            price: element.doc['price'],
            indications: element.doc['indications'],
            adultDose: element.doc['adultDose'],
            childDose: element.doc['childDose'],
            renalDose: element.doc['renalDose'],
            representativePhone: element.doc['representativePhone'],
            administration: element.doc['administration'],
            contradiction: element.doc['contradiction'],
            sideEffect: element.doc['sideEffect'],
            precautions: element.doc['precautions'],
            pregnancy: element.doc['pregnancy'],
            therapeutic: element.doc['therapeutic'],
            modeOfAction: element.doc['modeOfAction'],
            interaction: element.doc['interaction'],
            darNo: element.doc['darNo'],
          );
          _representativeMedicineList.add(medicines);
        });
      });
      notifyListeners();
      loadingMgs = '';
    }catch(error){
      print(error.toString());
      loadingMgs = '';
    }
  }



}