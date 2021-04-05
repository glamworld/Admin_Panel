import 'package:admin_panel/providers/representative_provider.dart';
import 'package:admin_panel/subpage/add_representative.dart';
import 'package:admin_panel/utils/custom_clipper.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:admin_panel/utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_panel/model/manufacturer-representator_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/subpage/manufacturer_profile_tab.dart';
import 'package:admin_panel/notification_widget.dart';

class ManufacturerRepresentative extends StatefulWidget {
  @override
  _ManufacturerRepresentativeState createState() => _ManufacturerRepresentativeState();
}

class _ManufacturerRepresentativeState extends State<ManufacturerRepresentative> {
  List<ManufacturerRepresentativeModel> filteredRepresentative = List();
  List<ManufacturerRepresentativeModel> representativeList = List();
  int _counter = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    RepresentativeProvider operation =
    Provider.of<RepresentativeProvider>(context);
    if (_counter == 0) {
      operation.getRepresentative().then((value){
        setState(() {
          representativeList=operation.representativeList;
          filteredRepresentative=representativeList;
          _counter++;
        });
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF4F7F5),
      appBar: _customAppBar(context),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search by representative phone no..',
            ),
            onChanged: (string) {
              setState(() {
                filteredRepresentative = representativeList
                    .where((u) => (u.phoneNumber
                    //.toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });

            },
          ),
          Expanded(child: _counter==0?Center(child: CircularProgressIndicator()):_bodyUI()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddRepresentative())),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
        tooltip: "Add Representative",
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
    RepresentativeProvider operation =
        Provider.of<RepresentativeProvider>(context);
          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: ()async{
              await operation.getRepresentative().then((value){
                setState(() {
                  representativeList=operation.representativeList;
                  filteredRepresentative=representativeList;
                });
              });
            },
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: filteredRepresentative.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 2),
                    //padding: const EdgeInsets.all(8.0),
                    decoration: simpleCardDecoration,
                    child: ListTile(
                        onTap: () async{
                          operation.loadingMgs='Please wait...';
                          showLoadingDialog(context,operation);
                         await operation.getRepresentativeMedicine(filteredRepresentative[index].phoneNumber).then((value){
                           Navigator.pop(context);
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => ManufacturerProfileTab(
                                     companyName: filteredRepresentative[index]
                                         .companyName,
                                     representatorName: filteredRepresentative[index]
                                         .representativeName,
                                     date: filteredRepresentative[index].date,
                                     phoneNumber: filteredRepresentative[index]
                                         .phoneNumber,
                                     address: filteredRepresentative[index].address,
                                     email: filteredRepresentative[index].email,
                                   )));
                         });
                        },
                        title: Container(
                          //color: Colors.red,
                          width: size.width * 0.50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${filteredRepresentative[index].representativeName??''}',
                                  maxLines: 1,
                                  style: TextStyle(fontSize: size.width*.048,color: Colors.grey[900]),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                  filteredRepresentative[index].companyName??'' ,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: size.width*.038, color: Colors.grey[700]
                                  )),
                              SizedBox(
                                height: 1,
                              ),
                              Text(
                                  filteredRepresentative[index].phoneNumber??'' ,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: size.width*.042, color: Colors.grey[800],
                                  )),
                              SizedBox(
                                height: 1,
                              ),
                            ],
                          ),
                        ),
                        subtitle: Container(
                          child: Text(
                            'Joining Date: ${filteredRepresentative[index].date??' '}',
                            maxLines: 1,
                            style: TextStyle(fontSize: size.width*.033, color: Colors.grey[600]),
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
                                  operation.loadingMgs = 'Please wait...';
                                  showLoadingDialog(context, operation);
                                  operation.deleteRepresentative(filteredRepresentative[index].id,context,_scaffoldKey,operation);
                                  filteredRepresentative=representativeList;
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
                                title: Text("Are you sure you want to delete this representative?"),
                                content: Text("This representative will be deleted"),
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
                  );
                }),
          );
  }

  Widget _customAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: AppBar(
        title: Text(
          'Representative List',
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
