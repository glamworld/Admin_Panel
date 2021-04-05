import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProblemPage extends StatefulWidget {
  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage>{
  //int _counter = 0;
  @override
  Widget build(BuildContext context) {
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);
    // if (_counter == 0) {
    //   operation.getPatientsProblems();
    //   setState(() {
    //     _counter++;
    //   });
    // }
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .035
              ),
              tabs: [
                Tab(icon: Icon(Icons.person),text: 'Doctors Problem',),
                Tab(icon: Icon(Icons.person),text: 'Patients Problem',),
              ],
            ),
            title: Text('Problems',style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * .040
            ),),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              _DoctorsProblem(),
              _PatientsProblem()
            ],
          ),
        ),
      );
  }

  Widget _DoctorsProblem(){
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);
          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: ()=>operation.getDoctorsProblems(),
            child: ListView.builder(
                itemCount: operation.problemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: (){
                          ViewDoctorProblem(context,operation,operation.problemList[index].message);
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Problem: '+operation.problemList[index].message,maxLines:1,style: TextStyle(fontWeight:FontWeight.bold),),
                            Text('Name: '+operation.problemList[index].name)
                            ,
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone: '+operation.problemList[index].phone),
                            Text('Email: '+operation.problemList[index].email),
                            Text('SubmitDate : '+operation.problemList[index].submitDate),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
  }

  Widget _PatientsProblem(){
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);

    return RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: ()=>operation.getPatientsProblems(),
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: operation.patientsProblemList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  onTap: (){
                    ViewPatientProblem(context,operation,operation.patientsProblemList[index].message);
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Problem: '+operation.patientsProblemList[index].message,maxLines:1,style: TextStyle(fontWeight:FontWeight.bold),),
                      Text('Name: '+operation.patientsProblemList[index].name)
                      ,
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: '+operation.patientsProblemList[index].phone),
                      Text('Email: '+operation.patientsProblemList[index].email),
                      Text('SubmitDate : '+operation.patientsProblemList[index].submitDate),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  void ViewDoctorProblem(BuildContext context,FirebaseOperationProvider operation,String msg) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        margin: EdgeInsets.only(left: 10,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Problem: ',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17),),
                            Container(
                              width: 200,
                                child: Text(msg,style: TextStyle(color: Colors.grey[900],fontSize: 17),)),
                          ],
                        ))),
                  )
              ],
            ),
          );
        }
    );
  }

  void ViewPatientProblem(BuildContext context,FirebaseOperationProvider operation,String msg) {
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
                  child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                          margin: EdgeInsets.only(left: 10,top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Problem: ',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 17),),
                              Container(
                                  width: 200,
                                  child: Text(msg,style: TextStyle(color: Colors.grey[900],fontSize: 17),)),
                            ],
                          ))),
                )
              ],
            ),
          );
        }
    );
  }

}



