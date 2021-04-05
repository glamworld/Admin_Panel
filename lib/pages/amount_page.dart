import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/button_widgets.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/providers/auth_provider.dart';

class AmountPage extends StatefulWidget {
  @override
  _AmountPageState createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  final _addKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AuthProvider auth =
    Provider.of<AuthProvider>(context);
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF4F7F5),
      appBar: customAppBarDesign(context,'Amount Details'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Appointment Charge : ',style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                )),
                Text('${operation.amountList[0].amountCharge} Tk',style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dollar unit in bdt: ',style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                )),
                Text('${operation.amountList[0].dollarUnit} Tk',style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ))
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
                onTap: (){
                  _showDialog(auth);
                },
                child: ChangeButton(context,'Update',Colors.blue))
          ],
        ),
      ),
    );
  }
  _showDialog(AuthProvider auth) {
    String chargeAmount;
    String dollarUnit;
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context,listen: false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(20),
            title: Text(
              "Update amount details",
              textAlign: TextAlign.center,
            ),
            content: Container(
              child: Form(
                key: _addKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: operation.amountList[0].amountCharge,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Write appointment Amount'),
                      onSaved: (val) {
                        chargeAmount = val;
                      },
                      validator: (val) =>
                      val.isEmpty ? 'please enter appointment charge' : null,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: operation.amountList[0].dollarUnit,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Write Dollar Unit in BDT'),
                      onSaved: (val) {
                        dollarUnit = val;
                      },
                      validator: (val) =>
                      val.isEmpty ? 'please enter dollar unit' : null,

                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          color: Colors.redAccent,
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RaisedButton(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {
                            if (_addKey.currentState.validate()) {
                              _addKey.currentState.save();
                              setState(() {
                                auth.amountModel.dollarUnit = dollarUnit;
                                auth.amountModel.amountCharge = chargeAmount;
                              });
                              auth.loadingMgs = 'Please wait...';
                              showLoadingDialog(context, auth);
                              auth.addAmount(
                                  auth.amountModel, _scaffoldKey, context);
                              operation.getAmount();
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
