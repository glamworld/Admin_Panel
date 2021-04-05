import 'package:admin_panel/providers/medicine_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'pages/Home.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'providers/article_provider.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/providers/forum-provider.dart';
import 'package:admin_panel/providers/appointment_provider.dart';
import 'package:admin_panel/providers/review_provider.dart';
import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:admin_panel/providers/doctor_provider.dart';
import 'package:admin_panel/providers/patient_provider.dart';
import 'package:admin_panel/providers/representative_provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<int, Color> color = {///RGB Color Code (0, 194, 162)
    50:Color.fromRGBO(0, 197, 164, .1),
    100:Color.fromRGBO(0, 197, 164, .2),
    200:Color.fromRGBO(0, 197, 164, .3),
    300:Color.fromRGBO(0, 197, 164, .4),
    400:Color.fromRGBO(0, 197, 164, .5),
    500:Color.fromRGBO(0, 197, 164, .6),
    600:Color.fromRGBO(0, 197, 164, .7),
    700:Color.fromRGBO(0, 197, 164, .8),
    800:Color.fromRGBO(0, 197, 164, .9),
    900:Color.fromRGBO(0, 197, 164, 1),
  };
  String Aid;
  String pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkPreferences();
  }

  void _checkPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      Aid = preferences.get('Aid');
    });
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider(),),
        ChangeNotifierProvider(create: (context) => FirebaseOperationProvider(),),
        ChangeNotifierProvider(create: (context) => MedicineProvider(),),
        ChangeNotifierProvider(create: (context) => ArticleProvider(),),
        ChangeNotifierProvider(create: (context) => AppointmentProvider(),),
        ChangeNotifierProvider(create: (context) => ReviewProvider(),),
        ChangeNotifierProvider(create: (context) => ForumProvider(),),
        ChangeNotifierProvider(create: (context) => DiscountShopProvider(),),
        ChangeNotifierProvider(create: (context) => DoctorProvider(),),
        ChangeNotifierProvider(create: (context) => PatientProvider(),),
        ChangeNotifierProvider(create: (context) => RepresentativeProvider(),),
      ],
      child: MaterialApp(
        supportedLocales: [
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate,
        ],
        title: 'DakterBari',
        theme: ThemeData(
            primarySwatch: MaterialColor(0xff00C5A4, color),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: Colors.transparent,
            cursorColor: Colors.black,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              elevation: 50,
              showUnselectedLabels: true,
              unselectedIconTheme: IconThemeData(
                  color: Colors.grey[700]
              ),
            )
        ),
        debugShowCheckedModeBanner: false,
        home: Aid == null? LogIn() : HomePage(),
      ),
    );
  }
}

