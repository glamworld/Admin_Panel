import 'dart:io';
import 'package:admin_panel/model/aminities_model.dart';
import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:admin_panel/utils/static_variable_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notification_widget.dart';

class AddDiscountShop extends StatefulWidget {
  @override
  _AddDiscountShopState createState() => _AddDiscountShopState();
}

class _AddDiscountShopState extends State<AddDiscountShop> {
  final _addKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<AmenitiesModel> amenitiesList = List();
  List<String> shopAmenities = List();
  int address = 1;
  int amenities = 2;
  String selectedShopCategory;
  String selectedSubCategory;
  String selectedCurrency;
  File _image;

  void _initializeShopData(DiscountShopProvider auth) {
    auth.shopModel.shopImage = '';
    auth.shopModel.shopName = '';
    auth.shopModel.about = '';
    auth.shopModel.executiveName = '';
    auth.shopModel.executivePhoneNo = '';
    auth.shopModel.webAddress = '';
    auth.shopModel.mailAddress = '';
    auth.shopModel.twitterLink = '';
    auth.shopModel.facebookLink = '';
    auth.shopModel.phoneNo = '';
    auth.shopModel.linkedinLink = '';
    auth.shopModel.shopAddress = '';
    auth.shopModel.latitude = '';
    auth.shopModel.longitude = '';
  }

  void _initializeDayTimeData(DiscountShopProvider auth) {
    auth.shopModel.sat = [false, TimeOfDay.now(), TimeOfDay.now()];
    auth.shopModel.sun = [false, TimeOfDay.now(), TimeOfDay.now()];
    auth.shopModel.mon = [false, TimeOfDay.now(), TimeOfDay.now()];
    auth.shopModel.tue = [false, TimeOfDay.now(), TimeOfDay.now()];
    auth.shopModel.wed = [false, TimeOfDay.now(), TimeOfDay.now()];
    auth.shopModel.thu = [false, TimeOfDay.now(), TimeOfDay.now()];
    auth.shopModel.fri = [false, TimeOfDay.now(), TimeOfDay.now()];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    Future<void> _getImageFromGallery(AuthProvider auth) async {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    return Consumer<DiscountShopProvider>(builder: (context, auth, child) {
      if (auth.shopModel.shopImage == null ||
          auth.shopModel.shopName == null ||
          auth.shopModel.phoneNo == null) {
        _initializeShopData(auth);
        _initializeDayTimeData(auth);
      }

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: customAppBarDesign(context, "Add New Shop"),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [

                ///Shop Form...
                Container(
                  width: size.width*.99,
                  margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                    children: [

                      ///Shop Profile Picture

                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffF4F7F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _getImageFromGallery(auth);
                              },
                              child: Container(
                                width: size.width,
                                child: _image != null
                                    ? Image.file(
                                  _image,
                                  height: 200,width: 300,
                                )
                                    : IconButton(
                                  onPressed: () {
                                    _getImageFromGallery(auth);
                                  },
                                  splashColor: Color(0xff00C5A4),
                                  icon: Icon(
                                    Icons.image,
                                    color: Color(0xff00C5A4),
                                  ),
                                  iconSize: 160.0,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              child: Text(
                                "Select Shop Profile Picture",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff00C5A4),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),

                      ///Shop Name...
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Shop Name",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.shopName = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "About..", fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.about = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Executive name..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.executiveName = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Executive phone no..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.executivePhoneNo = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),

                      ///Shop Category From...
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xffF4F7F5),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        width: size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedShopCategory,
                            hint: Text("Select Shop Category",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16)),
                            items: StaticVariables.shopCategoryList
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList(),
                            onChanged: (newValue) {
                                setState(() {
                                  selectedSubCategory=null;
                                  auth.shopModel.subCategory=null;
                                  selectedShopCategory = newValue;
                                  auth.shopModel.shopCategory = newValue;
                                });},
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      ///subCategory
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xffF4F7F5),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        width: size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedSubCategory,
                            hint: Text("Select Shop SubCategory",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16)),
                            items: selectedShopCategory!=null?selectedShopCategory=='Lab'||selectedShopCategory=='Hospital'
                            ||selectedShopCategory=='Pharmacy'?
                            StaticVariables.hlpSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():
                            selectedShopCategory=='Travel & Tour'?
                            StaticVariables.tourSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Hotel & Restaurant'?
                            StaticVariables.hotelSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Education & Training'?
                            StaticVariables.educationSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Entertainment'?
                            StaticVariables.entertainSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Wedding & Parlor'?
                            StaticVariables.weddingSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Family Needs'?
                            StaticVariables.familySubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Demand Service'?
                            StaticVariables.demandSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Equipment & Tools'?
                            StaticVariables.equipmentSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Hire & Rent'?
                            StaticVariables.hireSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Automobile'?
                            StaticVariables.autoMobileSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Real State'?
                            StaticVariables.realStateSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():selectedShopCategory=='Miscellaneous'?
                            StaticVariables.miscellaneousSubCategory
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList():null:null,
                            onChanged: (newValue) {
                                setState(() {
                                  selectedSubCategory=newValue;
                                  auth.shopModel.subCategory = newValue;
                                });},
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      ///Website...
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Web address..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.webAddress = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Mail address..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.mailAddress = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Twitter link..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.twitterLink = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Phone no..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.phoneNo = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),

                      ///Facebook...
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "facebook link..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.facebookLink = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),

                      ///Linked In...
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "linkedin link..",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.linkedinLink = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Upto discount in percentage",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.discount = val;
                          });
                        },
                      ),
                      SizedBox(height: 15),

                      ///Amenities...
                      Container(
                        height: 50,
                        width: size.width,
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                enabled: false,
                                decoration:
                                FormDecorationWithoutPrefix.copyWith(
                                    fillColor: Color(0xffF4F7F5),
                                    hintText: "Shop Amenities"),
                              ),
                            ),
                            IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  _showDialog(auth);
                                })
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      _addedAmenities(auth),

                      ///Opening Hour...
                      Text(
                        "Schedule",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      Divider(color: Theme
                          .of(context)
                          .primaryColor),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _schedule('Sat', auth),
                            _schedule('Sun', auth),
                            _schedule('Mon', auth),
                            _schedule('Tue', auth),
                            _schedule('Wed', auth),
                            _schedule('Thur', auth),
                            _schedule('Fri', auth),
                          ]
                      ),

                      SizedBox(height: 15),

                      ///Address...
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 2,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            fillColor: Color(0xffF4F7F5),
                            hintText: "Shop Address"),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.shopAddress = val;
                          });
                        },
                      ),

                      SizedBox(height: 15),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                            color: Color(0xffF4F7F5),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        width: size.width,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: selectedCurrency,
                            hint: Text("Select Currency",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16)),
                            items: StaticVariables.currency
                                .map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*.75,
                                  child: Text(category,
                                      style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 16,
                                      )),
                                ),
                                value: category,
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedCurrency = newValue;
                                auth.shopModel.currency = newValue;
                              });},
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      ///Location...
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Latitude : 2.17403",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.latitude = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: FormDecorationWithoutPrefix.copyWith(
                            hintText: "Longitude : 41.40338",
                            fillColor: Color(0xffF4F7F5)),
                        onChanged: (val) {
                          setState(() {
                            auth.shopModel.longitude = val;
                          });
                        },
                      ),
                      SizedBox(height: 10),

                      ///Submit Button...
                      GestureDetector(
                        onTap: () {
                          _checkValidity(auth);
                        },
                        child: Button(context, "Submit  Discount Shop"),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _checkValidity(DiscountShopProvider auth) async {
    try {
      if (auth.shopModel.shopImage != null &&
          auth.shopModel.shopName != null &&
          auth.shopModel.about != null &&
          auth.shopModel.executiveName != null &&
          auth.shopModel.executivePhoneNo.isNotEmpty &&
          auth.shopModel.shopCategory != null &&
          auth.shopModel.webAddress != null &&
          auth.shopModel.mailAddress != null &&
          auth.shopModel.twitterLink != null &&
          auth.shopModel.facebookLink != null &&
          auth.shopModel.phoneNo.isNotEmpty &&
          auth.shopModel.linkedinLink != null &&
          auth.shopModel.discount != null &&
          auth.shopModel.amenities != null &&
          auth.shopModel.shopAddress != null &&
          auth.shopModel.currency != null &&
          auth.shopModel.latitude.isNotEmpty &&
          auth.shopModel.longitude.isNotEmpty) {
        auth.loadingMgs = 'Please wait...';
        showLoadingDialog(context, auth);
        await auth.addDiscountShop(auth.shopModel, _scaffoldKey, context, _image).then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
          auth.shopModel = null;
        },onError: (){
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(_scaffoldKey, 'Error adding shop. Try again');
        });
      } else
        showSnackBar(_scaffoldKey, 'Complete all the required fields');
    } catch (error) {
      //showSnackBar(_scaffoldKey, error.toString());
    }
  }

  Widget _schedule(String day, DiscountShopProvider auth) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      width: size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Day Check Button
          Row(
            children: [
              Checkbox(
                value: day == 'Sat'
                    ? auth.shopModel.sat[0]
                    : day == 'Sun'
                    ? auth.shopModel.sun[0]
                    : day == 'Mon'
                    ? auth.shopModel.mon[0]
                    : day == 'Tue'
                    ? auth.shopModel.tue[0]
                    : day == 'Wed'
                    ? auth.shopModel.wed[0]
                    : day == 'Thur'
                    ? auth.shopModel.thu[0]
                    : auth.shopModel.fri[0],
                onChanged: (bool checkedValue) {
                  setState(() =>
                  day == 'Sat'
                      ? auth.shopModel.sat[0] = checkedValue
                      : day == 'Sun'
                      ? auth.shopModel.sun[0] = checkedValue
                      : day == 'Mon'
                      ? auth.shopModel.mon[0] = checkedValue
                      : day == 'Tue'
                      ? auth.shopModel.tue[0] = checkedValue
                      : day == 'Wed'
                      ? auth.shopModel.wed[0] = checkedValue
                      : day == 'Thur'
                      ? auth.shopModel.thu[0] = checkedValue
                      : auth.shopModel.fri[0] =
                      checkedValue);
                },
              ),
              Text(
                day,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800]),
              )
            ],
          ),
          //Time Button
          Row(
            children: [
              FlatButton(
                onPressed: () {
                  _selectTime(context, 'from', day, auth);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(0xffF4F7F5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      Text(
                        day == "Sat"
                            ? '${auth.shopModel.sat[1].hour}:${auth.shopModel
                            .sat[1].minute}'
                            : day == "Sun"
                            ? '${auth.shopModel.sun[1].hour}:${auth.shopModel
                            .sun[1].minute}'
                            : day == "Mon"
                            ? '${auth.shopModel.mon[1].hour}:${auth.shopModel
                            .mon[1].minute}'
                            : day == "Tue"
                            ? '${auth.shopModel.tue[1].hour}:${auth.shopModel
                            .tue[1].minute}'
                            : day == "Wed"
                            ? '${auth.shopModel.wed[1].hour}:${auth.shopModel
                            .wed[1].minute}'
                            : day == "Thur"
                            ? '${auth.shopModel.thu[1].hour}:${auth.shopModel
                            .thu[1].minute}'
                            : '${auth.shopModel.fri[1].hour}:${auth.shopModel
                            .fri[1].minute}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down_outlined,
                          color: Theme
                              .of(context)
                              .primaryColor)
                    ],
                  ),
                ),
              ),
              Text(
                "to",
                style: TextStyle(fontSize: 12),
              ),
              FlatButton(
                onPressed: () {
                  _selectTime(context, 'to', day, auth);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 30,
                  decoration: BoxDecoration(
                      color: Color(0xffF4F7F5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      Text(
                        day == "Sat"
                            ? '${auth.shopModel.sat[2].hour}:${auth.shopModel
                            .sat[2].minute}'
                            : day == "Sun"
                            ? '${auth.shopModel.sun[2].hour}:${auth.shopModel
                            .sun[2].minute}'
                            : day == "Mon"
                            ? '${auth.shopModel.mon[2].hour}:${auth.shopModel
                            .mon[2].minute}'
                            : day == "Tue"
                            ? '${auth.shopModel.tue[2].hour}:${auth.shopModel
                            .tue[2].minute}'
                            : day == "Wed"
                            ? '${auth.shopModel.wed[2].hour}:${auth.shopModel
                            .wed[2].minute}'
                            : day == "Thur"
                            ? '${auth.shopModel.thu[2].hour}:${auth.shopModel
                            .thu[2].minute}'
                            : '${auth.shopModel.fri[2].hour}:${auth.shopModel
                            .fri[2].minute}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down_outlined,
                          color: Theme
                              .of(context)
                              .primaryColor)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context, String identifier, String day,
      DiscountShopProvider auth) async {
    if (identifier == "from") {
      switch (day) {
        case 'Sat':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.sat[1],
          );
          if (picked != null && picked != auth.shopModel.sat[1]) {
            setState(() => auth.shopModel.sat[1] = picked);
          }
          break;
        case 'Sun':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.sun[1],
          );
          if (picked != null && picked != auth.shopModel.sun[1]) {
            setState(() => auth.shopModel.sun[1] = picked);
          }
          break;
        case 'Mon':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.mon[1],
          );
          if (picked != null && picked != auth.shopModel.mon[1]) {
            setState(() => auth.shopModel.mon[1] = picked);
          }
          break;
        case 'Tue':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.tue[1],
          );
          if (picked != null && picked != auth.shopModel.tue[1]) {
            setState(() => auth.shopModel.tue[1] = picked);
          }
          break;
        case 'Wed':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.wed[1],
          );
          if (picked != null && picked != auth.shopModel.wed[1]) {
            setState(() => auth.shopModel.wed[1] = picked);
          }
          break;
        case 'Thur':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.thu[1],
          );
          if (picked != null && picked != auth.shopModel.thu[1]) {
            setState(() => auth.shopModel.thu[1] = picked);
          }
          break;
        default:
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.fri[1],
          );
          if (picked != null && picked != auth.shopModel.fri[1]) {
            setState(() => auth.shopModel.fri[1] = picked);
          }
          break;
      }
    } else {
      switch (day) {
        case 'Sat':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.sat[2],
          );
          if (picked != null && picked != auth.shopModel.sat[2]) {
            setState(() => auth.shopModel.sat[2] = picked);
          }
          break;
        case 'Sun':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.sun[2],
          );
          if (picked != null && picked != auth.shopModel.sun[2]) {
            setState(() => auth.shopModel.sun[2] = picked);
          }
          break;
        case 'Mon':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.mon[2],
          );
          if (picked != null && picked != auth.shopModel.mon[2]) {
            setState(() => auth.shopModel.mon[2] = picked);
          }
          break;
        case 'Tue':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.tue[2],
          );
          if (picked != null && picked != auth.shopModel.tue[2]) {
            setState(() => auth.shopModel.tue[2] = picked);
          }
          break;
        case 'Wed':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.wed[2],
          );
          if (picked != null && picked != auth.shopModel.wed[2]) {
            setState(() => auth.shopModel.wed[2] = picked);
          }
          break;
        case 'Thur':
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.thu[2],
          );
          if (picked != null && picked != auth.shopModel.thu[2]) {
            setState(() => auth.shopModel.thu[2] = picked);
          }
          break;
        default:
          final TimeOfDay picked = await showTimePicker(
            context: context,
            initialTime: auth.shopModel.fri[2],
          );
          if (picked != null && picked != auth.shopModel.fri[2]) {
            setState(() => auth.shopModel.fri[2] = picked);
          }
          break;
      }
    }
  }

  Widget _addedAmenities(DiscountShopProvider auth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          amenitiesList.length == 0
              ? Container()
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amenities: ",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      amenitiesList.clear();
                      auth.shopModel.amenities = null;
                    });
                  },
                  child: Text(
                    "Remove all",
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 80,
            child: ListView.builder(
              itemCount: amenitiesList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5, left: 2, right: 2),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, .8),
                            blurRadius: 1)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${amenitiesList[index].amenitiesName}",
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(DiscountShopProvider auth) {
    String name;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(20),
            title: Text(
              "Add Amenities",
              textAlign: TextAlign.center,
            ),
            content: Container(
              child: Form(
                key: _addKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(hintText: 'Write amenities'),
                      onSaved: (val) {
                        name = val;
                      },
                      validator: (val) =>
                      val.isEmpty ? 'please write amenities' : null,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          color: Colors.redAccent,
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        RaisedButton(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: () {
                            if (_addKey.currentState.validate()) {
                              _addKey.currentState.save();
                              AmenitiesModel ap = AmenitiesModel();
                              ap.amenitiesName = name;
                              setState(() {
                                amenitiesList.add(ap);
                                shopAmenities.add(name);
                                auth.shopModel.amenities = shopAmenities;
                              });
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }


}

