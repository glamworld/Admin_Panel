import 'package:flutter/material.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/no_data_widget.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';


class AppointmentDetails extends StatefulWidget {
  String id;

  AppointmentDetails({this.id});

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    FirebaseOperationProvider operation=Provider.of<FirebaseOperationProvider>(context);
    if (_counter == 0) {
      operation.getAppointmentIdList(widget.id);
      setState(() {
        _counter++;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBarDesign(context,'Details of Appointment'),
      body:  _counter==0?Center(child: CircularProgressIndicator()):_bodyUi(operation),
    );
  }
  Widget _bodyUi(FirebaseOperationProvider operation) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: ListView(
        children: [
          _topSectionBuilder(size,operation),
          SizedBox(height: 10),

          _patientInformationSection(size,operation),
          SizedBox(height: 20),

          _prescribeDetails(size,operation),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _topSectionBuilder(Size size,FirebaseOperationProvider operation) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.width*.30,
                width: size.width*.27,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: operation.appointmentIdList[0].drPhotoUrl==null? AssetImage('assets/male.png')
                            :NetworkImage(operation.appointmentIdList[0].drPhotoUrl),
                        fit: BoxFit.cover
                    )
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: size.width*.30,
                  width: size.width*.70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${operation.appointmentIdList[0].drName}'?? '',
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: size.width / 20,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${operation.appointmentIdList[0].specification}'?? Container(),
                        maxLines: 1,
                        style:
                        TextStyle(fontSize: size.width / 27, color: Colors.grey[500]),
                      ),
                      Text(
                        '${operation.appointmentIdList[0].drDegree}'?? Container(),
                        maxLines: 2,
                        style:
                        TextStyle(fontSize: size.width / 29, color: Colors.grey[800]),
                      ),
                      Text(
                        'Phone: ${operation.appointmentIdList[0].drId}'??'',
                        maxLines: 1,
                        style:
                        TextStyle(fontSize: size.width / 23, color: Colors.grey[900]),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
         SizedBox(height: 5,),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Address: ${operation.appointmentIdList[0].drAddress??' '}',
               maxLines: 2,
               style:
               TextStyle(fontSize: size.width / 30, color: Colors.grey[800]),
             ),

             Text(
               operation.appointmentIdList[0].drEmail==null?'': "Email: ${operation.appointmentIdList[0].drEmail}",
               maxLines: 1,
               style:
               TextStyle(fontSize: size.width / 30, color: Colors.grey[800]),
             ),
             SizedBox(height: 5),
             Row(
               children: [
                 operation.appointmentIdList[0].appointState=='Online Video Consultation'?
                 Text('Tele Fee:  '+operation.appointmentIdList[0].teleFee,style: TextStyle(fontSize: size.width / 25, color: Colors.blueGrey),):
                 Text('Appointment Fee:  '+operation.appointmentIdList[0].appFee,style: TextStyle(fontSize: size.width / 25, color: Colors.blueGrey),),
                 operation.appointmentIdList[0].currency!=null?Text('  '+operation.appointmentIdList[0].currency,style: TextStyle(fontSize: size.width / 26,color:Colors.blueGrey)):''
               ],
             ),

             //Prescribed date
             operation.appointmentIdList[0].prescribeDate==null?Text('Not Prescribed',style: TextStyle(fontSize: size.width / 25, color: Colors.grey[600]),):
             Text('Prescribed Date: '+operation.appointmentIdList[0].prescribeDate,
                 style: TextStyle(fontSize: size.width / 28, color: Colors.grey[600]),),
             //Chamber Name
             operation.appointmentIdList[0].appointState=='Online Video Consultation'?Text('Online Video Consultation',style:TextStyle(fontSize: size.width / 25, color: Colors.grey[800]),):
             Text('Chamber Name: '+operation.appointmentIdList[0].chamberName,style:TextStyle(fontSize: size.width / 28, color: Colors.grey[900]),),
             //Chamber Address
             operation.appointmentIdList[0].appointState=='Online Video Consultation'?Text(''):
             Text('Chamber Address: '+operation.appointmentIdList[0].chamberAddress,style:TextStyle(fontSize: size.width / 30, color: Colors.grey[900]),),

           ],
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

  Widget _patientInformationSection(Size size,FirebaseOperationProvider operation) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //color: Color(0xffF4F7F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Date & S.No
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Booking Date: ",
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
                    operation.appointmentIdList[0].bookingDate??'',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * .45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "App Date: ",
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
                          '${operation.appointmentIdList[0].appointDate}' ??'',
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
              Container(
                width: size.width * .45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Schedule: ",
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
                          operation.appointmentIdList[0].bookingSchedule?? '',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: size.width / 32,
                              color: Colors.grey[800]),
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey[800],
                          width: size.width * .28,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),



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
                    operation.appointmentIdList[0].pName??'',
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
                    operation.appointmentIdList[0].pAddress??'',
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
                          operation.appointmentIdList[0].pAge??'',
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
                          operation.appointmentIdList[0].pGender??'',
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
///
  Widget _prescribeDetails(Size size,FirebaseOperationProvider operation) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Medicine builder
          Container(
              margin: EdgeInsets.only(bottom: 2),
              alignment: Alignment.topLeft,
              child: Text("Prescribe Medicine",
                style:TextStyle(color:Color(0xff00C5A4),fontSize: size.width*.042,fontWeight: FontWeight.bold),
                textAlign: TextAlign.start, )),
          // operation.appointmentIdList[0].medicines==null
          //     ? Container():

          Container(
            //margin: EdgeInsets.symmetric(),
            padding:EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xffF4F7F5),
            ),
            //height: 150,

            child: Column(
              children: [
                operation.appointmentIdList[0].medicines!=null?ListView.builder(
                    shrinkWrap: true,
                    itemCount: operation.appointmentIdList[0].medicines.length>4?4
                        :operation.appointmentIdList[0].medicines.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(operation.appointmentIdList[0].medicines[index],style: TextStyle(fontSize: size.width*.035),),
                      );
                    }
                ):NoData(message: 'No medicine prescribe yet '), //\u{1f614}'
                operation.appointmentIdList[0].medicines==null?Container(): Container(
                  width: size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: ()=> ViewAllMedicine(context,operation),
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
            child: Text(operation.appointmentIdList[0].actualProblem??'No problems', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize: size.width*.035)),
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
            child: Text(operation.appointmentIdList[0].rx??'No Rx', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize:  size.width*.035)),
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
            child: Text(operation.appointmentIdList[0].advice??'No Advice', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize:  size.width*.035)),
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
            child: Text(operation.appointmentIdList[0].nextVisit??'', style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w600,fontSize:  size.width*.035)),
          ),
        ],
      ),
    );
  }
  ///
  void ViewAllMedicine(BuildContext context,FirebaseOperationProvider operation) {
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
                    itemCount: operation.appointmentIdList[0].medicines.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                            margin: EdgeInsets.only(left: 10),

                            child: Text(operation.appointmentIdList[0].medicines[index]??'')),
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
