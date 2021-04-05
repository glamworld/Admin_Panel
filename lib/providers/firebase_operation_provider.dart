import 'package:admin_panel/model/appointment_model.dart';
import 'package:admin_panel/model/problem_model.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_panel/model/amount_model.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/model/payment_discount_model.dart';
import 'package:admin_panel/model/payment_appointment_model.dart';
import 'package:admin_panel/model/admin_details.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:admin_panel/model/notification_model.dart';
class FirebaseOperationProvider extends AuthProvider{

  List<NotificationModel> _notificationList = List<NotificationModel>();
  List<AdminDetailsModel> _adminList= List<AdminDetailsModel>();
  List<ProblemModel> _problemList = List<ProblemModel>();
  List<ProblemModel> _patientsProblemList = List<ProblemModel>();
  List<AmountModel> _amountList = List<AmountModel>();
  List<AppointmentDetailsModel> _appointmentList=List<AppointmentDetailsModel>();
  List<AppointmentDetailsModel> _appointmentIdList=List<AppointmentDetailsModel>();
  List<PaymentDiscountModel> _paymentDiscountList = List<PaymentDiscountModel>();
  List<PaymentAppointmentModel> _paymentAppointmentList = List<PaymentAppointmentModel>();


  get amountList=> _amountList;
  get adminList => _adminList;
  get problemList => _problemList;
  get patientsProblemList => _patientsProblemList;
  get notificationList => _notificationList;
  get appointmentList=>_appointmentList;
  get appointmentIdList=>_appointmentIdList;
  get paymentDiscountList=>_paymentDiscountList;
  get paymentAppointmentList=>_paymentAppointmentList;

  Future<void> getNotifications()async{

    try{
      await FirebaseFirestore.instance.collection('Notifications').get().then((snapshot) {
        _notificationList.clear();
        snapshot.docChanges.forEach((element) {
          NotificationModel notifications = NotificationModel(
            id: element.doc['id'],
            category: element.doc['category'],
            title: element.doc['title'],
            message: element.doc['message'],
            date: element.doc['date'],
          );
          _notificationList.add(notifications);
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

  Future<void> getPatientsProblems()async{

    try{
      await FirebaseFirestore.instance.collection('UserProblems').where('messageFrom',isEqualTo: 'patient').orderBy('timeStamp',descending: true).get().then((snapshot) {
        _patientsProblemList.clear();
        snapshot.docChanges.forEach((element) {
          ProblemModel problems = ProblemModel(
            id: element.doc['id'],
            email: element.doc['email'],
            message: element.doc['message'],
            messageFrom: element.doc['messageFrom'],
            name: element.doc['name'],
            phone: element.doc['phone'],
            submitDate: element.doc['submitDate']
          );
          _patientsProblemList.add(problems);
        });
      });
      notifyListeners();
      loadingMgs = '';
    }catch(error){
      print(error.toString());
      loadingMgs = '';
    }
  }

  Future<void> getDoctorsProblems()async{

    try{
      await FirebaseFirestore.instance.collection('UserProblems').where('messageFrom',isEqualTo: 'doctor').orderBy('timeStamp',descending: true).get().then((snapshot) {
        _problemList.clear();
        snapshot.docChanges.forEach((element) {
          ProblemModel problems = ProblemModel(
              id: element.doc['id'],
              email: element.doc['email'],
              message: element.doc['message'],
              messageFrom: element.doc['messageFrom'],
              name: element.doc['name'],
              phone: element.doc['phone'],
              submitDate: element.doc['submitDate']
          );
          _problemList.add(problems);
        });
      });
      notifyListeners();
      loadingMgs = '';
    }catch(error){
      print(error.toString());
      loadingMgs = '';
    }
  }

  Future<void> getPatientAppointment(String pId)async{
    try{
        await FirebaseFirestore.instance.collection('AppointmentList').where('pId',isEqualTo: pId).orderBy('timeStamp',descending: true).get().then((snapshot){
          _appointmentList.clear();
          snapshot.docChanges.forEach((element) {
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
              appointState: element.doc['appointState'],
              medicines: element.doc['medicines'],
              timeStamp: element.doc['timeStamp'],
              prescribeNo: element.doc['prescribeNo'],
            );
            _appointmentList.add(appointmentDetailsModel);
          });
        });
      notifyListeners();
    }catch(error){}
  }

  Future<void> getAppointmentIdList(String aId)async{
    try{
        await FirebaseFirestore.instance.collection('AppointmentList').where('id',isEqualTo: aId).get().then((snapshot){
          _appointmentIdList.clear();
          snapshot.docChanges.forEach((element) {
            AppointmentDetailsModel appointmentIdDetailsModel=AppointmentDetailsModel(
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
              appointState: element.doc['appointState'],
              medicines: element.doc['medicines'],
              timeStamp: element.doc['timeStamp'],
              prescribeNo: element.doc['prescribeNo'],
            );
            _appointmentIdList.add(appointmentIdDetailsModel);
          });
        });
      notifyListeners();
    }catch(error){}
  }

  Future<bool> deleteNotification(String id,BuildContext context,GlobalKey<ScaffoldState> scaffoldKey,FirebaseOperationProvider operation)async{
    await FirebaseFirestore.instance.collection('Notifications').doc(id).delete().then((value) async{
      await operation.getNotifications().then((value) {
        showSnackBar(scaffoldKey, 'Notification deleted');
      });

    },onError: (error){
      Navigator.pop(context);
      //showSnackBar(scaffoldKey, error.toString());
    });
  }

  Future<void> getAdmin()async{

    try{
      await FirebaseFirestore.instance.collection('Admin').where('id',isEqualTo: 'YEGrm1zF24qqMJFww3s8').get().then((snapshot) {
        _adminList.clear();
        snapshot.docChanges.forEach((element) {
          AdminDetailsModel admin = AdminDetailsModel(
            id: element.doc['id'],
            phone: element.doc['phone'],
            countryCode: element.doc['countryCode']
          );
          _adminList.add(admin);
          //print(_adminList.length);
        });
      });
      notifyListeners();
    }catch(error){
      print(error.toString());
    }
  }

  Future<void> getAmount()async{

    try{
      await FirebaseFirestore.instance.collection('Amount').where('id',isEqualTo: '123456').get().then((snapshot) {
        _amountList.clear();
        snapshot.docChanges.forEach((element) {
          AmountModel amount = AmountModel(
              id: element.doc['id'],
              amountCharge: element.doc['amountCharge'],
              dollarUnit: element.doc['dollarUnit']
          );
          _amountList.add(amount);
          print(amountList.length);
        });
      });
      notifyListeners();
    }catch(error){
      print(error.toString());
    }
  }

  Future<void> getDiscountPayment()async{

    try{
      await FirebaseFirestore.instance.collection('DiscountPaymentDetails').orderBy('timeStamp',descending: true).get().then((snapshot) {
        _paymentDiscountList.clear();
        snapshot.docChanges.forEach((element) {
          PaymentDiscountModel paymentDiscountModel = PaymentDiscountModel(
            id: element.doc['id'],
            pId: element.doc['pId'],
            pName: element.doc['pName'],
            amount: element.doc['amount'],
            currency: element.doc['currency'],
            shopId: element.doc['shopId'],
            shopName: element.doc['shopName'],
            paymentDate: element.doc['paymentDate'],
            timeStamp: element.doc['timeStamp'],
            transactionId: element.doc['transactionId']
          );
          _paymentDiscountList.add(paymentDiscountModel);
        });
      });
      notifyListeners();
      loadingMgs = '';
    }catch(error){
      print(error.toString());
      loadingMgs = '';
    }
  }

  Future<void> getAppointmentPayment()async{

    try{
      await FirebaseFirestore.instance.collection('AppointmentPaymentDetails').orderBy('timeStamp',descending: true).get().then((snapshot) {
        _paymentAppointmentList.clear();
        snapshot.docChanges.forEach((element) {
          PaymentAppointmentModel paymentAppointmentModel = PaymentAppointmentModel(
              id: element.doc['id'],
              pId: element.doc['pId'],
              pName: element.doc['pName'],
              amount: element.doc['amount'],
              currency: element.doc['currency'],
              drId: element.doc['drId'],
              drName: element.doc['drName'],
              takenService: element.doc['takenService'],
              paymentDate: element.doc['paymentDate'],
              timeStamp: element.doc['timeStamp'],
              transactionId: element.doc['transactionId']
          );
          _paymentAppointmentList.add(paymentAppointmentModel);
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