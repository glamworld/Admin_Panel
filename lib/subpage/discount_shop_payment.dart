import 'package:flutter/material.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/widget.dart';
class DiscountShopPayment extends StatefulWidget {
  @override
  _DiscountShopPaymentState createState() => _DiscountShopPaymentState();
}

class _DiscountShopPaymentState extends State<DiscountShopPayment> {
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
      onRefresh: ()=>operation.getDiscountPayment(),
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: operation.paymentDiscountList.length,
          itemBuilder: (_, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: ()=>_showDialog(operation,index),
                  title: Container(
                    width: size.width * 0.50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        operation.paymentDiscountList[index].pName!=null?Text(
                            'Patient Name: '+operation.paymentDiscountList[index].pName,
                            style: boldTextStyle(),
                            textAlign: TextAlign.left):Text('No date'),
                        SizedBox(
                          height: 5,
                        ),
                        operation.paymentDiscountList[index].shopName!=null?Text(
                            'Shop Name: '+operation.paymentDiscountList[index].shopName,
                            style: TextStyle(
                              fontSize: 15,color: Colors.blueGrey
                            )):Text('No date'),
                        SizedBox(
                          height: 5,
                        ),
                        operation.paymentDiscountList[index].amount!=null?Text(
                            'Amount: '+operation.paymentDiscountList[index].amount,
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
                    child: operation.paymentDiscountList[index].paymentDate!=null?Text(
                      operation.paymentDiscountList[index].paymentDate,
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
              "Discount Shop Payment details",style: TextStyle(color: Colors.blue),
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
                            'Patient Name: '+operation.paymentDiscountList[index].pName,
                            style: boldTextStyle(),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Shop Name: '+operation.paymentDiscountList[index].shopName,
                            style: TextStyle(
                                fontSize: 15,color: Colors.blueGrey
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Amount: '+operation.paymentDiscountList[index].amount,
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Currency: '+operation.paymentDiscountList[index].currency,
                            style: TextStyle(
                              fontSize: 14,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'transaction Id: '+operation.paymentDiscountList[index].transactionId,
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
                    child: Text(
                      'Payment Date: '+operation.paymentDiscountList[index].paymentDate,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
              )
          ));

        });
  }
}
