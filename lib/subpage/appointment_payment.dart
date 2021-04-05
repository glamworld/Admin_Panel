import 'package:flutter/material.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/widget.dart';
class AppointmentPayment extends StatefulWidget {
  @override
  _AppointmentPaymentState createState() => _AppointmentPaymentState();
}

class _AppointmentPaymentState extends State<AppointmentPayment> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF4F7F5),
      body: _bodyUI(),
    );
  }

  Widget _bodyUI() {
    Size size = MediaQuery.of(context).size;
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);

    return RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: ()=>operation.getAppointmentPayment(),
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: operation.paymentAppointmentList.length,
          itemBuilder: (_, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: ()=>_showDialog(operation, index),
                  title: Container(
                    width: size.width * 0.50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        operation.paymentAppointmentList[index].pName!=null?Text(
                            'Patient Name: '+operation.paymentAppointmentList[index].pName,
                            style: boldTextStyle(),
                            textAlign: TextAlign.left):Text('No date'),
                        SizedBox(
                          height: 5,
                        ),
                        operation.paymentAppointmentList[index].drName!=null?Text(
                            'Doctor Name: '+operation.paymentAppointmentList[index].drName,
                            style: TextStyle(
                              fontSize: 15,color: Colors.blueGrey
                            )):Text('No date'),
                        SizedBox(
                          height: 5,
                        ),
                        operation.paymentAppointmentList[index].amount!=null?Text(
                            'Amount: '+operation.paymentAppointmentList[index].amount,
                            style: TextStyle(
                              fontSize: 14,
                            )):Text('No date'),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),

                  subtitle: Container(
                    child: operation.paymentAppointmentList[index].paymentDate!=null?Text(
                      operation.paymentAppointmentList[index].paymentDate,
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ):Text('No date'),
                  ),
                ),
              ),
            );
          }),
    );
  }
  _showDialog(FirebaseOperationProvider operation,int index) {
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context,listen: false);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              scrollable: true,
              contentPadding: EdgeInsets.all(20),
              title: Text(
                "Appointment Payment details",style: TextStyle(color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              content: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Patient Name: '+operation.paymentAppointmentList[index].pName,
                                style: boldTextStyle(),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Doctor Name: '+operation.paymentAppointmentList[index].drName,
                                style: TextStyle(
                                    fontSize: 15,color: Colors.blueGrey
                                )),
                            SizedBox(
                              height: 10,
                            ),
                           Text(
                                'Amount: '+operation.paymentAppointmentList[index].amount,
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'Currency: '+operation.paymentAppointmentList[index].currency,
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                'transaction Id: '+operation.paymentAppointmentList[index].transactionId,
                                style: TextStyle(
                                  fontSize: 14,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      subtitle: Container(
                        child: operation.paymentAppointmentList[index].paymentDate!=null?Text(
                          operation.paymentAppointmentList[index].paymentDate,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ):Text('No date'),
                      ),
                    ),
                  )
              ));

        });
  }

}
