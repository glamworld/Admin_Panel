import 'package:admin_panel/pages/amount_page.dart';
import 'package:admin_panel/pages/login_page.dart';
import 'package:admin_panel/pages/patient_list.dart';
import 'package:admin_panel/pages/problem_page.dart';
import 'package:admin_panel/providers/article_provider.dart';
import 'package:admin_panel/pages/sent_notifications.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/providers/patient_provider.dart';
import 'package:admin_panel/providers/medicine_provider.dart';
import 'package:admin_panel/providers/representative_provider.dart';
import 'package:admin_panel/utils/button_widgets.dart';
import 'package:admin_panel/utils/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notification_widget.dart';
import 'blog_tab.dart';
import 'package:admin_panel/providers/forum-provider.dart';
import 'discount_shop_category.dart';
import 'forum_all_question.dart';
import 'manufacturer_representitive_list.dart';
import 'medical_category.dart';
import 'medicine_tab.dart';
import 'package:admin_panel/pages/payment.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isConnected = true;

  @override
  void initState() {
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Color(0xffF4F7F5),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          // leading: IconButton(
          //     onPressed: ()=>Navigator.of(context).pop(),
          //     icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.grey[800],),
          //   ),
          title: Text('Dakterbari | ডাক্তারবাড়ি\n              Admin',style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          backgroundColor: Colors.transparent,
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
                  )
              ),
            ),
          ),
        ),
      ),

      //customAppBarDesign(context, 'Dakterbari | ডাক্তারবাড়ি\n              Admin'),
      body: _isConnected ? _bodyUI(size) : _noInternetUI(),
    );
  }
  void handleClick(String value) async{
    final FirebaseOperationProvider operation = Provider.of<FirebaseOperationProvider>(context,listen: false);
    final AuthProvider regAuth = Provider.of<AuthProvider>(context,listen: false);
    if(value=='Logout') {
      operation.loadingMgs = 'Logging out...';
      showLoadingDialog(context, operation);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('Aid', null).then((value) {
        regAuth.adminDetails = null;
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LogIn()),
                (Route<dynamic> route) => false);
        //await FirebaseAuth.instance.signOut().then((value) {});
      });
    }
    //break;

    //}
  }
  Widget _bodyUI(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: size.width,
              //height: size.height * .80,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3,
                    //childAspectRatio: .95
                  ),
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return GridBuilderTile(size, index);
                  }),
            ),
          ),
        ],
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

}

class GridBuilderTile extends StatelessWidget {
  int index;
  Size size;

  GridBuilderTile(this.size, this.index);

  @override
  Widget build(BuildContext context) {
    FirebaseOperationProvider operation =
        Provider.of<FirebaseOperationProvider>(context);
    RepresentativeProvider rpProvider =
    Provider.of<RepresentativeProvider>(context);
    PatientProvider ptProvider =
    Provider.of<PatientProvider>(context);
    MedicineProvider medicineProvider = Provider.of<MedicineProvider>(context);
    final ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);
    ForumProvider forumProvider = Provider.of<ForumProvider>(context);
    return InkWell(
      onTap: () async {
        if (index == 1) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await ptProvider.getPatients().then((value) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => PatientList()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
        }
        if (index == 2) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await medicineProvider.getMedicine().then((value)async {
            await medicineProvider.getPendingMedicine().then((value) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineTab()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
          });
        }
        if (index == 3) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await forumProvider.getAllQuestionList().then((value) {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AllQuestions()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
        }
        if (index == 4) {
          if(articleProvider.allArticleList.isEmpty){
            articleProvider.loadingMgs='Please wait...';
            showLoadingDialog(context, articleProvider);
            await articleProvider.getPendingArticle().then((value)async{
                                await articleProvider.getAllArticle().then((value)async{
                                  await articleProvider.getPopularArticle().then((value)async{
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlogTab()));
                                    });
                                  });
                                });
          }else Navigator.push(context, MaterialPageRoute(builder: (context) => BlogTab()));

        }
        if (index == 5) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await rpProvider.getRepresentative().then((value){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ManufacturerRepresentative()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
        }
        if (index == 6) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DiscountShopCategory()));
        }
        if (index == 7) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await operation.getNotifications().then((value){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SentNotifications()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
        }
        if (index == 8) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await operation.getDoctorsProblems().then((value)async {
            await operation.getPatientsProblems().then((value) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProblemPage()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
          });
        }
        if (index == 9) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await operation.getAmount().then((value) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => AmountPage()));
          },onError: (error){
            Navigator.pop(context);
            showAlertDialog(context, error.toString());
          });
        }
        if (index == 10) {
          operation.loadingMgs='Please wait...';
          showLoadingDialog(context,operation);
          await operation.getDiscountPayment().then((value)async {
            await operation.getAppointmentPayment().then((value) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Payments()));
            }, onError: (error) {
              Navigator.pop(context);
              showAlertDialog(context, error.toString());
            });
          });
        }
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MedicalDepartment()));

        }
      },
      splashColor: Theme.of(context).primaryColor,
      child: Container(
          //color: Color(0xffF4F7F5),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              height: size.width*.17,
              width: size.width*.17,
              decoration: BoxDecoration(
                color: Color(0xffF4F7F5),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: index == 1
                      ? AssetImage('assets/home_icon/patient.png')
                      : index == 2
                          ? AssetImage('assets/home_icon/medicine.png')
                          : index == 3
                              ? AssetImage('assets/home_icon/forum.png')
                              : index == 4
                                  ? AssetImage('assets/home_icon/blog.png')
                                  : index == 5
                                      ? AssetImage(
                                          'assets/home_icon/manufacturer_representative.png')
                                      : index == 6
                                          ? AssetImage(
                                              'assets/home_icon/shop.png')
                                          : index == 7
                                              ? AssetImage(
                                                  'assets/home_icon/notifications.png')
                                              : index == 8
                                                  ? AssetImage(
                                                      'assets/home_icon/problem.png')
                                                  : index == 9
                                                    ? AssetImage(
                                                        'assets/home_icon/amount.png')
                                                       : index == 10
                                                         ? AssetImage(
                                                           'assets/home_icon/mobile_payment.png')
                                                       : AssetImage(
                                                        'assets/home_icon/doctor.png'),
                ),
              ),
              height: size.width*.09,
              width: size.width*.09,
            ),
          ]),
          SizedBox(height: 5),
          Text(
            index == 1
                ? 'Patients'
                : index == 2
                    ? 'Medicines'
                    : index == 3
                        ? 'Forum Activity'
                        : index == 4
                            ? 'Blogs'
                            : index == 5
                                ? 'Manufacturer Representative'
                                : index == 6
                                    ? 'Discount Shop'
                                    : index == 7
                                        ? 'Send Notification'
                                        : index == 8
                                            ? 'Problems'
                                           : index == 9
                                              ? 'Amount'
                                             : index == 10
                                            ? 'Payments'
                                            : 'Doctors',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor, //Color(0xff00C5A4),
                fontSize: size.width*.04,
                fontWeight: FontWeight.bold),
          )
        ],
      )),
    );
  }
}
