import 'package:admin_panel/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
class PatientsProfile extends StatefulWidget {
  String image;
  String name;
  String date;
  String age;
  String phoneNum;
  String email;
  String gender;
  String address;
  String bloodGroup;
  PatientsProfile(
      {this.image,
        this.name,
        this.date,
        this.age,
        this.phoneNum,
        this.email,
        this.gender,
        this.address,
        this.bloodGroup,
      }
      );
  @override
  _PatientsProfileState createState() => _PatientsProfileState();
}

class _PatientsProfileState extends State<PatientsProfile> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyUI(),
    );
  }
  Widget _bodyUI(){
    Size size=MediaQuery.of(context).size;
    FirebaseOperationProvider operation=Provider.of<FirebaseOperationProvider>(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.0,),
      child: Column(
        children: [
          SizedBox(height: 8.0,),
          Container(
              //color: Color(0xff00C5A4),
              //width: size.width,
              //height: 250,
            child:Column(
              children: [
                Container(
                  //padding: EdgeInsets.all(10),
                  color: Colors.white,
                  height: size.width * .45,
                  width: size.width,
                  child: Row(
                    children: [
                      Container(
                        width: size.width * .42,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color(0xffAAF1E8),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: widget.image==null?
                        Image.asset("assets/male.png", width: size.width * .42)
                            :ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: widget.image,
                            placeholder: (context, url) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/loadingimage.gif',width: size.width * .42,
                                fit: BoxFit.cover,),
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                            width: size.width * .42,
                            height: size.height * .26,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * .45,
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name??'',
                              maxLines: 3,
                              style:
                              TextStyle(fontSize: size.width*.06, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: size.width / 15),

                            Text('${widget.phoneNum== null ? ' ' : widget.phoneNum}',
                                maxLines: 3,
                                style:TextStyle(fontSize: size.width*.046,color: Colors.grey[900])),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
              // child:Container(
              //   width: size.width * .30,
              //   //alignment: Alignment.topLeft,
              //   padding: EdgeInsets.all(4),
              //   decoration: BoxDecoration(
              //     color: Color(0xffAAF1E8),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: widget.image==null? Image.asset('assets/male.png',color: Theme.of(context).primaryColor,)
              //       :ClipRRect(
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     child: CachedNetworkImage(
              //       imageUrl: widget.image,
              //       placeholder: (context, url) => Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: CircularProgressIndicator(),
              //       ),
              //       errorWidget: (context, url, error) => Icon(Icons.error),
              //       width: size.width * .30,
              //       height: size.height * .15,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              ///
              // child: Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     SizedBox(height: 4.0,),
              //     // Container(
              //     //   width: size.width * .30,
              //     //   //alignment: Alignment.topLeft,
              //     //   padding: EdgeInsets.all(4),
              //     //   decoration: BoxDecoration(
              //     //       color: Color(0xffAAF1E8),
              //     //       borderRadius: BorderRadius.circular(10),
              //     //   ),
              //     //   child: widget.image==null? Image.asset('assets/male.png',color: Theme.of(context).primaryColor,)
              //     //       :ClipRRect(
              //     //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     //     child: CachedNetworkImage(
              //     //       imageUrl: widget.image,
              //     //       placeholder: (context, url) => Padding(
              //     //         padding: const EdgeInsets.all(8.0),
              //     //         child: CircularProgressIndicator(),
              //     //       ),
              //     //       errorWidget: (context, url, error) => Icon(Icons.error),
              //     //       width: size.width * .30,
              //     //       height: size.height * .15,
              //     //       fit: BoxFit.fill,
              //     //     ),
              //     //   ),
              //     // ),
              //     // SizedBox(height: 8.0,),
              //     //   Text(widget.name,style: TextStyle(fontSize: 19,color: Colors.white)),
              //     //   Text(widget.date,style:  TextStyle(fontSize: 11,color: Colors.white)),
              //     //   Text('Age : '+widget.age,style:  TextStyle(fontSize: 16,color: Colors.white)),
              //     //   Text('Sex : '+ widget.gender,style:  TextStyle(fontSize: 16,color: Colors.white)),
              //     //  widget.address!=null?
              //     //  Text(widget.address,style: TextStyle(fontSize: 12,color: Colors.white),):Text(''),
              //     // SizedBox(
              //     //   height: 8.0,
              //     // ),
              //   ],
              // )
          ),
          SizedBox(height: 10,),
          Container(
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
            color: Color(0xffF4F7F5),
            child: ContactUI(),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
  Widget ContactUI(){
    Size size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        widget.date==null?Container():Text('Joining Date : ${widget.date}',maxLines: 1,style: TextStyle(fontSize: size.width*.038,color: Colors.grey[600]),),
        widget.age==null?Container():Text('Age : ${widget.age}',maxLines: 1,style: TextStyle(fontSize: size.width*.038,color: Colors.grey[800]),),
        widget.gender==null?Container():Text('Gender : ${widget.gender}',maxLines: 1,style: TextStyle(fontSize: size.width*.038,color: Colors.grey[800]),),
        widget.bloodGroup==null?Container():Text('Blood Group : ${widget.bloodGroup}',style: TextStyle(fontSize: size.width*.038,color: Colors.grey[800]),),
        widget.address==null?Container():Text('Address : ${widget.address}',
           maxLines: 2,
           style: TextStyle(fontSize: size.width*.038,color: Colors.grey[800]),),
        widget.email==null?Container(): Text('Email : ${widget.email}',maxLines: 2,style: TextStyle(fontSize: size.width*.038,color: Colors.grey[900]),),
      ],
    );
  }
}
