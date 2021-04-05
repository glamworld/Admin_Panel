import 'package:admin_panel/providers/doctor_provider.dart';
import 'package:admin_panel/providers/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/utils/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_panel/providers/appointment_provider.dart';
import 'package:admin_panel/model/doctorDetails_model.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:admin_panel/subpage/doctor_detailes_page/doctor_profile_tab.dart';
import 'package:admin_panel/utils/form_decoration.dart';
class DoctorList extends StatefulWidget {
  String category;
  DoctorList({this.category});

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  List<DoctorDetailsModel> filteredDoctor = List();
  List<DoctorDetailsModel> doctorList = List();
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    DoctorProvider operation =
    Provider.of<DoctorProvider>(context);
    if (_counter == 0) {
      operation.getDoctor(widget.category).then((value){
        setState(() {
          doctorList=operation.doctorList;
          filteredDoctor=doctorList;
          _counter++;
        });
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffF4F7F5),
      appBar: _customAppBar(),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search by doctor phone no..',
            ),
            onChanged: (string) {
              setState(() {
                filteredDoctor = doctorList
                    .where((u) => (u.phone
                    //.toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });

            },
          ),
          Expanded(child: _counter==0?Center(child: CircularProgressIndicator()):_bodyUI(operation)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
  Widget _customAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: MyCustomClipperForAppBar(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Color(0xffBCEDF2),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  tileMode: TileMode.clamp,
                )),
          ),
        ),
      ),
    );
  }

  Widget _bodyUI(DoctorProvider operation) {
    Size size = MediaQuery.of(context).size;
    //DoctorProvider operation = Provider.of<DoctorProvider>(context);
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      height: size.height,
      width: size.width,
      //padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: ()async{
          operation.getDoctor(widget.category).then((value){
            setState(() {
              doctorList=operation.doctorList;
              filteredDoctor=doctorList;
            });
          });
        },
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: filteredDoctor.length,
            itemBuilder: (context, index) {
              return DoctorBuildersTile(
                id:filteredDoctor[index].id,
                fullName: filteredDoctor[index].fullName,
                phone: filteredDoctor[index].phone,
                email:filteredDoctor[index].email,
                about:filteredDoctor[index].about,
                country:filteredDoctor[index].country,
                state:filteredDoctor[index].state,
                city:filteredDoctor[index].city,
                gender:filteredDoctor[index].gender,
                specification:filteredDoctor[index].specification,
                optionalSpecification:filteredDoctor[index].optionalSpecification,
                degree: filteredDoctor[index].degree,
                bmdcNumber: filteredDoctor[index].bmdcNumber,
                teleFee: filteredDoctor[index].teleFee,
                appFee: filteredDoctor[index].appFee,
                experience: filteredDoctor[index].experience,
                photoUrl: filteredDoctor[index].photoUrl,
                totalPrescribe: filteredDoctor[index].totalPrescribe,
                totalTeleFee: filteredDoctor[index].totalTeleFee,
                countryCode: filteredDoctor[index].countryCode,
                currency: filteredDoctor[index].currency,
                provideTeleService: filteredDoctor[index].provideTeleService,
                sat: filteredDoctor[index].sat,
                sun: filteredDoctor[index].sun,
                mon: filteredDoctor[index].mon,
                tue: filteredDoctor[index].tue,
                wed: filteredDoctor[index].wed,
                thu: filteredDoctor[index].thu,
                fri: filteredDoctor[index].fri,
              );
            }
        ),
      ),
    );
  }
}
class DoctorBuildersTile extends StatelessWidget {

  String id;
  String fullName;
  String phone;
  String email;
  String about;
  String country;
  String state;
  String city;
  String gender;
  String specification;
  List<dynamic> optionalSpecification;
  String degree;
  String bmdcNumber;
  String appFee;
  String teleFee;
  String experience;
  String photoUrl;
  String totalPrescribe;
  String totalTeleFee;
  String countryCode;
  String currency;
  bool provideTeleService;
  List<dynamic> sat;
  List<dynamic> sun;
  List<dynamic> mon;
  List<dynamic> tue;
  List<dynamic> wed;
  List<dynamic> thu;
  List<dynamic> fri;

  DoctorBuildersTile(
      {this.id,
        this.fullName,
        this.phone,
        this.email,
        this.about,
        this.gender,
        this.country,
        this.state,
        this.city,
        this.specification,
        this.optionalSpecification,
        this.degree,
        this.bmdcNumber,
        this.appFee,
        this.teleFee,
        this.experience,
        this.photoUrl,
        this.totalPrescribe,
        this.totalTeleFee,
        this.provideTeleService,
        this.currency,
        this.sat,
        this.countryCode,
        this.fri,
        this.mon,
        this.sun,
        this.thu,
        this.tue,
        this.wed});


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    DoctorProvider operation = Provider.of<DoctorProvider>(context);
    AppointmentProvider appointmentProvider = Provider.of<AppointmentProvider>(context);
    ReviewProvider reviewProvider = Provider.of<ReviewProvider>(context);
    return GestureDetector(
      onTap: () async {
        operation.loadingMgs='Please wait...';
        showLoadingDialog(context,operation);
        await operation.getFaq(id).then((value)async{
          await operation.getHospitals(id).then((value)async{
            await appointmentProvider.getAppointmentList(id).then((value)async{
              await appointmentProvider.getPrescriptionList(id).then((value)async{
                await reviewProvider.getTotalAppointment(id).then((value)async{
                  await reviewProvider.getAllReview().then((value)async{
                    reviewProvider.getOneStar();
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorOwnDetails(
                      id:id,
                      fullName:fullName,
                      phone:phone,
                      email:email,
                      about:about,
                      country:country,
                      state:state,
                      city:city,
                      gender:gender,
                      specification:specification,
                      optionalSpecification:optionalSpecification,
                      degree: degree,
                      bmdcNumber: bmdcNumber,
                      teleFee: teleFee,
                      appFee: appFee,
                      experience: experience,
                      photoUrl: photoUrl,
                      totalPrescribe:totalPrescribe,
                      totalTeleFee: totalTeleFee,
                      countryCode: countryCode,
                      currency: currency,
                      provideTeleService: provideTeleService,
                      sat: sat,
                      sun: sun,
                      mon: mon,
                      tue: tue,
                      wed: wed,
                      thu: thu,
                      fri: fri,
                    )));
                  });
                });
              });
            });
          });
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: simpleCardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///Leading Section(image)
            Container(
              height: size.width*.20,
              width: size.width * 0.20,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xffAAF1E8),
              ),
              child: photoUrl == null
                  ? Image.asset("assets/male.png", width: size.width * .20)
                  : ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: photoUrl,
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/loadingimage.gif',
                        fit: BoxFit.cover, height: size.width*.20),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: size.width * .20,
                  height: size.width*.20,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            ///Middle Section
            Container(
                width: size.width * 0.5,
                padding: EdgeInsets.only(left: 5),
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${fullName?? ''}',
                        maxLines: 1,
                        style: TextStyle(fontSize: size.width*.048, color: Colors.grey[900],),
                        textAlign: TextAlign.left),
                    Text(specification??'',style: TextStyle(fontSize: size.width*.040, color: Colors.grey[800])),
                    Text(degree?? '',
                        maxLines: 2,
                        style: TextStyle(fontSize: size.width*.036, color: Colors.grey[900]),
                        textAlign: TextAlign.left),

                  ],
                )),

            ///Trailing Section
            Container(
              width: size.width * 0.23,
              padding: EdgeInsets.only(left: 5),
              //color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text('Details',
                      style: TextStyle(color: Colors.white,fontSize: size.width*.03),),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            )
          ],
        ),
      ),
    );



  }
}