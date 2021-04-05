import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/model/appointment_model.dart';


class AppointmentProvider extends AuthProvider{
  AppointmentDetailsModel _prescriptionModel= AppointmentDetailsModel();

  List<String> _prescribedMedicineList = List<String>();

  List<AppointmentDetailsModel> _appointmentList = List<AppointmentDetailsModel>();
  List<AppointmentDetailsModel> _prescriptionList = List<AppointmentDetailsModel>();

  get prescribedMedicineList=> _prescribedMedicineList;

  get appointmentList => _appointmentList;

  get prescriptionList => _prescriptionList;

  void addMedicine(String value){
    _prescribedMedicineList.add(value);
    notifyListeners();
  }
  void clearPrescribedMedicineList(){
    _prescribedMedicineList.clear();
    notifyListeners();
  }

  get prescriptionModel=> _prescriptionModel;

  set prescriptionModel(AppointmentDetailsModel model){
    model= AppointmentDetailsModel();
    _prescriptionModel=model;
    notifyListeners();
  }


  Future<void> getAppointmentList(String docId)async{
    try{
        await FirebaseFirestore.instance.collection('AppointmentList').where('drId',isEqualTo: docId).orderBy('timeStamp',descending: true).get().then((snapshot){
          _appointmentList.clear();
          snapshot.docChanges.forEach((element) {
            if(element.doc['prescribeState']=='no'){
              AppointmentDetailsModel appointmentDetailsModel=AppointmentDetailsModel(
                id: element.doc['id'],
                drId: element.doc['drId'],
                drName: element.doc['drName'],
                drPhotoUrl: element.doc['drPhotoUrl'],
                drDegree: element.doc['drDegree'],
                drEmail: element.doc['drEmail'],
                drAddress: element.doc['drAddress'],
                specification: element.doc['specification'],
                appFee: element.doc['appFee'],
                teleFee: element.doc['teleFee'],
                currency: element.doc['currency'],
                prescribeDate: element.doc['prescribeDate'],
                prescribeState: element.doc['prescribeState'],
                pId: element.doc['pId'],
                pName: element.doc['pName'],
                pPhotoUrl: element.doc['pPhotoUrl'],
                pAddress: element.doc['pAddress'],
                pAge: element.doc['pAge'],
                pGender: element.doc['pGender'],
                pProblem: element.doc['pProblem'],
                actualProblem: element.doc['actualProblem'],
                bookingDate: element.doc['bookingDate'],
                appointDate: element.doc['appointDate'],
                chamberName: element.doc['chamberName'],
                chamberAddress: element.doc['chamberAddress'],
                bookingSchedule: element.doc['bookingSchedule'],
                rx: element.doc['rx'],
                advice: element.doc['advice'],
                nextVisit: element.doc['nextVisit'],
                paymentState: element.doc['paymentState'],
                appointState: element.doc['appointState'],
                medicines: element.doc['medicines'],
                timeStamp: element.doc['timeStamp'],
                reviewStar: element.doc['reviewStar'],
                reviewComment: element.doc['reviewComment'],
                reviewDate: element.doc['reviewDate'],
                reviewTimeStamp: element.doc['reviewTimeStamp'],
                prescribeNo: element.doc['prescribeNo']
              );
              _appointmentList.add(appointmentDetailsModel);
            }
          });
        });
      notifyListeners();
      print(_appointmentList.length);
    }catch(error){}
  }

  Future<void> getPrescriptionList(String docId)async{
    try{
        await FirebaseFirestore.instance.collection('AppointmentList').where('drId',isEqualTo: docId).get().then((snapshot){
          _prescriptionList.clear();
          snapshot.docChanges.forEach((element) {
            if(element.doc['prescribeState']=='yes'){
              AppointmentDetailsModel appointmentDetailsModel=AppointmentDetailsModel(
                id: element.doc['id'],
                drId: element.doc['drId'],
                drName: element.doc['drName'],
                drPhotoUrl: element.doc['drPhotoUrl'],
                drDegree: element.doc['drDegree'],
                drEmail: element.doc['drEmail'],
                drAddress: element.doc['drAddress'],
                specification: element.doc['specification'],
                appFee: element.doc['appFee'],
                teleFee: element.doc['teleFee'],
                currency: element.doc['currency'],
                prescribeDate: element.doc['prescribeDate'],
                prescribeState: element.doc['prescribeState'],
                pId: element.doc['pId'],
                pName: element.doc['pName'],
                pPhotoUrl: element.doc['pPhotoUrl'],
                pAddress: element.doc['pAddress'],
                pAge: element.doc['pAge'],
                pGender: element.doc['pGender'],
                pProblem: element.doc['pProblem'],
                bookingDate: element.doc['bookingDate'],
                appointDate: element.doc['appointDate'],
                chamberName: element.doc['chamberName'],
                chamberAddress: element.doc['chamberAddress'],
                bookingSchedule: element.doc['bookingSchedule'],
                actualProblem: element.doc['actualProblem'],
                rx: element.doc['rx'],
                advice: element.doc['advice'],
                nextVisit: element.doc['nextVisit'],
                appointState: element.doc['appointState'],
                medicines: element.doc['medicines'],
                prescribeNo: element.doc['prescribeNo'],
                timeStamp: element.doc['timeStamp'],
              );
              _prescriptionList.add(appointmentDetailsModel);
            }
          });
        });
      notifyListeners();
    }catch(error){}
  }
}