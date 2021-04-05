import 'package:admin_panel/subpage/patient_details/patient_appointment_details.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../notification_widget.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';

class PatientAppointmentList extends StatefulWidget {
  String id;

  PatientAppointmentList({this.id});

  @override
  _PatientAppointmentListState createState() => _PatientAppointmentListState();
}

class _PatientAppointmentListState extends State<PatientAppointmentList> {

  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    FirebaseOperationProvider operation=Provider.of<FirebaseOperationProvider>(context);
    if (_counter == 0) {
      operation.getPatientAppointment(widget.id);
      setState(() {
        _counter++;
      });
    }
    return Scaffold(
      backgroundColor: Color(0xffF4F7F5),
      body: _counter==0?Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 5,),
            Container(
              height: size.height*.68,
              //color: Color(0xffF4F7F5),
              child: ListView.builder(
                  itemCount: operation.appointmentList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: PatientAppointBuildersTile(
                        id: operation.appointmentList[index].id,
                        drName: operation.appointmentList[index].drName,
                        specification: operation.appointmentList[index].specification,
                        appointDate: operation.appointmentList[index].appointDate,
                        pProblem: operation.appointmentList[index].pProblem,
                        appointState: operation.appointmentList[index].appointState,
                        chamberName: operation.appointmentList[index].chamberName,
                        prescribeState: operation.appointmentList[index].prescribeState,
                        bookingSchedule: operation.appointmentList[index].bookingSchedule,
                        bookingDate: operation.appointmentList[index].bookingDate,
                      ),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
class PatientAppointBuildersTile extends StatelessWidget {
  String id,drName,specification,appointDate,pProblem,appointState,chamberName,prescribeState,bookingSchedule,bookingDate;
  PatientAppointBuildersTile({this.id,this.drName,this.specification,this.appointDate,this.pProblem,
    this.appointState,this.chamberName,this.prescribeState,this.bookingSchedule,this.bookingDate});
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);
    return GestureDetector(
          onTap: ()async{
            operation.loadingMgs='Please wait...';
            showLoadingDialog(context,operation);
            await operation.getAppointmentIdList(id).then((value){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentDetails(id: id,)));
            },onError: (error){
              Navigator.pop(context);
              showAlertDialog(context, error.toString());
            });

          },
          child: Container(
            padding: EdgeInsets.only(left: 10,right:5,top: 5,bottom: 5),
            margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
            height: size.width * .26, //     color: Color(0xffF4F7F5),
            decoration: simpleCardDecoration,

            child: Row(
              children: [
                Container(
                  //prescribeState
                  //color: Colors.red,
                  width: size.width*.77,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("With ", maxLines: 1,style: TextStyle(fontSize: 9,color: Colors.blueGrey),),
                          Expanded(
                            child: Text('$drName',
                              maxLines: 1,
                              style: TextStyle(fontSize: size.width*.044,color: Colors.grey[900]),),
                          ),
                        ],
                      ),
                      Text('${pProblem!=null? '$pProblem':'your problem'}',
                        maxLines: 1,
                        style: TextStyle(fontSize: size.width*.030,color: Colors.black),),
                      appointState=='Online Video Consultation'?Text('Online Video Consultation', maxLines: 1,
                        style: TextStyle(fontSize: size.width*.032,color: Colors.grey[700]),)
                          :Text(chamberName, maxLines: 1,
                          style: TextStyle(fontSize: size.width*.030,color: Colors.blueGrey),),
                      // Text('${chamberName!=null? '$chamberName':'Chamber name'}',
                      //   maxLines: 1,
                      //   style: TextStyle(fontSize: size.width*.031,color: Colors.blueGrey),),

                      Text( 'Schedule: $bookingSchedule' ?? 'Time schudule',
                        maxLines: 1,
                        style: TextStyle(fontSize: size.width*.030,color: Colors.blueGrey),),


                      Text('ApointDate: $appointDate',
                        maxLines: 1,
                        style: TextStyle(fontSize: size.width*.030,color: Colors.blueGrey),),



                      Text('Booking on: $bookingDate',
                        maxLines: 1,
                        style: TextStyle(fontSize: size.width*.030,color: Colors.black),)

                      // doctorName!=null?Text('With: '+ doctorName,style: TextStyle(fontSize: 15,color:Colors.blueGrey,fontWeight:FontWeight.bold  ),):Text(''),
                      // date!=null?Text(date,style: boldTextStyle(),):Text(''),
                      //
                      // department!=null?Text(department,style: TextStyle(fontSize: 12 )):Text(''),
                      // problem!=null?Text(problem,style: TextStyle(fontSize: 13,color:Colors.blueGrey,fontWeight:FontWeight.bold ),):Text(''),
                      // appointmentState=='Online Video Consultation'?Text('Online Video Consultation'):Text(chamberName,style: simpleTextStyle(),)

                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        miniOutlineButton(context, 'View', Theme.of(context).primaryColor),
                        prescribeState=='yes'?Text('Prescribed',
                          style: TextStyle(color: Theme.of(context).primaryColor,fontSize: size.width*.029,fontStyle: FontStyle.italic),)
                            :Text('Not prescribed',
                            style: TextStyle(color: Color(0xffFFBA00),fontSize: size.width*.03,fontStyle: FontStyle.italic),textAlign: TextAlign.end,)

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }
}