import 'package:admin_panel/providers/representative_provider.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:admin_panel/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../notification_widget.dart';

class AddRepresentative extends StatefulWidget {
  @override
  _AddRepresentativeState createState() => _AddRepresentativeState();
}

class _AddRepresentativeState extends State<AddRepresentative> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int address = 1;
  String date = "";

  void _initializeShopData(RepresentativeProvider auth) {
    auth.manufacturerRepresentativeModel.representativeName = '';
    auth.manufacturerRepresentativeModel.companyName = '';
    auth.manufacturerRepresentativeModel.phoneNumber = '';
    auth.manufacturerRepresentativeModel.email = '';
    auth.manufacturerRepresentativeModel.nid = '';
    auth.manufacturerRepresentativeModel.dob = '';
    auth.manufacturerRepresentativeModel.address = '';
    auth.manufacturerRepresentativeModel.executiveName = '';
    auth.manufacturerRepresentativeModel.executivePhone = '';
  }

  DateTime _currentDate = new DateTime.now();

  Future<Null> _selectDate(BuildContext context, RepresentativeProvider auth) async {
    final DateTime _selDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(1920),
      lastDate: DateTime(2100),
    );
    setState(() {
      date = DateFormat("dd/MM/yyyy").format(_selDate);
      auth.manufacturerRepresentativeModel.dob = "$date";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RepresentativeProvider>(builder: (context, auth, child) {
      if (auth.manufacturerRepresentativeModel.representativeName == null ||
          auth.manufacturerRepresentativeModel.companyName == null ||
          auth.manufacturerRepresentativeModel.dob == null) {
        _initializeShopData(auth);
      }
      return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: customAppBarDesign(context, "Add New Representative"),
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///Representative Form...
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Column(
                      children: [
                        ///Representative Name...
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Representative Name",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel
                                  .representativeName = val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Company Name...
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Company Name",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel.companyName =
                                  val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Phone Number...
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Phone Number",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel.phoneNumber =
                                  val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Password...
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Password",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel.password =
                                  val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Email...
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Email", fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel.email = val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///NID...
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "NID", fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel.nid = val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Date Of Birth...
                        Container(
                          //padding: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Color(0xffF4F7F5),
                              borderRadius: BorderRadius.circular(10.0)),

                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text("Date of Birth",
                                    style: TextStyle(
                                        color: Colors.grey[10], fontSize: 15)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.02,
                                child: Text(":", style: colonTextStyle()),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 20.0),
                                  color: Color(0xffF4F7F5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Text(
                                    date,
                                    style: simpleTextStyle(),
                                  ),
                                ),
                                onTap: () {
                                  _selectDate(context, auth);
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),

                        ///Address...
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: address,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              fillColor: Color(0xffF4F7F5),
                              hintText: "Address"),
                          onChanged: (String val) {
                            if (val.length >= 40) setState(() => address = 2);
                            if (val.length >= 80) setState(() => address = 4);
                            if (val.length >= 160) setState(() => address = 7);
                            setState(() {
                              auth.manufacturerRepresentativeModel.address =
                                  val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Executive Name...
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Executive Name",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel
                                  .executiveName = val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Executive Phone Number...
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Executive Phone Number",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.manufacturerRepresentativeModel
                                  .executivePhone = val;
                            });
                          },
                        ),
                        SizedBox(height: 15),

                        ///Submit Button...
                        GestureDetector(
                          onTap: () {
                            _checkValidity(auth);
                          },
                          child: Button(context, "Submit  Representative"),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }

  Future<void> _checkValidity(RepresentativeProvider auth) async {

    try {
      if (auth.manufacturerRepresentativeModel.representativeName != null &&
          auth.manufacturerRepresentativeModel.companyName != null &&
          auth.manufacturerRepresentativeModel.phoneNumber != null &&
          auth.manufacturerRepresentativeModel.password != null &&
          auth.manufacturerRepresentativeModel.email != null &&
          auth.manufacturerRepresentativeModel.nid != null &&
          auth.manufacturerRepresentativeModel.dob != null &&
          auth.manufacturerRepresentativeModel.address != null &&
          auth.manufacturerRepresentativeModel.executiveName != null &&
          auth.manufacturerRepresentativeModel.executivePhone != null) {

        auth.loadingMgs = 'Please wait...';
        showLoadingDialog(context, auth);
         await auth.addRepresentative(auth.manufacturerRepresentativeModel, _scaffoldKey, context,auth).then((value) {
           auth.manufacturerRepresentativeModel = null;
         });
      } else
        showSnackBar(_scaffoldKey, 'Complete all the required fields');
    } catch (error) {
      showSnackBar(_scaffoldKey, error.toString());
    }
  }
}
