import 'dart:async';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import '../notification_widget.dart';
import 'Home.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _otpController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  void _checkConnectivity() async {
    var result = await (Connectivity().checkConnectivity());
    if (result == ConnectivityResult.none) {
      setState(() => _isConnected = false);
      showSnackBar(_scaffoldKey, "No internet connection !");
    } else if (result == ConnectivityResult.mobile) {
      setState(() => _isConnected = true);
    } else if (result == ConnectivityResult.wifi) {
      setState(() => _isConnected = true);
    }
  }

  void _initializeDoctorData(AuthProvider regAuth) async {
    regAuth.adminDetails.phone = '';
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider regAuth = Provider.of<AuthProvider>(context);
    final FirebaseOperationProvider operation =
        Provider.of<FirebaseOperationProvider>(context);
    if (regAuth.adminDetails.phone == null) _initializeDoctorData(regAuth);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffF4F7F5),
      //resizeToAvoidBottomInset: false,
      body: _isConnected ? _bodyUI(regAuth, operation) : _noInternetUI(),
    );
  }

  Widget _bodyUI(AuthProvider regAuth, FirebaseOperationProvider operation) {
    final Size size = MediaQuery.of(context).size;
    final Color colorPrimaryAccent = Color(0xffBCEDF2);
    return Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
            child: Column(children: [
          //Heading Section
          Container(
            height: size.height * .40,
            width: size.width,
            color: colorPrimaryAccent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ///Logo Icon...
                Positioned(
                    top: size.height * .09,
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.asset(
                          "assets/logo.png",
                          height: 50,
                          //width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
                SizedBox(height: 5),
                Text(
                  "Admin",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff00C5A4)),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),

          //Phone number field
              Container(
                width:size.width*.90,
                child: Material(
                  color: Colors.white,
                  elevation: 2,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                          width:size.width*.35,
                          child: _countryCodePicker(regAuth)
                      ),
                      Container(
                        width:size.width*.54,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          onChanged: (val)=> setState(()=>regAuth.adminDetails.phone = val),
                          decoration:
                          FormDecoration.copyWith(
                            labelText: 'Phone number',
                            prefixIcon: null,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

                  SizedBox(height: 20),

                  //Continue Button...
                  Consumer<FirebaseOperationProvider>(
                    builder: (context, operation, child) {
                      return Container(
                        width: size.width * .90,
                        child: GestureDetector(
                          onTap: () => _checkValidity(regAuth, operation),
                          child: Button(context, "Continue"),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
  }

  Widget _noInternetUI() {
    return Container(
      color: Colors.white70,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/logo.png",
            height: 50,
            //width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 40),
          Icon(
            CupertinoIcons.wifi_exclamationmark,
            color: Colors.orange[300],
            size: 150,
          ),
          Text(
            'No Internet Connection !',
            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          ),
          Text(
            'Connect your device with wifi or cellular data',
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
          SizedBox(height: 20),
          Text(
            "For emergency call 16263",
            style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () => _checkConnectivity(),
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
                width: MediaQuery.of(context).size.width * .25,
                child: miniOutlineIconButton(
                    context, 'Refresh', Icons.refresh, Colors.grey)),
          )
        ],
      ),
    );
  }

  Widget _countryCodePicker(AuthProvider regAuth) {
    return CountryCodePicker(
      comparator: (a, b) => b.name.compareTo(a.name),
      onChanged: (val) {
        regAuth.adminDetails.countryCode = val.dialCode;
        //print(countryCode);
      },
      onInit: (code) {
        regAuth.adminDetails.countryCode = code.dialCode;
        //print(countryCode);
      },
      favorite: ['+880', 'BD'],
      initialSelection: 'BD',
      showCountryOnly: false,
      showFlag: true,
      showOnlyCountryWhenClosed: false,
      showDropDownButton: true,
      padding: EdgeInsets.only(left: 10),
    );
  }

  void _checkValidity(AuthProvider regAuth, FirebaseOperationProvider operation) async {
    regAuth.loadingMgs = "Logging in...";
    showLoadingDialog(context, regAuth);

    //Firebase querySnapshot
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Admin').where('phone', isEqualTo:  regAuth.adminDetails.countryCode+regAuth.adminDetails.phone).get();
    final List<QueryDocumentSnapshot> user = snapshot.docs;
    if (user.isNotEmpty) {
      _OTPVerification(regAuth, operation);
    } else {
      Navigator.pop(context);
      showSnackBar(_scaffoldKey, "Field empty or phone number is not correct");
    }
  }

  // ignore: non_constant_identifier_names
  void _OTPDialog(AuthProvider regAuth) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(20),
            title: Text("Phone Verification", textAlign: TextAlign.center),
            content: Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      "We've sent OTP verification code on your given number.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: FormDecoration.copyWith(
                        labelText: "Enter OTP here",
                        fillColor: Color(0xffF4F7F5),
                        prefixIcon: Icon(Icons.security)),
                  ),
                  SizedBox(height: 10),
                  Consumer<FirebaseOperationProvider>(
                    builder: (context, operation, child) {
                      return GestureDetector(
                        onTap: () async {
                          regAuth.loadingMgs = 'Verifying OTP...';
                          showLoadingDialog(context, regAuth);
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId:
                                            regAuth.verificationCode,
                                        smsCode: _otpController.text))
                                .then((value) async {
                              if (value.user != null) {
                                //Save data to local
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setString('Aid', regAuth.adminDetails.phone);

                                await operation.getAdmin().then((value) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  regAuth.adminDetails = null;
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false);
                                });
                              } else {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                showSnackBar(_scaffoldKey,
                                    'Something went wrong. try again');
                              }
                            });
                          } catch (e) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            showSnackBar(_scaffoldKey, 'Invalid OTP');
                          }
                        },
                        child: Button(context, 'Submit'),
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Text('OTP will expired after 2 minutes',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]))
                ],
              ),
            ),
          );
        });
  }

  // ignore: non_constant_identifier_names
  Future<void> _OTPVerification(AuthProvider regAuth, FirebaseOperationProvider operation) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: regAuth.adminDetails.countryCode+regAuth.adminDetails.phone,
      //Automatic verify....
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            //Save data to local
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('Aid', regAuth.adminDetails.phone);

            await operation.getAdmin().then((value) async {
              Navigator.pop(context);
              regAuth.adminDetails = null;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            });
          } else {
            Navigator.pop(context);
            showSnackBar(_scaffoldKey, 'Error verifying Admin');
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Navigator.pop(context);
          showSnackBar(_scaffoldKey, 'The provided phone number is not valid');
        }
      },
      codeSent: (String verificationId, int resendToken) {
        regAuth.verificationCode = verificationId;
        Navigator.pop(context);
        _OTPDialog(regAuth);
        //_startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        regAuth.verificationCode = verificationId;
        Navigator.pop(context);
        _OTPDialog(regAuth);
        //_startTimer();
      },
      timeout: Duration(seconds: 120),
    );
  }
}
