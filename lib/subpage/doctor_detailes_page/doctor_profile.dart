import 'package:admin_panel/notification_widget.dart';
import 'package:admin_panel/providers/doctor_provider.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/utils/widget.dart';
import 'package:admin_panel/utils/no_data_widget.dart';

class DoctorProfile extends StatefulWidget {
  String id;
  String fullName;
  String phone;
  String email;
  String about;
  String country;
  String state;
  String city;
  String totalPrescribed;
  String totalTeleFee;

  //String gender;
  String specification;
  List<dynamic> optionalSpecification;
  String degree;
  String bmdcNumber;
  String appFee;
  String teleFee;
  String experience;
  String photoUrl;

  //String totalPrescribe;
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

  DoctorProfile(
      {this.id,
      this.fullName,
      this.phone,
      this.email,
      this.about,
      // this.gender,
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
      this.provideTeleService,
      this.countryCode,
      this.currency,
      this.totalPrescribed,
      this.totalTeleFee,
      this.sat,
      this.fri,
      this.mon,
      this.sun,
      this.thu,
      this.tue,
      this.wed});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  int index = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    DoctorProvider operation =
        Provider.of<DoctorProvider>(context);
    Size size = MediaQuery.of(context).size;
    return ListView(children: [
      Container(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 10.0),
          margin: EdgeInsets.symmetric(horizontal: 10),
          //height: 380,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //padding: EdgeInsets.all(10),
                color: Colors.white,
                height: size.height * .28,
                width: size.width,
                child: Row(
                  children: [
                    Container(
                      width: size.width * .45,
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color(0xffAAF1E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: operation.doctorList[0].photoUrl==null?
                      Image.asset("assets/male.png", width: size.width * .45)
                          :ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: operation.doctorList[0].photoUrl,
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/loadingimage.gif',width: size.width * .45,
                              fit: BoxFit.cover,),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          width: size.width * .45,
                          height: size.height * .28,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * .42,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.fullName??'',
                            maxLines: 3,
                            style:
                            TextStyle(fontSize: size.width*.06, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.width / 22),

                      Text('${widget.degree == null ? ' ' : widget.degree}',
                          maxLines: 3,
                          style:TextStyle(fontSize: size.width*.04,color: Colors.grey[900])),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.bmdcNumber == null
                        ? Container()
                        : Text(
                            'BMDC Number : ${widget.bmdcNumber}',
                            style: TextStyle(fontSize: size.width*.039),
                          ),
                    if (widget.country == null ||
                        widget.state == null ||
                        widget.city == null)
                      Container()
                    else
                      Text(
                        'Address: ${widget.country == null ? ' ' : widget.country}, '
                        '${widget.state == null ? ' ' : widget.state}, ${widget.city == null ? ' ' : widget.city}',
                        style: TextStyle(fontSize: size.width*.038),
                      ),
                    Text(
                      'Phone : ${widget.countryCode}${widget.phone}',
                      style: TextStyle(fontSize: size.width*.039),
                    ),
                    widget.email == null
                        ? Container()
                        : Text(
                            'Email : ${widget.email}',
                            style: TextStyle(fontSize: size.width*.038),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          )),
      SizedBox(
        height: 8.0,
      ),
      Container(
          margin: EdgeInsets.only(left: 10),
          child: Text("Experienced & Fee",
              style: TextStyle(
                  fontSize: size.width*.050,fontWeight: FontWeight.bold,color: Colors.blueGrey)),),

      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xffF4F7F5), borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildExperinceAndFees(context,
                'Experienced : ${widget.experience == null ? '0' : widget.experience} years'),
            SizedBox(
              height: 3.0,
            ),
            _buildExperinceAndFees(context,
                'Appointment Fees :  ${widget.appFee == null ? '0.0' : widget.appFee} ${widget.currency == null ? ' ' : widget.currency}'),
            SizedBox(
              height: 3.0,
            ),
            widget.provideTeleService == true
                ? _buildExperinceAndFees(
                    context,
                    'Telemedicine Fees : '
                    ' ${widget.teleFee == null ? '0.0' : widget.teleFee}  ${widget.currency == null ? ' ' : widget.currency}')
                : Container(),
            SizedBox(
              height: 3.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width:size.width*.5,
                  child:_buildExperinceAndFees(context,
                    'Total TeleFee : ${widget.totalTeleFee == null ? '0' : widget.totalTeleFee} ${widget.currency == null ? ' ' : widget.currency}'),
                ),
                GestureDetector(
                    onTap: ()=>showDialog(
                      context: context,
                      builder: (context) {
                        Widget okButton = FlatButton(
                          child: Text("YES"),
                          onPressed: () {
                            operation.loadingMgs = 'Please wait...';
                            showLoadingDialog(context, operation);
                            operation.updateTeleFee(widget.id,context,_scaffoldKey).then((value){
                              setState(() {
                                widget.totalTeleFee=null;
                              });
                            });
                            //Navigator.pop(context);

                          },
                        );
                        Widget noButton = FlatButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Are you sure you want to Withdraw?"),
                          content: Text("Telefee will be withdrawn"),
                          actions: [
                            noButton,
                            okButton
                          ],
                        );
                        return alert;
                      },
                    ),
                    child: miniOutlineButton(context, 'Withdrawn', Theme.of(context).primaryColor))

              ],
            )
            ],
        ), //child: CategoryContainerUI(),
      ),

      SizedBox(
        height: 10,
      ),

      widget.about == null
          ? Container()
          : Column(
              children: [
                Text("About Doctor",
                    style: TextStyle(
                        fontSize: size.width*.050,fontWeight: FontWeight.bold,color: Colors.blueGrey)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xffF4F7F5),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text('${widget.about}',
                      style: TextStyle(fontSize: size.width*.033),
                      textAlign: TextAlign.justify),
                ),
              ],
            ),
      SizedBox(height: size.width / 20),

      ///Specifications.........

      Container(
        margin: EdgeInsets.only(left: 10, bottom: 5),
        child: Text("Specifications",
            style: TextStyle(
                fontSize: size.width*.050,fontWeight: FontWeight.bold,color: Colors.blueGrey)),
      ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
            borderRadius: BorderRadius.circular(5)
          ),

          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: size.width / 20),
            Text(
              '- ${widget.specification}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width*.042,
                  fontWeight: FontWeight.w500),
            ),
            widget.optionalSpecification == null
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    width: size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.optionalSpecification.length,
                        itemBuilder: (context, index) {
                          return Container(
                              child: Text(
                                  '- ${widget.optionalSpecification[index]}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: size.width*.037,
                                    fontWeight: FontWeight.w500,
                                  )));
                        }),
                  ),
            SizedBox(
              height: size.width / 20,
            ),
          ])),
      SizedBox(
        height: 10,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///Chamber Schedule
          operation.hospitalList.isEmpty?Container():Container(
            margin: EdgeInsets.only(top: 15,left: 10,bottom: 5),
            child: Text("Chamber/Hospital",
              style: TextStyle(fontSize: size.width*.050,fontWeight: FontWeight.bold,color: Colors.blueGrey),
              textAlign: TextAlign.start,),
          ),

          operation.hospitalList.isNotEmpty?
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: ListView.builder(
                itemCount: operation.hospitalList.length>2? 2
                    : operation.hospitalList.length,
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return  Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: HospitalTile(index: index),

                  );
                },
              ),
          )
              :Padding(
            padding: const EdgeInsets.only(top: 50),
            child: NoData(message:'No Chamber/Hospital \u{1f614}'),
          ),

          operation.hospitalList.length>2? Container(
            width: size.width,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: ()=> _viewAllChamberScheduleModal(context,operation),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Text("View all",textAlign: TextAlign.end,style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),),
              ),
            ),
          ):Container(),
          SizedBox(height: 8),

          /// Telemedicine Schedule
          widget.provideTeleService == true
              ? Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: 5, bottom: 5, left: 10),
                  child: Text(
                    "Telemedicine Schedule",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                _openingHoursTelemedicineBuilder(operation),
              ],
            ),
          )
              : Container(),
        ],
      )
    ]);
  }
  ///Chamber/Hospital Modal
  void _viewAllChamberScheduleModal(BuildContext context,DoctorProvider operation){
    Size size= MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              ),
              color: Colors.white
          ),
          child: Column(
            children: [
              Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  //Color(0xffF4F7F5),
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: ()=>Navigator.pop(context),
                    child: Icon(Icons.clear,color: Colors.grey[100],size: 30,),
                  )
              ),

              Expanded(
                child: ListView.builder(
                      itemCount: operation.hospitalList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: HospitalTile(index:index),
                                  ),
                        );
                      }
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  ///Opening Hour Telemedicine Builder
  Widget _openingHoursTelemedicineBuilder(DoctorProvider operation) {
    Size size = MediaQuery.of(context).size;
    final String sat = operation.doctorList[0].sat == null
        ? ''
        : '  Saturday: ${operation.doctorList[0].sat[0]}-${operation.doctorList[0].sat[1]}';
    final String sun = operation.doctorList[0].sun == null
        ? ''
        : '  Sunday: ${operation.doctorList[0].sun[0]}-${operation.doctorList[0].sun[1]}';
    final String mon = operation.doctorList[0].mon == null
        ? ''
        : '  Monday: ${operation.doctorList[0].mon[0]}-${operation.doctorList[0].mon[1]}';
    final String tue = operation.doctorList[0].tue == null
        ? ''
        : '  Tuesday: ${operation.doctorList[0].tue[0]}-${operation.doctorList[0].tue[1]}';
    final String wed = operation.doctorList[0].wed == null
        ? ''
        : '  Wednesday: ${operation.doctorList[0].wed[0]}-${operation.doctorList[0].wed[1]}';
    final String thu = operation.doctorList[0].thu == null
        ? ''
        : '  Thursday: ${operation.doctorList[0].thu[0]}-${operation.doctorList[0].thu[1]}';
    final String fri = operation.doctorList[0].fri == null
        ? ''
        : '  Friday: ${operation.doctorList[0].fri[0]}-${operation.doctorList[0].fri[1]}';
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: Color(0xffF4F7F5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                operation.doctorList[0].sat == null
                    ? Container()
                    : Text(sat, style: TextStyle(fontSize: size.width*.042)),

                operation.doctorList[0].sun == null
                    ? Container()
                    : Text(sun, style: TextStyle(fontSize: size.width*.042)),
                operation.doctorList[0].mon == null
                    ? Container()
                    : Text(mon, style: TextStyle(fontSize: size.width*.042)),

                operation.doctorList[0].tue == null
                    ? Container()
                    : Text(tue, style: TextStyle(fontSize: size.width*.042)),
                operation.doctorList[0].wed == null
                    ? Container()
                    : Text(wed, style: TextStyle(fontSize: size.width*.042)),

                operation.doctorList[0].thu == null
                    ? Container()
                    : Text(thu, style: TextStyle(fontSize: size.width*.042)),

                operation.doctorList[0].fri == null
                    ? Container()
                    : Text(fri, style: TextStyle(fontSize: size.width*.042)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _buildExperinceAndFees(BuildContext context, String buildText) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.topLeft,
      // padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      // decoration: BoxDecoration(
      //   color: Color(0xffF4F7F5),
      // ),
      child: Text(
        buildText,
        style: TextStyle(fontSize: size.width*.042),
      ),
    );
  }
}
class HospitalTile extends StatelessWidget {
  int index;
  HospitalTile({this.index});
  @override
  Widget build(BuildContext context) {
    final TextStyle common = TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Theme.of(context).primaryColor);
    return Consumer<DoctorProvider>(
      builder: (context, operation, child){
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
          title: Text(operation.hospitalList[index].hospitalName),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //address
              Text(operation.hospitalList[index].hospitalAddress,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
              Text(
                '${operation.hospitalList[index].sat==null?'':'Sat: ${operation.hospitalList[index].sat[0]}-${operation.hospitalList[index].sat[1]}  ||  '}'
                    '${operation.hospitalList[index].sun==null?'':'Sun: ${operation.hospitalList[index].sun[0]}-${operation.hospitalList[index].sun[1]}  ||  '}'
                    '${operation.hospitalList[index].mon==null?'':'Mon: ${operation.hospitalList[index].mon[0]}-${operation.hospitalList[index].mon[1]}  ||  '}'
                    '${operation.hospitalList[index].tue==null?'':'Tue: ${operation.hospitalList[index].tue[0]}-${operation.hospitalList[index].tue[1]}  ||  '}'
                    '${operation.hospitalList[index].wed==null?'':'Wed: ${operation.hospitalList[index].wed[0]}-${operation.hospitalList[index].wed[1]}  ||  '}'
                    '${operation.hospitalList[index].thu==null?'':'Thu: ${operation.hospitalList[index].thu[0]}-${operation.hospitalList[index].thu[1]}  ||  '}'
                    '${operation.hospitalList[index].fri==null?'':'Fri: ${operation.hospitalList[index].fri[0]}-${operation.hospitalList[index].fri[1]}  ||  '}',
                style: common,
              )
            ],
          ),

        );
      },
    );
  }
}
