import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/no_data_widget.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';

// ignore: must_be_immutable
class ViewPrescription extends StatefulWidget {
  String id;
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
  String prescribeDate;
  String prescribeState;
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
  String actualProblem;
  String rx;
  String advice;
  String nextVisit;
  String paymentState;
  String appointState; //telemedicine/chamber
  List<dynamic> medicines;
  String timeStamp;
  String prescribeNo;


  ViewPrescription({
    this.id,
    this.drId,
    this.drName,
    this.drPhotoUrl,
    this.drDegree,
    this.drEmail,
    this.drAddress,
    this.prescribeDate,
    this.prescribeState,
    this.pName,
    this.pId,
    this.pPhotoUrl,
    this.pAddress,
    this.pAge,
    this.pGender,
    this.pProblem,
    this.bookingDate,
    this.bookingSchedule,
    this.rx,
    this.advice,
    this.nextVisit,
    this.paymentState,
    this.appointDate,
    this.appointState,
    this.medicines,
    this.timeStamp,
    this.chamberName,
    this.chamberAddress,
    this.specification,
    this.appFee,
    this.teleFee,
    this.currency,this.actualProblem,this.prescribeNo
  });

  @override
  _ViewPrescriptionState createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescription> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseOperationProvider drProvider = Provider.of<FirebaseOperationProvider>(context);


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      //backgroundColor: Color(0xffF4F7F5),
      appBar: customAppBarDesign(context, "Prescription of ${widget.pName}"),
      body:_bodyUI(drProvider),
    );
  }

  Widget _bodyUI(FirebaseOperationProvider drProvider) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: ListView(
        children: [
          _topSectionBuilder(size,drProvider),
          SizedBox(height: 10),

          _patientInformationSection(size,drProvider),
          SizedBox(height: 20),

          _prescribeDetails(size),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _topSectionBuilder(Size size,FirebaseOperationProvider drProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      //color: Color(0xffF4F7F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Image.asset('assets/logo.png', height: 45,),
          ),
          SizedBox(height: size.width / 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: widget.drPhotoUrl==null? AssetImage('assets/male.png')
                            :NetworkImage(widget.drPhotoUrl),
                        fit: BoxFit.cover
                    )
                ),
              ),
              SizedBox(width: 8),
              Text(
                widget.drName?? "Dr. Name",
                maxLines: 1,
                style: TextStyle(
                    fontSize: size.width / 20,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Text(
            widget.drDegree?? "Degree",
            maxLines: 2,
            style:
            TextStyle(fontSize: size.width / 32, color: Colors.grey[700]),
          ),
          SizedBox(height: size.width / 50),
          Text(
            'Address: '
                '${widget.drAddress??'Empty'}',
            maxLines: 2,
            style:
            TextStyle(fontSize: size.width / 30, color: Colors.grey[700]),
          ),
          Text(
            'Phone: ${widget.drId}',
            maxLines: 1,
            style:
            TextStyle(fontSize: size.width / 30, color: Colors.grey[700]),
          ),
          Text(
            widget.drEmail==null?'': "Email: ${widget.drEmail}",
            maxLines: 1,
            style:
            TextStyle(fontSize: size.width / 30, color: Colors.grey[700]),
          ),
          SizedBox(height: size.width / 40),
          Container(
            height: 2,
            width: size.width,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }

  Widget _patientInformationSection(Size size,FirebaseOperationProvider drProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //color: Color(0xffF4F7F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Date & S.No
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * .43,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Date: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: size.width / 30,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prescribeDate,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: size.width / 32,
                              color: Colors.grey[800]),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[800],
                          width: size.width * .34,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: size.width * .43,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "P.No: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: size.width / 30,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prescribeNo?? '00',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: size.width / 32,
                              color: Colors.grey[800]),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[800],
                          width: size.width * .33,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          //Patient Name
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Patient Name: ",
                maxLines: 1,
                style: TextStyle(
                    fontSize: size.width / 30,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pName,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: size.width / 32, color: Colors.grey[800]),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[800],
                    width: size.width * .71,
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 5),

          //Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Address: ",
                maxLines: 1,
                style: TextStyle(
                    fontSize: size.width / 30,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pAddress??'',
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: size.width / 32, color: Colors.grey[800]),
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey[800],
                    width: size.width * .79,
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 5),

          //Age & Gender
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * .43,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Age: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: size.width / 30,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pAge??'',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: size.width / 32,
                              color: Colors.grey[800]),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[800],
                          width: size.width * .35,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: size.width * .43,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Gender: ",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: size.width / 30,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.pGender??'',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: size.width / 32,
                              color: Colors.grey[800]),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[800],
                          width: size.width * .29,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _prescribeDetails(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.medicines.isEmpty
              ? Container():
          ///Medicine builder
          Container(
              margin: EdgeInsets.only(bottom: 2),
              alignment: Alignment.topLeft,
              child: Text("Prescribe Medicine",
                style:TextStyle(color:Color(0xff00C5A4),fontSize: size.width*.042,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start, )),
          Container(
            margin: EdgeInsets.symmetric(),
            padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xffF4F7F5),
            ),
            //height: 150,

            child: Column(
              children: [
                widget.medicines!=null?ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.medicines.length>4?4
                        :widget.medicines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(widget.medicines[index]),
                      );
                    }
                ):NoData(message: 'No medicine prescribe yet '), //\u{1f614}'
                widget.medicines.length<4?Container(): Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: ()=> ViewAllMedicine(context),
                    child: Text("View all Medicine",textAlign: TextAlign.end,style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          Text("Patient problems", style: TextStyle(color: Theme.of(context).primaryColor,fontSize: size.width*.042, fontWeight: FontWeight.w600),),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(widget.actualProblem??'No problems', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize: size.width*.035)),
          ),
          SizedBox(height: 10),

          Text("Rx.", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600,fontSize: size.width*.042),),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(widget.rx??'No Rx', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize:  size.width*.035)),
          ),
          SizedBox(height: 10),

          Text("Advice", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600,fontSize: size.width*.042),),
          Container(
            margin: EdgeInsets.only(top: 2),
            width: size.width,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(widget.advice??'No Advice', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize:  size.width*.035)),
          ),
          SizedBox(height: 10),

          Text("Next visit", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600,fontSize: size.width*.042),),
          Container(
            width: size.width,
            margin: EdgeInsets.only(top: 2),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(widget.nextVisit??'', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize:  size.width*.035)),
          ),
        ],
      ),
    );
  }

  void ViewAllMedicine(BuildContext context) {
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
              color: Color(0xffF4F7F5),
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
                    itemCount: widget.medicines.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            margin: EdgeInsets.only(left: 10),

                            child: Text(widget.medicines[index])),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
