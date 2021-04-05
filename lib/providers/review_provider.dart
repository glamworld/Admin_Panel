import 'dart:math';
import 'package:admin_panel/model/shop_model.dart';
import 'package:admin_panel/model/appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_panel/model/discount_shop_review_model.dart';
import 'package:admin_panel/providers/auth_provider.dart';

class ReviewProvider extends AuthProvider{

  List<AppointmentDetailsModel> _allReviewList = List();
  List<DiscountShopReviewModel> _allShopReviewList = List();

  int _totalAppointment;
  int _oneStar=0;
  int _twoStar=0;
  int _threeStar=0;
  int _fourStar=0;
  int _fiveStar=0;
  int _shopOneStar=0;
  int _shopTwoStar=0;
  int _shopThreeStar=0;
  int _shopFourStar=0;
  int _shopFiveStar=0;
  double _avgRating=0.0;
  double _avgShopRating=0.0;

  get totalAppointment=> _totalAppointment;
  get allReviewList=> _allReviewList;
  get allShopReviewList=> _allShopReviewList;
  get oneStar=> _oneStar;
  get twoStar=> _twoStar;
  get threeStar=> _threeStar;
  get fourStar=> _fourStar;
  get fiveStar=> _fiveStar;
  get shopOneStar=> _shopOneStar;
  get shopTwoStar=> _shopTwoStar;
  get shopThreeStar=> _shopThreeStar;
  get shopFourStar=> _shopFourStar;
  get shopFiveStar=> _shopFiveStar;
  get avgRating=> _avgRating;
  get avgShopRating=> _avgShopRating;

  Future<void> getTotalAppointment(String docId)async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('AppointmentList')
        .where('drId',isEqualTo: docId).get();
    final List<QueryDocumentSnapshot> counter = snapshot.docs;
    if(counter.isNotEmpty){
      _totalAppointment = counter.length;
      notifyListeners();
    }else{
      _totalAppointment = 0;
      notifyListeners();
    }
  }

  Future<void> getAllReview()async{
    try{
      await FirebaseFirestore.instance.collection('AppointmentList').orderBy('reviewTimeStamp',descending: true).get().then((snapshot){
        _allReviewList.clear();
        snapshot.docChanges.forEach((element) {
          if(element.doc['reviewStar']!=null){
            AppointmentDetailsModel appointmentDetailsModel = AppointmentDetailsModel(
              pName: element.doc[ 'pName'],
              pPhotoUrl: element.doc['pPhotoUrl'],
              pProblem: element.doc['pProblem'],
              reviewStar: element.doc['reviewStar'],
              reviewComment: element.doc['reviewComment'],
              reviewDate: element.doc['reviewDate'],
            );
            _allReviewList.add(appointmentDetailsModel);
          }
        });
      });
      notifyListeners();
    }catch(error){}
  }

  void getOneStar(){
    _oneStar=0;
    _twoStar=0;
    _threeStar=0;
    _fourStar=0;
    _fiveStar=0;
    _avgRating=0.0;

    for(int i=0; i<_allReviewList.length; i++){
      if(_allReviewList[i].reviewStar=='1'){
        _oneStar++;
      }
    }
    notifyListeners();
    getTwoStar();
  }
  void getTwoStar(){
    for(int i=0; i<_allReviewList.length; i++){
      if(_allReviewList[i].reviewStar=='2'){
        _twoStar++;
      }
    }
    notifyListeners();
    getThreeStar();
  }
  void getThreeStar(){
    for(int i=0; i<_allReviewList.length; i++){
      if(_allReviewList[i].reviewStar=='3'){
        _threeStar++;
      }
    }
    notifyListeners();
    getFourStar();
  }
  void getFourStar(){
    for(int i=0; i<_allReviewList.length; i++){
      if(_allReviewList[i].reviewStar=='4'){
        _fourStar++;
      }
    }
    notifyListeners();
    getFiveStar();
  }
  void getFiveStar(){
    for(int i=0; i<_allReviewList.length; i++){
      if(_allReviewList[i].reviewStar=='5'){
        _fiveStar++;
      }
    }
    notifyListeners();
    getAvgRating();
  }

  void getAvgRating(){
    if(_allReviewList.length!=0){
      double tempAvgRating = ((1*_oneStar)+(2*_twoStar)+(3*_threeStar)+(4*_fourStar)+(5*_fiveStar))/_allReviewList.length;
      _avgRating = roundDouble(tempAvgRating, 1);
      notifyListeners();
    }else{
      _avgRating=0.0;
      notifyListeners();
    }

  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  Future<void> getAllShopReview(String shopId)async{
    try{
      await FirebaseFirestore.instance.collection('DiscountShopReview').where('shopId',isEqualTo: shopId).get().then((snapshot){
        _allShopReviewList.clear();
        snapshot.docChanges.forEach((element) {
          if(element.doc['reviewStar']!=null){
            DiscountShopReviewModel shopReviewModel = DiscountShopReviewModel(
              id: element.doc['id'],
              pId: element.doc['pId'],
              shopId: element.doc['shopId'],
              reviewStar: element.doc['reviewStar'],
              submitDate: element.doc['submitDate']
            );
            _allShopReviewList.add(shopReviewModel);
          }
        });
      });
      notifyListeners();
    }catch(error){}
  }
  void getShopOneStar(){
    _shopOneStar=0;
    _shopTwoStar=0;
    _shopThreeStar=0;
    _shopFourStar=0;
    _shopFiveStar=0;
    _avgShopRating=0.0;

    for(int i=0; i<_allShopReviewList.length; i++){
      if(_allShopReviewList[i].reviewStar=='1'){
        _shopOneStar++;
      }
    }
    notifyListeners();
    getShopTwoStar();
  }
  void getShopTwoStar(){
    for(int i=0; i<_allShopReviewList.length; i++){
      if(_allShopReviewList[i].reviewStar=='2'){
        _shopTwoStar++;
      }
    }
    notifyListeners();
    getShopThreeStar();
  }
  void getShopThreeStar(){
    for(int i=0; i<_allShopReviewList.length; i++){
      if(_allShopReviewList[i].reviewStar=='3'){
        _shopThreeStar++;
      }
    }
    notifyListeners();
    getShopFourStar();
  }
  void getShopFourStar(){
    for(int i=0; i<_allShopReviewList.length; i++){
      if(_allShopReviewList[i].reviewStar=='4'){
        _shopFourStar++;
      }
    }
    notifyListeners();
    getShopFiveStar();
  }
  void getShopFiveStar(){
    for(int i=0; i<_allShopReviewList.length; i++){
      if(_allShopReviewList[i].reviewStar=='5'){
        _shopFiveStar++;

      }
    }
    notifyListeners();
    getShopAvgRating();

  }
  void getShopAvgRating(){
    if(_allShopReviewList.length!=0){
      double tempAvgRating = ((1*_shopOneStar)+(2*_shopTwoStar)+(3*_shopThreeStar)+(4*_shopFourStar)+(5*_shopFiveStar))/_allShopReviewList.length;
      _avgShopRating = roundDouble(tempAvgRating, 1);
      notifyListeners();
    }else{
      _avgShopRating=0.0;
      notifyListeners();
    }

  }

}