import 'package:admin_panel/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_panel/model/medicine_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/notification_widget.dart';

class MedicineProvider extends AuthProvider{

  MedicineModel _medicineModel = MedicineModel();
  List<MedicineModel> _medicineList = [];
  List<MedicineModel> _pendingMedicineList = [];

  get medicineModel=> _medicineModel;
  get medicineList=> _medicineList;
  get pendingMedicineList=> _pendingMedicineList;

  set medicineModel(MedicineModel model){
    model = MedicineModel();
    _medicineModel = model;
    notifyListeners();
  }

  Future<void> getMedicine()async{
    try{
      await FirebaseFirestore.instance.collection('Medicines').where('state',isEqualTo: 'approved').get().then((snapshot){
        _medicineList.clear();
        snapshot.docChanges.forEach((element) {
          MedicineModel medicineModel = MedicineModel(
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
            state: element.doc['state']
          );
          print('executed');
          _medicineList.add(medicineModel);
        });
      });
      notifyListeners();
    }catch(error){}
  }

  Future<void> getPendingMedicine()async{
    try{
      await FirebaseFirestore.instance.collection('Medicines').where('state',isEqualTo: 'pending').get().then((snapshot){
        _pendingMedicineList.clear();
        snapshot.docChanges.forEach((element) {
          MedicineModel medicineModel = MedicineModel(
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
            state: element.doc['state']
          );
          _pendingMedicineList.add(medicineModel);

        });
      });
      notifyListeners();

    }catch(error){}
  }

  Future<void> submitMedicine(MedicineProvider provider,BuildContext context, GlobalKey<ScaffoldState> scaffoldKey)async{
    AuthProvider auth = Provider.of<AuthProvider>(context,listen: false);
    final String phone= await auth.getPreferenceId();
    String phoneNo = '0'+phone;
    final String id= provider.medicineModel.name+DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection('Medicines').doc(id).set({
      'id':id,
      'name':provider.medicineModel.name,
      'strength':provider.medicineModel.strength,
      'genericName':provider.medicineModel.genericName,
      'dosage':provider.medicineModel.dosage,
      'manufacturer':provider.medicineModel.manufacturer,
      'price':provider.medicineModel.price,
      'indications':provider.medicineModel.indications,
      'adultDose':provider.medicineModel.adultDose,
      'childDose':provider.medicineModel.childDose,
      'representativePhone': phoneNo,
      'renalDose':provider.medicineModel.renalDose,
      'administration':provider.medicineModel.administration,
      'contradiction':provider.medicineModel.contradiction,
      'sideEffect':provider.medicineModel.sideEffect,
      'precautions':provider.medicineModel.precautions,
      'pregnancy':provider.medicineModel.pregnancy,
      'therapeutic':provider.medicineModel.therapeutic,
      'modeOfAction':provider.medicineModel.modeOfAction,
      'interaction':provider.medicineModel.interaction,
      'darNo':provider.medicineModel.darNo,
      'state':'approved',
    }).then((value)async{

        Navigator.pop(context);
        Navigator.pop(context);
        showAlertDialog(context, 'Medicine submitted successfully');
    },onError: (error){
      Navigator.pop(context);
      showSnackBar(scaffoldKey, error.toString());
    });
  }

  Future<void> updatePendingMedicine(GlobalKey<ScaffoldState> scaffoldKey, String id, BuildContext context, MedicineProvider provider)async
  {
    FirebaseFirestore.instance.collection('Medicines').doc(id).update({
      'state': 'approved',

    }).then((value)async{
      Navigator.pop(context);
      Navigator.pop(context);
      showAlertDialog(context, 'Medicine approved');
      notifyListeners();
    });

  }

}