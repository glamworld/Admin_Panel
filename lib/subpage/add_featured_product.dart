import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:admin_panel/subpage/discount_shop_detailes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../notification_widget.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:admin_panel/providers/auth_provider.dart';

class FeaturedProduct extends StatefulWidget {

  String id;

  FeaturedProduct({this.id});

  @override
  _FeaturedProductState createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _initializeFeaturedData(DiscountShopProvider auth) {
    auth.featuredProductModel.imageUrl = '';
    auth.featuredProductModel.productName = '';
    auth.featuredProductModel.productPrice = '';
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

    return Consumer <DiscountShopProvider>(builder: (context, auth, child) {
      if (auth.featuredProductModel.imageUrl == null ||
          auth.featuredProductModel.productName == null ||
          auth.featuredProductModel.productPrice == null) {
        _initializeFeaturedData(auth);
      }

      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: customAppBarDesign(context, "Add New Featured Product"),
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [

                ///Featured Product Form...
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                      children: [

                        ///Featured Product Picture

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
                                    height: 200,width: 200,
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
                                    iconSize: 150.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                child: Text(
                                  "Select Featured Product Picture",
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

                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: FormDecorationWithoutPrefix.copyWith(
                              hintText: "Featured Product Name",
                              fillColor: Color(0xffF4F7F5)),
                          onChanged: (val) {
                            setState(() {
                              auth.featuredProductModel.productName = val;
                            });
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: FormDecorationWithoutPrefix.copyWith(
                                hintText: "Featured Product Price",
                                fillColor: Color(0xffF4F7F5)),
                            onChanged: (val){
                              setState(() {
                                auth.featuredProductModel.productPrice = val;
                              });
                            },
                        ),
                        SizedBox(height: 10),

                        ///Submit Button...
                        GestureDetector(
                          onTap: () {
                            _checkValidity(auth,widget.id,context);
                          },
                          child: Button(context, "Submit"),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> _checkValidity(DiscountShopProvider auth,String id,BuildContext context) async {
    try {
      if (auth.featuredProductModel.imageUrl!=null &&
          auth.featuredProductModel.productName.isNotEmpty &&
          auth.featuredProductModel.productPrice.isNotEmpty)
      {
        auth.loadingMgs = 'Please wait...';
        showLoadingDialog(context, auth);
        bool result = await auth.addFeaturedProduct(auth,auth.featuredProductModel,id, _scaffoldKey, context, _image);
        if (result) {
          // Navigator.pop(context);
           //Navigator.pop(context);
          auth.featuredProductModel = null;
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(_scaffoldKey, 'Error adding product. Try again');
        }
      } else
        showSnackBar(_scaffoldKey, 'Complete all the required fields');
    } catch (error) {
      Navigator.pop(context);
      showSnackBar(_scaffoldKey, error.toString());
    }
  }
}
