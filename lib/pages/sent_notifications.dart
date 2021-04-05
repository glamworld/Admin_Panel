import 'package:admin_panel/subpage/send_notification.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/utils/custom_clipper.dart';
import 'package:admin_panel/utils/widget.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';

class SentNotifications extends StatefulWidget {
  @override
  _SentNotificationsState createState() => _SentNotificationsState();
}

class _SentNotificationsState extends State<SentNotifications> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF4F7F5),
      appBar: _customAppBar(context),
      body: _bodyUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => SendNotification())),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
        tooltip: "Send Notification",
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _bodyUI() {
    Size size = MediaQuery.of(context).size;
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);

          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: ()=>operation.getNotifications(),
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: operation.notificationList.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Container(
                          width: size.width * 0.50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'To: '+operation.notificationList[index].category,
                                  style: boldTextStyle(),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  operation.notificationList[index].title,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  operation.notificationList[index].message,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        ),
                        subtitle: Container(
                          child: Text(
                            operation.notificationList[index].date,
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              builder: (context) {
                                Widget okButton = FlatButton(
                                  child: Text("YES"),
                                  onPressed: () {
                                    operation.deleteNotification(operation.notificationList[index].id,context,_scaffoldKey,operation);
                                    Navigator.pop(context);

                                  },
                                );
                                Widget noButton = FlatButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                AlertDialog alert = AlertDialog(
                                  title: Text("Are you sure you want to delete this Notification?"),
                                  content: Text("This Notification will be deleted"),
                                  actions: [
                                    noButton,
                                    okButton
                                  ],
                                );
                                return alert;
                              },
                            );
                          },
                          icon: Icon(Icons.delete,color: Colors.red,),
                        ),
                      ),
                    ),
                  );
                }),
          );
  }

  Widget _customAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: AppBar(
        title: Text(
          'Notification List',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: MyCustomClipperForAppBar(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Color(0xffBCEDF2),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  tileMode: TileMode.clamp,
                )),
          ),
        ),
      ),
    );
  }
}
