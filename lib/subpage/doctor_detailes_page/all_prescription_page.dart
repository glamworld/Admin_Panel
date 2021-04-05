import 'package:admin_panel/providers/doctor_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/no_data_widget.dart';
import 'package:admin_panel/providers/appointment_provider.dart';
import 'package:admin_panel/model/appointment_model.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:admin_panel/subpage/doctor_detailes_page/view_prescription_page.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:admin_panel/utils/form_decoration.dart';

// ignore: must_be_immutable
class AllPrescription extends StatefulWidget {

  String id;

  AllPrescription({this.id});

  @override
  _AllPrescriptionState createState() => _AllPrescriptionState();
}

class _AllPrescriptionState extends State<AllPrescription> {

  List<String> strList = [];
  List<Widget> normalList = [];
  List<AppointmentDetailsModel> patientList = [];
  TextEditingController searchController = TextEditingController();
  int _counter = 0;

  void _initializeData(AppointmentProvider appointmentProvider) {
    setState(() => _counter++);

    int i = 0;
    while (i < appointmentProvider.prescriptionList.length) {
      patientList.add(AppointmentDetailsModel(
        id: appointmentProvider.prescriptionList[i].id,
        drId: appointmentProvider.prescriptionList[i].drId,
        drName: appointmentProvider.prescriptionList[i].drName,
        drPhotoUrl: appointmentProvider.prescriptionList[i].drPhotoUrl,
        drDegree: appointmentProvider.prescriptionList[i].drDegree,
        drEmail: appointmentProvider.prescriptionList[i].drEmail,
        drAddress: appointmentProvider.prescriptionList[i].drAddress,
        specification: appointmentProvider.prescriptionList[i].specification,
        appFee: appointmentProvider.prescriptionList[i].appFee,
        teleFee: appointmentProvider.prescriptionList[i].teleFee,
        currency: appointmentProvider.prescriptionList[i].currency,
        pId:  appointmentProvider.prescriptionList[i].pId,
        pName: appointmentProvider.prescriptionList[i].pName,
        pPhotoUrl: appointmentProvider.prescriptionList[i].pPhotoUrl,
        pAddress: appointmentProvider.prescriptionList[i].pAddress,
        pAge: appointmentProvider.prescriptionList[i].pAge,
        pGender: appointmentProvider.prescriptionList[i].pGender,
        pProblem: appointmentProvider.prescriptionList[i].pProblem,
        bookingDate: appointmentProvider.prescriptionList[i].bookingDate,
        appointDate: appointmentProvider.prescriptionList[i].appointDate,
        chamberName: appointmentProvider.prescriptionList[i].chamberName,
        chamberAddress: appointmentProvider.prescriptionList[i].chamberAddress,
        bookingSchedule: appointmentProvider.prescriptionList[i].bookingSchedule,
        appointState: appointmentProvider.prescriptionList[i].appointState,
        actualProblem: appointmentProvider.prescriptionList[i].actualProblem,
        advice: appointmentProvider.prescriptionList[i].advice,
        rx: appointmentProvider.prescriptionList[i].rx,
        nextVisit: appointmentProvider.prescriptionList[i].nextVisit,
        prescribeDate: appointmentProvider.prescriptionList[i].prescribeDate,
        medicines: appointmentProvider.prescriptionList[i].medicines,
        prescribeNo: appointmentProvider.prescriptionList[i].prescribeNo
      ));
      i++;
    }
    patientList
        .sort((a, b) => a.pName.toLowerCase().compareTo(b.pName.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
    });
  }

  ///SearchList builder
  filterList() {
    List<AppointmentDetailsModel> patients = [];
    patients.addAll(patientList);
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      patients.retainWhere((medicine) =>
          medicine.pName
              .toLowerCase()
              .contains(searchController.text.toLowerCase()));
    }
    patients.forEach((patient) {
      normalList.add(
        PatientInfoTile(
          id: patient.id,
          docId: widget.id,
          drId: patient.drId,
          drName: patient.drName,
          drPhotoUrl: patient.drPhotoUrl,
          drDegree: patient.drDegree,
          drEmail: patient.drEmail,
          drAddress: patient.drAddress,
          specification: patient.specification,
          appFee: patient.appFee,
          teleFee: patient.teleFee,
          currency: patient.currency,
          pName: patient.pName,
          pPhotoUrl: patient.pPhotoUrl,
          pAddress: patient.pAddress,
          pAge: patient.pAge,
          pGender: patient.pGender,
          pProblem: patient.pProblem,
          bookingDate: patient.bookingDate,
          appointDate: patient.appointDate,
          chamberName: patient.chamberName,
          chamberAddress: patient.chamberAddress,
          bookingSchedule: patient.bookingSchedule,
          appointState: patient.appointState,
          pId: patient.pId,
          prescribeDate: patient.prescribeDate,
          actualProblem: patient.actualProblem,
          advice: patient.advice,
          rx: patient.rx,
          nextVisit: patient.nextVisit,
          medicines: patient.medicines,
          prescribeNo: patient.prescribeNo,
        ),
      );
      strList.add(patient.pName);
    });
    setState(() {
      strList;
      normalList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppointmentProvider appointmentProvider = Provider.of<AppointmentProvider>(context);
    if (_counter == 0) _initializeData(appointmentProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Color(0xffF4F7F5),
      body: appointmentProvider.prescriptionList.isEmpty?
          NoData(message: 'No prescription',)
          : _bodyUI(appointmentProvider),
    );
  }

  Widget _bodyUI(AppointmentProvider appointmentProvider) {
    Size size=MediaQuery.of(context).size;

    return AlphabetListScrollView(
      strList: strList,
      highlightTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      normalTextStyle: TextStyle(
        color: Colors.black45,
      ),
      showPreview: true,
      itemBuilder: (context, index) {
        return normalList[index];
      },
      indexedHeight: (i) {
        return size.width*.26;
      },
      keyboardUsage: true,

      headerWidgetList: <AlphabetScrollListHeader>[
        AlphabetScrollListHeader(widgetList: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Patient...",
              ),
            ),
          ),
        ],
            icon: Icon(Icons.search), indexedHeaderHeight: (index) => 70),
      ],
    );
  }
}

// ignore: must_be_immutable
class PatientInfoTile extends StatelessWidget {
  String id;
  String docId;
  String drId;
  String drName;
  String drPhotoUrl;
  String drDegree;
  String drEmail;
  String drAddress;
  String specification;
  String appFee;
  String teleFee;
  String currency;
  String pId;
  String pName;
  String pPhotoUrl;
  String pAddress;
  String pAge;
  String pGender;
  String pProblem;
  String bookingDate;
  String appointDate;
  String chamberName;
  String chamberAddress;
  String bookingSchedule;
  String appointState;
  String prescribeDate;
  String actualProblem;
  String advice;
  String rx;
  String nextVisit;
  List<dynamic> medicines;
  String prescribeNo;

  PatientInfoTile(
      {this.id, this.docId, this.drId, this.drName, this.drPhotoUrl, this.drDegree,
        this.drEmail, this.drAddress, this.specification, this.appFee, this.teleFee,
        this.currency, this.pId, this.pName, this.pPhotoUrl, this.pAddress,
        this.pAge, this.pGender, this.pProblem, this.bookingDate,
        this.appointDate, this.chamberName, this.chamberAddress,
        this.bookingSchedule, this.appointState, this.prescribeDate,
        this.medicines,this.nextVisit,this.rx,this.advice,this.actualProblem,this.prescribeNo});

  @override
  Widget build(BuildContext context) {
    DoctorProvider drProvider = Provider.of<DoctorProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: size.width,
      height: size.width*.26,
      decoration: simpleCardDecoration,
      child: Row(
        children: [
          ///Leading Container...
          Container(
            padding: EdgeInsets.all(2),
            width: size.width * .22,
            height: size.width * .24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xffAAF1E8),
            ),
            child: pPhotoUrl == null
                ? Image.asset("assets/male.png", width: size.width * .22,height: size.width * .24,)
                : ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: pPhotoUrl,
                placeholder: (context, url) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/loadingimage.gif',
                    width: size.width * .22,
                    fit: BoxFit.cover,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: size.width * .22,
                height: size.height * .24,
                fit: BoxFit.cover,
              ),
            ),
          ),

          ///Middle Section...
          Container(
            padding: EdgeInsets.only(left: size.width * .009),
            width: size.width * .57,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  pName ?? 'Patient name',
                  maxLines: 1,
                  style: TextStyle(fontSize: size.width*.040, fontWeight: FontWeight.w500),
                ),
                Text(
                  pProblem ?? 'Patient problem',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: size.width*.034,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w300),
                ),
                appointState=='Chamber or Hospital'?
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'At: $chamberName' ?? 'Chamber or Hospital',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: size.width*.028,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),Text(
                        'Schedule: $bookingSchedule' ?? 'Time schudule',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: size.width*.028,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
                    :Text(
                  appointState ?? 'Online Video Consultation',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: size.width*.028,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400),
                ),
                Text('On: $appointDate' ?? 'Appointment date',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: size.width*.028,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400),
                ),


                Text(
                  'Booked on: $bookingDate' ?? 'Booking Date',
                  maxLines: 1,
                  style:
                  TextStyle(fontSize: size.width*.028, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),

          ///Trailing Section
          Container(
            alignment: Alignment.topRight,
            width: size.width * .19,
            height: size.height,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                GestureDetector(
                    // splashColor: Theme.of(context).primaryColor,
                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    onTap: () async {
                      if (drProvider.doctorList.isEmpty) {
                        drProvider.loadingMgs = 'Please wait...';
                        showLoadingDialog(context, drProvider);
                        await drProvider.getDoctor(id).then((value) async {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => ViewPrescription(
                                    id: id,
                                    drId: drId,
                                    drName: drName,
                                    drPhotoUrl: drPhotoUrl,
                                    drDegree: drDegree,
                                    drEmail: drEmail,
                                    drAddress: drAddress,
                                    specification: specification,
                                    appFee: appFee,
                                    teleFee: teleFee,
                                    currency: currency,
                                    pName: pName,
                                    pPhotoUrl: pPhotoUrl,
                                    pAddress: pAddress,
                                    pAge: pAge,
                                    pGender: pGender,
                                    pProblem: pProblem,
                                    bookingDate: bookingDate,
                                    appointDate: appointDate,
                                    chamberName: chamberName,
                                    chamberAddress: chamberAddress,
                                    bookingSchedule: bookingSchedule,
                                    appointState: appointState,
                                    pId: pId,
                                    prescribeDate: prescribeDate,
                                    actualProblem: actualProblem,
                                    advice: advice,
                                    rx: rx,
                                    nextVisit: nextVisit,
                                    medicines: medicines,
                                    prescribeNo: prescribeNo,
                                  )));

                        });
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ViewPrescription(
                              id: id,
                              drId: drId,
                              drName: drName,
                              drPhotoUrl: drPhotoUrl,
                              drDegree: drDegree,
                              drEmail: drEmail,
                              drAddress: drAddress,
                              specification: specification,
                              appFee: appFee,
                              teleFee: teleFee,
                              currency: currency,
                              pName: pName,
                              pPhotoUrl: pPhotoUrl,
                              pAddress: pAddress,
                              pAge: pAge,
                              pGender: pGender,
                              pProblem: pProblem,
                              bookingDate: bookingDate,
                              appointDate: appointDate,
                              chamberName: chamberName,
                              chamberAddress: chamberAddress,
                              bookingSchedule: bookingSchedule,
                              appointState: appointState,
                              pId: pId,
                              prescribeDate: prescribeDate,
                              actualProblem: actualProblem,
                              advice: advice,
                              rx: rx,
                              nextVisit: nextVisit,
                              medicines: medicines,
                              prescribeNo: prescribeNo,
                            )));
                      }
                    },
                    child: miniOutlineButton(context, 'View',
                        Theme.of(context).primaryColor),),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
