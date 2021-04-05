import 'package:admin_panel/model/patient_model.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/providers/patient_provider.dart';
import 'package:admin_panel/subpage/patient_details/patient_profile_tab.dart';
import 'package:admin_panel/utils/custom_clipper.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  List<PatientsModel> filteredPatients = List();
  List<PatientsModel> patientList = List();
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    PatientProvider operation =
    Provider.of<PatientProvider>(context);
    if (_counter == 0) {
      operation.getPatients().then((value){
        setState(() {
          patientList=operation.patientList;
          filteredPatients=patientList;
          _counter++;
        });
      });
    }
    return Scaffold(
      backgroundColor: Color(0xffF4F7F5),
      appBar: _customAppBar(),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Search by Patient phone no..',
            ),
            onChanged: (string) {
              setState(() {
                filteredPatients = patientList
                    .where((u) => (u.phone
                    //.toLowerCase()
                    .contains(string.toLowerCase())))
                    .toList();
              });

            },
          ),
          Expanded(child: _counter==0?Center(child: CircularProgressIndicator()):_bodyUI()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }

  Widget _customAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: AppBar(
        title: Text(
          'Patients',
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

  Widget _bodyUI() {
    PatientProvider operation =
    Provider.of<PatientProvider>(context);
          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: () async{
             await operation.getPatients().then((value){
                setState(() {
                  patientList=operation.patientList;
                  filteredPatients=patientList;
                });
              });
            },
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  return PatientsBuildersTile(
                    id: filteredPatients[index].id,
                    image: filteredPatients[index].imageUrl,
                    name: filteredPatients[index].name,
                    age: filteredPatients[index].age,
                    joinDate: filteredPatients[index].joinDate,
                    phoneNum: filteredPatients[index].countryCode+filteredPatients[index].phone,
                    email: filteredPatients[index].email,
                    gender: filteredPatients[index].gender,
                    address: filteredPatients[index].address,
                    bloodGroup: filteredPatients[index].bloodGroup,
                  );
                }),
          );
  }
}

class PatientsBuildersTile extends StatelessWidget {
  String  id,image,name, joinDate, phoneNum, email, age, gender, address,bloodGroup;

  PatientsBuildersTile(
      {this.id,
        this.name,
        this.image,
        this.joinDate,
        this.phoneNum,
        this.email,
        this.age,
        this.gender,
        this.bloodGroup,
        this.address});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientProfileTab(
          id: id,
          image: image,
          name: name,
          joinDate: joinDate,
          age: age,
          phoneNum: phoneNum,
          email: email,
          gender: gender,
          address: address,
          bloodGroup: bloodGroup,

        )));
      },
      child: Container(
            padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
        margin: EdgeInsets.only(left: 5,right: 5,top: 8,bottom: 2),
        height: size.width * .20,
        decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.width*0.20,
                  width: size.width*0.19,
                  decoration: BoxDecoration(
                    //assets/male.png
                    //color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: image==null?
                  Image.asset('assets/male.png',color: Theme.of(context).primaryColor,height: size.width*0.20, width: size.width*0.19,):ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/loadingimage.gif',height: size.width*0.20, width: size.width*0.19,fit: BoxFit.cover,),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: size.width*0.19,
                      height: size.width*0.20,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width*0.01,right: size.width*0.01),
                  width: size.width*.58,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name??'',
                        maxLines: 1,
                        style:
                        TextStyle(fontSize: size.width / 20, color: Colors.grey[900]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(phoneNum,
                        maxLines: 1,
                        style:
                        TextStyle(fontSize: size.width / 22, color: Colors.grey[800]),
                      ),
                      Text(joinDate,
                          style: TextStyle(fontSize: size.width / 28, color: Colors.grey)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    miniOutlineButton(context, 'Details', Theme.of(context).primaryColor),
                  ],
                )
              ],
            ),
      ),
    );
  }
}