import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:admin_panel/utils/static_variable_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import '../notification_widget.dart';

class SendNotification extends StatefulWidget {
  @override
  _SendNotificationState createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int notifications = 2;
  String selectSentNotificationCategory;

  void _initializeNotification(AuthProvider auth) {
    auth.notificationModel.title = '';
    auth.notificationModel.message = '';
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, child)
    {
      if (auth.notificationModel.title == null ||
          auth.notificationModel.message == null) {
        _initializeNotification(auth);
      }
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: customAppBarDesign(context, "Send Notification"),
        body: _bodyUI(auth),
      );
    });
  }
  Widget _bodyUI(AuthProvider auth) {
    Size size = MediaQuery.of(context).size;
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);
    return Container(
      color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              ///Sent Notification Form...
              Form(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(

                    children: [
                      ///Sent Notification Category...
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xffF4F7F5),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        width: size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectSentNotificationCategory,
                            hint: Text("Selected Notification Category",style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 16)),
                            items: StaticVariables.sentNotificationCategoryList.map((category){
                              return DropdownMenuItem(
                                child: Text(category,style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 16,)),
                                value: category,
                              );
                            }).toList(),
                            onChanged: (newValue)=> setState(() {
                              selectSentNotificationCategory = newValue;
                              auth.notificationModel.category = selectSentNotificationCategory;
                            }),
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      ///Sent Notification title
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Title",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val){
                          setState(() {
                            auth.notificationModel.title = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      ///Notifications...
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: notifications,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            fillColor: Color(0xffF4F7F5),
                            hintText: "Notifications"),
                        onChanged: (String val) {
                          if (val.length >= 40) setState(() => notifications = 2);
                          if (val.length >= 80) setState(() => notifications = 4);
                          if (val.length >= 160) setState(() => notifications = 7);
                          if (val.length >= 300) setState(() => notifications = 11);
                          if (val.length >= 500) setState(() => notifications = 18);
                          setState(() {
                            auth.notificationModel.message = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      ///Submit Button...
                      GestureDetector(
                        onTap: (){
                          _checkValidity(auth,operation);
                        },
                        child: Button(context, "Send Notification"),
                      ),
                      SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
            ],
          ),
        ),
    );
  }

  Future<void> _checkValidity(AuthProvider auth,FirebaseOperationProvider operation) async {
    try {
      if (auth.notificationModel.category != null &&
          auth.notificationModel.title != null &&
          auth.notificationModel.message != null) {
        auth.loadingMgs = 'Please wait...';
        showLoadingDialog(context, auth);
        await auth.sendNotificaton(auth.notificationModel, _scaffoldKey, context,operation).then((value)async {
           Navigator.pop(context);
           Navigator.pop(context);
           auth.notificationModel = null;
        },onError: (){
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(_scaffoldKey, 'Error sending notification. Try again');
        });
      } else
        showSnackBar(_scaffoldKey, 'Complete all the required fields');
    } catch (error) {
      //showSnackBar(_scaffoldKey, error.toString());
    }
  }
}
