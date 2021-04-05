import 'package:admin_panel/model/doctorDetails_model.dart';
import 'package:admin_panel/model/faq_model.dart';
import 'package:admin_panel/model/hospital_model.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../notification_widget.dart';

class DoctorProvider extends AuthProvider{
  DoctorDetailsModel _doctorDetails = DoctorDetailsModel();
  List<DoctorDetailsModel> _doctorList=List<DoctorDetailsModel>();
  List<HospitalModel> _hospitalList=List<HospitalModel>();
  List<FaqModel> _faqList = List<FaqModel>();
  FaqModel _faqModel = FaqModel();

  bool _isLoading = false;
  String _loadingMgs;

  get doctorDetails => _doctorDetails;
  get doctorList=> _doctorList;
  get hospitalList=>_hospitalList;
  get faqList=> _faqList;
  get faqModel=> _faqModel;
  get isLoading => _isLoading;
  get loadingMgs => _loadingMgs;

  set doctorDetails(DoctorDetailsModel model) {
    model = DoctorDetailsModel();
    _doctorDetails = model;
    notifyListeners();
  }

  set faqModel(FaqModel model){
    model = FaqModel();
    _faqModel = model;
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

  Future<bool> addDoctor(DoctorDetailsModel doctorDetails, BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      String date = DateFormat("dd-MMM-yyyy/hh:mm:aa").format(
          DateTime.fromMillisecondsSinceEpoch(DateTime
              .now()
              .millisecondsSinceEpoch));

      final String id = doctorDetails.countryCode + doctorDetails.phone.trim();

      if (doctorDetails.provideTeleService) {
        await FirebaseFirestore.instance.collection('Doctors').doc(id).set({
          'id': id,
          'name': doctorDetails.fullName,
          'phone': doctorDetails.phone,
          'password': doctorDetails.password,
          'email': doctorDetails.email,
          'about': doctorDetails.about,
          'country': doctorDetails.country,
          'state': doctorDetails.state,
          'city': doctorDetails.city,
          'joinDate': date,
          'gender': doctorDetails.gender,
          'specification': doctorDetails.specification,
          'optionalSpecification': doctorDetails.optionalSpecification,
          'degree': doctorDetails.degree,
          'bmdcNumber': doctorDetails.bmdcNumber,
          'currency': doctorDetails.currency,
          'appFee': doctorDetails.appFee,
          'teleFee': doctorDetails.teleFee,
          'experience': doctorDetails.experience,
          'photoUrl': doctorDetails.photoUrl,
          'totalPrescribe': doctorDetails.totalPrescribe,
          'countryCode': doctorDetails.countryCode,
          'provideTeleService': doctorDetails.provideTeleService,
          'teleSat': !doctorDetails.sat[0] ? null : [
            '${doctorDetails.sat[1].hour}:${doctorDetails.sat[1].minute}',
            '${doctorDetails.sat[2].hour}:${doctorDetails.sat[2].minute}'
          ],
          'teleSun': !doctorDetails.sun[0] ? null : [
            '${doctorDetails.sun[1].hour}:${doctorDetails.sun[1].minute}',
            '${doctorDetails.sun[2].hour}:${doctorDetails.sun[2].minute}'
          ],
          'teleMon': !doctorDetails.mon[0] ? null : [
            '${doctorDetails.mon[1].hour}:${doctorDetails.mon[1].minute}',
            '${doctorDetails.mon[2].hour}:${doctorDetails.mon[2].minute}'
          ],
          'teleTue': !doctorDetails.tue[0] ? null : [
            '${doctorDetails.tue[1].hour}:${doctorDetails.tue[1].minute}',
            '${doctorDetails.tue[2].hour}:${doctorDetails.tue[2].minute}'
          ],
          'teleWed': !doctorDetails.wed[0] ? null : [
            '${doctorDetails.wed[1].hour}:${doctorDetails.wed[1].minute}',
            '${doctorDetails.wed[2].hour}:${doctorDetails.wed[2].minute}'
          ],
          'teleThu': !doctorDetails.thu[0] ? null : [
            '${doctorDetails.thu[1].hour}:${doctorDetails.thu[1].minute}',
            '${doctorDetails.thu[2].hour}:${doctorDetails.thu[2].minute}'
          ],
          'teleFri': !doctorDetails.fri[0] ? null : [
            '${doctorDetails.fri[1].hour}:${doctorDetails.fri[1].minute}',
            '${doctorDetails.fri[2].hour}:${doctorDetails.fri[2].minute}'
          ],
        }).then((value) {
          showAlertDialog(context, 'Doctor added successful');
        }, onError: (error) {
          Navigator.pop(context);
          showSnackBar(scaffoldKey, error.toString());
        });
        return true;
      } else {
        await FirebaseFirestore.instance.collection('Doctors').doc(id).set({
          'id': id,
          'name': doctorDetails.fullName,
          'phone': doctorDetails.phone,
          'password': doctorDetails.password,
          'email': doctorDetails.email,
          'about': doctorDetails.about,
          'country': doctorDetails.country,
          'state': doctorDetails.state,
          'city': doctorDetails.city,
          'joinDate': date,
          'gender': doctorDetails.gender,
          'specification': doctorDetails.specification,
          'degree': doctorDetails.degree,
          'bmdcNumber': doctorDetails.bmdcNumber,
          'currency': doctorDetails.currency,
          'appFee': doctorDetails.appFee,
          'teleFee': null,
          'experience': doctorDetails.experience,
          'photoUrl': doctorDetails.photoUrl,
          'totalPrescribe': doctorDetails.totalPrescribe,
          'countryCode': doctorDetails.countryCode,
          'provideTeleService': doctorDetails.provideTeleService,
          'teleSat': null,
          'teleSun': null,
          'teleMon': null,
          'teleTue': null,
          'teleWed': null,
          'teleThu': null,
          'teleFri': null,
        }).then((value) {
          showAlertDialog(context, 'Doctor added successful');
        }, onError: (error) {
          Navigator.pop(context);
          showSnackBar(scaffoldKey, error.toString());
        });
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> getDoctor(String specification)async{
    try{
      await FirebaseFirestore.instance.collection('Doctors').where('specification', isEqualTo: specification).get().then((snapShot){
        _doctorList.clear();
        snapShot.docChanges.forEach((element) {
          DoctorDetailsModel doctors=DoctorDetailsModel(
              id: element.doc['id'],
              about: element.doc['about'],
              appFee: element.doc['appFee'],
              bmdcNumber: element.doc['bmdcNumber'],
              countryCode: element.doc['countryCode'],
              degree: element.doc['degree'],
              email: element.doc['email'],
              experience: element.doc['experience'],
              gender: element.doc['gender'],
              joinDate: element.doc['joinDate'],
              fullName: element.doc['name'],
              password: element.doc['password'],
              phone: element.doc['phone'],
              photoUrl: element.doc['photoUrl'],
              provideTeleService: element.doc['provideTeleService'],
              specification: element.doc['specification'],
              teleFee: element.doc['teleFee'],
              totalPrescribe: element.doc['totalPrescribe'],
              country: element.doc['country'],
              state: element.doc['state'],
              city: element.doc['city'],
              optionalSpecification: element.doc['optionalSpecification'],
              sat: element.doc['teleSat'],
              sun: element.doc['teleSun'],
              mon: element.doc['teleMon'],
              tue: element.doc['teleTue'],
              wed: element.doc['teleWed'],
              thu: element.doc['teleThu'],
              fri: element.doc['teleFri'],
              totalTeleFee: element.doc['totalTeleFee']
          );
          _doctorList.add(doctors);
        });
      });
      notifyListeners();
    }catch(error){}
  }

  Future<bool> updateTeleFee( String id,BuildContext context,GlobalKey<ScaffoldState> scaffoldKey)async{
    await FirebaseFirestore.instance.collection('Doctors').doc(id).update({
      'totalTeleFee': null,
    }).then((value){
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(scaffoldKey, 'Tele Fee Withdrawn successfully');
    },onError: (error){
      Navigator.pop(context);
      Navigator.pop(context);
      // print(id);
      showSnackBar(scaffoldKey, error.toString());
    });


  }

  Future<void> getHospitals(String doctorId)async{
    try{
      await FirebaseFirestore.instance.collection('Hospitals').where('doctorId', isEqualTo: doctorId).get().then((snapShot){
        _hospitalList.clear();
        snapShot.docChanges.forEach((element) {
          HospitalModel hospitals = HospitalModel(
            id: element.doc['id'],
            doctorId: element.doc['doctorId'],
            hospitalName: element.doc['hospitalName'],
            hospitalAddress: element.doc['hospitalAddress'],
            addingDate: element.doc['addingDate'],
            sat: element.doc['sat'],
            sun: element.doc['sun'],
            mon: element.doc['mon'],
            tue: element.doc['tue'],
            wed: element.doc['wed'],
            thu: element.doc['thu'],
            fri: element.doc['fri'],
          );
          _hospitalList.add(hospitals);
        });
      });
      notifyListeners();
    }catch(error){}
  }

  Future<void> getFaq(String id) async{
    try{
      await FirebaseFirestore.instance.collection('FAQ').where('id', isEqualTo: id).get().then((snapshot){
        _faqList.clear();
        snapshot.docChanges.forEach((element) {
          FaqModel faqModel = FaqModel(
            id: element.doc['id'],
            one: element.doc['one'],
            two: element.doc['two'],
            three: element.doc['three'],
            four: element.doc['four'],
            five: element.doc['five'],
            six: element.doc['six'],
            seven: element.doc['seven'],
            eight: element.doc['eight'],
            nine: element.doc['nine'],
            ten: element.doc['ten'],
          );
          _faqList.add(faqModel);
        });
      });
      notifyListeners();
    }catch(error){}
  }

  Future<void> updateFaq(DoctorProvider operation, GlobalKey<ScaffoldState> scaffoldKey, BuildContext context,String id)async{
    ///Insert operation
    if(operation.faqList.isEmpty){
      await FirebaseFirestore.instance.collection('FAQ').doc(id).set({
        'id': id,
        'one':operation.faqModel.one.isNotEmpty?operation.faqModel.one:operation.faqList[0].one,
        'two':operation.faqModel.two.isNotEmpty?operation.faqModel.two:operation.faqList[0].two,
        'three':operation.faqModel.three.isNotEmpty?operation.faqModel.three:operation.faqList[0].three,
        'four':operation.faqModel.four.isNotEmpty?operation.faqModel.four:operation.faqList[0].four,
        'five':operation.faqModel.five.isNotEmpty?operation.faqModel.five:operation.faqList[0].five,
        'six':operation.faqModel.six.isNotEmpty?operation.faqModel.six:operation.faqList[0].six,
        'seven':operation.faqModel.seven.isNotEmpty?operation.faqModel.seven:operation.faqList[0].seven,
        'eight':operation.faqModel.eight.isNotEmpty?operation.faqModel.eight:operation.faqList[0].eight,
        'nine':operation.faqModel.nine.isNotEmpty?operation.faqModel.nine:operation.faqList[0].nine,
        'ten':operation.faqModel.ten.isNotEmpty?operation.faqModel.ten:operation.faqList[0].ten,
      }).then((value){
        Navigator.pop(context);
        Navigator.pop(context);
        operation.getFaq(id);
        showAlertDialog(context, 'FAQ update successful');
        operation.faqList[0].one= operation.faqModel.one.isNotEmpty?operation.faqModel.one:operation.faqList[0].one;
        operation.faqList[0].two= operation.faqModel.two.isNotEmpty?operation.faqModel.two:operation.faqList[0].two;
        operation.faqList[0].three= operation.faqModel.three.isNotEmpty?operation.faqModel.three:operation.faqList[0].three;
        operation.faqList[0].four= operation.faqModel.four.isNotEmpty?operation.faqModel.four:operation.faqList[0].four;
        operation.faqList[0].five= operation.faqModel.five.isNotEmpty?operation.faqModel.five:operation.faqList[0].five;
        operation.faqList[0].six= operation.faqModel.six.isNotEmpty?operation.faqModel.six:operation.faqList[0].six;
        operation.faqList[0].seven= operation.faqModel.seven.isNotEmpty?operation.faqModel.seven:operation.faqList[0].seven;
        operation.faqList[0].eigh= operation.faqModel.eight.isNotEmpty?operation.faqModel.eight:operation.faqList[0].eight;
        operation.faqList[0].nine= operation.faqModel.nine.isNotEmpty?operation.faqModel.nine:operation.faqList[0].nine;
        operation.faqList[0].ten= operation.faqModel.ten.isNotEmpty?operation.faqModel.ten:operation.faqList[0].ten;
        notifyListeners();
      },onError: (error){
        Navigator.pop(context);
        showSnackBar(scaffoldKey, error.toString());
      });

    }
    ///Update operation
    else{
      await FirebaseFirestore.instance.collection('FAQ').doc(id).update({
        'id':id,
        'one':operation.faqModel.one.isNotEmpty?operation.faqModel.one:operation.faqList[0].one,
        'two':operation.faqModel.two.isNotEmpty?operation.faqModel.two:operation.faqList[0].two,
        'three':operation.faqModel.three.isNotEmpty?operation.faqModel.three:operation.faqList[0].three,
        'four':operation.faqModel.four.isNotEmpty?operation.faqModel.four:operation.faqList[0].four,
        'five':operation.faqModel.five.isNotEmpty?operation.faqModel.five:operation.faqList[0].five,
        'six':operation.faqModel.six.isNotEmpty?operation.faqModel.six:operation.faqList[0].six,
        'seven':operation.faqModel.seven.isNotEmpty?operation.faqModel.seven:operation.faqList[0].seven,
        'eight':operation.faqModel.eight.isNotEmpty?operation.faqModel.eight:operation.faqList[0].eight,
        'nine':operation.faqModel.nine.isNotEmpty?operation.faqModel.nine:operation.faqList[0].nine,
        'ten':operation.faqModel.ten.isNotEmpty?operation.faqModel.ten:operation.faqList[0].ten,
      }).then((value){
        operation.getFaq(id);
        Navigator.pop(context);
        Navigator.pop(context);
      },onError: (error){
        Navigator.pop(context);
        showSnackBar(scaffoldKey, error.toString());
      });
    }
  }



}