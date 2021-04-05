import 'package:admin_panel/model/notification_model.dart';
import 'package:admin_panel/model/amount_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../notification_widget.dart';
import 'package:intl/intl.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/model/admin_details.dart';

class AuthProvider extends ChangeNotifier {
  AdminDetailsModel _adminDetails = AdminDetailsModel();
  NotificationModel _notificationModel = NotificationModel();
  AmountModel _amountModel = AmountModel();
  bool _isLoading = false;
  bool _obscure = true;
  String _loadingMgs;
  String _verificationCode;

  get adminDetails => _adminDetails;

  get notificationModel => _notificationModel;

  get obscure => _obscure;

  get isLoading => _isLoading;

  get loadingMgs => _loadingMgs;

  get verificationCode => _verificationCode;

  get amountModel => _amountModel;

  set amountModel(AmountModel model) {
    model = AmountModel();
    _amountModel = model;
    notifyListeners();
  }

  set adminDetails(AdminDetailsModel model) {
    model = AdminDetailsModel();
    _adminDetails = model;
    notifyListeners();
  }

  set notificationModel(NotificationModel notifiModel) {
    notifiModel = NotificationModel();
    _notificationModel = notifiModel;
    notifyListeners();
  }

  set obscure(bool val) {
    _obscure = val;
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

  set verificationCode(String val) {
    _verificationCode = val;
    notifyListeners();
  }

  Future<String> getPreferenceId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('Aid');
  }

  Future<bool> sendNotificaton(NotificationModel notificationModel,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context,
      FirebaseOperationProvider operation) async {
    final id = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    String date = DateFormat("dd-MMM-yyyy/hh:mm:aa").format(DateTime.
    fromMicrosecondsSinceEpoch(DateTime
        .now()
        .microsecondsSinceEpoch));
    try {
      FirebaseFirestore.instance.collection('Notifications').doc(id).set({
        'id': id,
        'category': notificationModel.category,
        'title': notificationModel.title,
        'message': notificationModel.message,
        'date': date,
      }).then((value) async {
        await operation.getNotifications().then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
          showAlertDialog(context, 'Notification sent');
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

  Future<bool> addAmount(AmountModel amountModel,GlobalKey<ScaffoldState> scaffoldKey, BuildContext context)async{
    final id = '123456';
    try {
      FirebaseFirestore.instance.collection('Amount').doc(id).set({
        'id': id,
        'amountCharge': amountModel.amountCharge,
        'dollarUnit': amountModel.dollarUnit,
      }).then((value){
        Navigator.pop(context);
        Navigator.pop(context);
        showAlertDialog(context, 'Amount details updated');
      },onError: (error){
        Navigator.pop(context);
        showSnackBar(scaffoldKey, error.toString());
      });
      return true;
    } catch (e) {
      return false;
    }

  }

}