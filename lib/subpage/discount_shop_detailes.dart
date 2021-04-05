import 'package:admin_panel/model/aminities_model.dart';
import 'package:admin_panel/providers/auth_provider.dart';
import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:admin_panel/subpage/update_schedule.dart';
import 'package:admin_panel/utils/amenities_modal.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/featured_modal.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:pie_chart/pie_chart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_panel/subpage/add_featured_product.dart';
import '../notification_widget.dart';
import 'package:admin_panel/providers/review_provider.dart';
import 'package:admin_panel/utils/static_variable_page.dart';

class DiscountShopDetails extends StatefulWidget {
  String id;
  String subcategory;

  DiscountShopDetails({this.id,this.subcategory});

  @override
  _DiscountShopDetailsState createState() => _DiscountShopDetailsState();
}

class _DiscountShopDetailsState extends State<DiscountShopDetails> {
  static const Color starColor = Color(0xffFFBA00);
  int _counter = 0;
  File _image;
  String selectedCurrency;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> shopAmenities = List();
  final _addKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fbController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController longController = TextEditingController();

  void _initializeTextFormData(DiscountShopProvider operation) {
    setState(() => _counter++);
    nameController.text = operation.shopIdList[0].shopName ?? '';
    addressController.text = operation.shopIdList[0].shopAddress ?? '';
    aboutController.text = operation.shopIdList[0].about ?? '';
    emailController.text = operation.shopIdList[0].mailAddress ?? '';
    fbController.text = operation.shopIdList[0].facebookLink ?? '';
    webController.text = operation.shopIdList[0].webAddress ?? '';
    linkedinController.text = operation.shopIdList[0].linkedinLink ?? '';
    phoneController.text = operation.shopIdList[0].phoneNo ?? '';
    twitterController.text = operation.shopIdList[0].twitterLink ?? '';
    discountController.text = operation.shopIdList[0].discount ?? '';
    latController.text = operation.shopIdList[0].latitude ?? '';
    longController.text = operation.shopIdList[0].longitude ?? '';

    operation.shopModel.shopName = operation.shopIdList[0].shopName ?? '';
    operation.shopModel.shopAddress = operation.shopIdList[0].shopAddress ?? '';
    operation.shopModel.about = operation.shopIdList[0].about ?? '';
    operation.shopModel.mailAddress = operation.shopIdList[0].mailAddress ?? '';
    operation.shopModel.facebookLink =
        operation.shopIdList[0].facebookLink ?? '';
    operation.shopModel.webAddress = operation.shopIdList[0].webAddress ?? '';
    operation.shopModel.linkedinLink =
        operation.shopIdList[0].linkedinLink ?? '';
    operation.shopModel.phoneNo = operation.shopIdList[0].phoneNo ?? '';
    operation.shopModel.twitterLink = operation.shopIdList[0].twitterLink ?? '';
    operation.shopModel.discount = operation.shopIdList[0].discount ?? '';
    operation.shopModel.latitude = operation.shopIdList[0].latitude ?? '';
    operation.shopModel.longitude = operation.shopIdList[0].longitude ?? '';
    selectedCurrency = operation.shopIdList[0].currency;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ReviewProvider reviewProvider = Provider.of<ReviewProvider>(context);
    DiscountShopProvider operation =
        Provider.of<DiscountShopProvider>(context);
    if (_counter == 0) _initializeTextFormData(operation);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: customAppBarDesign(context, "About Shopping"),
      body: _bodyUI(reviewProvider),
    );
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget _bodyUI(ReviewProvider reviewProvider) {
    Size size = MediaQuery.of(context).size;
    DiscountShopProvider operation =
        Provider.of<DiscountShopProvider>(context);
    AuthProvider auth = Provider.of<AuthProvider>(context);
    // return FutureBuilder(
    //     future: operation.getShopId(widget.id),
    //     builder: (_, snapshot) {
          return ListView(
            children: [
              //DakterBari Image
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 210,
                  child: _image != null
                      ? Image.file(
                          _image,
                          height: 200,
                          width: 300,
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          imageUrl: operation.shopIdList[0].shopImage,
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.fill,
                        )),
              SizedBox(height: 8.0),
              InkWell(
                  onTap: () {
                    _getImageFromGallery();
                  },
                  child: outlineIconButton(context, Icons.camera,
                      'Change picture', Theme.of(context).primaryColor)),
              SizedBox(height: 8.0),

              //Header Section
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextForm('Write Shop name..', operation),
                      SizedBox(height: 10),
                      _buildTextForm('Write Shop address..', operation),
                      SizedBox(height: 10),
                      _buildTextForm('Write Latitude..', operation),
                      SizedBox(height: 10),
                      _buildTextForm('Write Longitude..', operation),
                      SizedBox(height: 10),
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
                            hint: Text("Change Currency",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16)),
                            items: StaticVariables.currency.map((category) {
                              return DropdownMenuItem(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .75,
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
                                operation.shopModel.currency = selectedCurrency;
                              });
                            },
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextForm('Write Discount..', operation),
                    ],
                  )),
              SizedBox(height: 18),

              //about
              _aboutBuilder('About', operation),
              SizedBox(height: 18),

              _contactBuilder(
                operation,
                'Contact',
              ),
              SizedBox(height: 18),
              InkWell(
                  onTap: () {
                    operation.loadingMgs = 'Updating information...';
                    showLoadingDialog(context, operation);
                    if (_image != null) {
                      operation.updateDiscountShop(
                          _scaffoldKey, widget.id, context, operation, _image,widget.subcategory);
                    } else {
                      operation.updateShopDetails(
                          _scaffoldKey, widget.id, context, operation,widget.subcategory);
                    }
                  },
                  child: outlineIconButton(context, Icons.update,
                      'Update information', Theme.of(context).primaryColor)),
              SizedBox(height: 18),
              _amenitiesBuilder(operation),
              SizedBox(height: 18),
              _openingHoursBuilder('Opening Schedule', operation),
              SizedBox(height: 18),

              _featureProductBuilder('Featured Products', widget.id, operation),
              SizedBox(height: 18),
              _ratingSection(reviewProvider),
              SizedBox(height: 18),

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Widget okButton = FlatButton(
                        child: Text("YES"),
                        onPressed: () {
                          operation.loadingMgs = 'Please wait...';
                          showLoadingDialog(context, operation);
                          operation.deleteShop(widget.id, context,widget.subcategory,operation);
                        },
                      );
                      Widget noButton = FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        title:
                            Text("Are you sure you want to delete this Shop?"),
                        content: Text("This shop will be deleted"),
                        actions: [noButton, okButton],
                      );
                      return alert;
                    },
                  );
                },
                child: Material(
                  elevation: 0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: size.width * .45,
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.red,
                    ),
                    child: Text(
                      'Delete Shop',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: size.width / 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        //});
  }

  Widget _headingBuilder(String heading) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: Color(0xffF4F7F5), borderRadius: BorderRadius.circular(5)),
      child: Text(
        heading,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }

  Widget _ratingSection(ReviewProvider reviewProvider) {
    Size size = MediaQuery.of(context).size;

    Map<String, double> dataMap = {
      "⭐": double.parse(reviewProvider.shopOneStar.toString()),
      "⭐⭐": double.parse(reviewProvider.shopTwoStar.toString()),
      "⭐⭐⭐": double.parse(reviewProvider.shopThreeStar.toString()),
      "⭐⭐⭐⭐": double.parse(reviewProvider.shopFourStar.toString()),
      "⭐⭐⭐⭐⭐": double.parse(reviewProvider.shopFiveStar.toString()),
    };
    final List<Color> colorList = [
      Color(0xffFF5C6B),
      Color(0xffDBB049),
      Color(0xff7A5AB5),
      Color(0xff00D099),
      Color(0xff0094D4),
    ];

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.topLeft,
      color: Colors.white,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Ratings Overview",
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Container(
            width: size.width,
            child: PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 2500),
              chartLegendSpacing: 35,
              chartRadius: MediaQuery.of(context).size.width * .4,
              colorList: colorList,
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 32,
              centerText: "Ratings",
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[900]),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total People Rated",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: size.width * .043,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: size.width * .08),
                        Text(
                          "Avg. Ratings: ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: size.width * .043,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              "${reviewProvider.avgShopRating}",
                              style: TextStyle(
                                  fontSize: size.width * .043,
                                  fontWeight: FontWeight.w500,
                                  color: starColor),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.star,
                              size: size.width * .043,
                              color: starColor,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.assignment_ind,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${reviewProvider.allShopReviewList.length}',
                          style: TextStyle(
                              fontSize: size.width * .05,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800]),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _aboutBuilder(String about, DiscountShopProvider operation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          _headingBuilder(about),
          SizedBox(height: 10),

          _buildTextForm('Write About..', operation),
          //operation.shopIdList[0].about,
        ],
      ),
    );
  }

  Widget _contactBuilder(
      DiscountShopProvider operation,
    String contact,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _headingBuilder(contact),
          SizedBox(height: 15),
          _buildTextForm('Email Address', operation),
          SizedBox(height: 10),
          _buildTextForm('Facebook address', operation),
          SizedBox(height: 10),
          _buildTextForm('Web address', operation),
          SizedBox(height: 10),
          _buildTextForm('Linkedin link', operation),
          SizedBox(height: 10),
          _buildTextForm('Phone number', operation),
          SizedBox(height: 10),
          _buildTextForm('Twitter link', operation),
        ],
      ),
    );
  }

  Widget _buildTextForm(String hint, DiscountShopProvider operation) {
    return TextFormField(
      maxLines: hint == 'Write About..' ? 4 : null,
      readOnly: hint == 'Phone number' ? true : false,
      controller: hint == 'Write Shop name..'
          ? nameController
          : hint == 'Write Shop address..'
              ? addressController
              : hint == 'Write About..'
                  ? aboutController
                  : hint == 'Email Address'
                      ? emailController
                      : hint == 'Facebook address'
                          ? fbController
                          : hint == 'Web address'
                              ? webController
                              : hint == 'Linkedin link'
                                  ? linkedinController
                                  : hint == 'Write Discount..'
                                      ? discountController
                                      : hint == 'Phone number'
                                          ? phoneController
                                          : hint == 'Write Latitude..'
                                              ? latController
                                              : hint == 'Write Longitude..'
                                                  ? longController
                                                  : twitterController,
      initialValue: null,
      decoration: FormDecoration.copyWith(
          alignLabelWithHint: true,
          labelText: hint,
          fillColor: Color(0xffF4F7F5)),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (hint == 'Write Shop name..')
          operation.shopModel.shopName = nameController.text;
        if (hint == 'Write Shop address..')
          operation.shopModel.shopAddress = addressController.text;
        if (hint == 'About') operation.shopModel.about = aboutController.text;
        if (hint == 'Email address')
          operation.shopModel.email = emailController.text;
        if (hint == 'Facebook address')
          operation.shopModel.facebookLink = fbController.text;
        if (hint == 'Web address')
          operation.shopModel.webAddress = webController.text;
        if (hint == 'Linkedin link')
          operation.shopModel.linkedinLink = linkedinController.text;
        if (hint == 'Write Discount..')
          operation.shopModel.discount = discountController.text;
        if (hint == 'Phone number')
          operation.shopModel.phoneNo = phoneController.text;
        if (hint == 'Write Latitude..')
          operation.shopModel.latitude = latController.text;
        if (hint == 'Write Longitude..')
          operation.shopModel.longitude = longController.text;
        if (hint == 'Twitter link')
          operation.shopModel.twitterLink = twitterController.text;
      },
    );
  }

  Widget _amenitiesBuilder(
      DiscountShopProvider operation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
                color: Color(0xffF4F7F5),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amenities:',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                GestureDetector(
                  onTap: () {
                    _showDialog(operation);
                  },
                  child: outlineIconButton(context, Icons.add, 'Add Amenities',
                      Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            itemCount: operation.shopIdList[0].amenities.length > 2
                ? 2
                : operation.shopIdList[0].amenities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(operation.shopIdList[0].amenities[index].toString()),
                      GestureDetector(
                          onTap: () {
                            operation.loadingMgs='Removing...';
                            showLoadingDialog(context, operation);
                            setState(() {
                              shopAmenities.clear();
                              operation.shopModel.amenities = null;
                              shopAmenities.add(operation
                                  .shopIdList[0].amenities[index]
                                  .toString());
                              operation.shopModel.amenities = shopAmenities;
                              operation.removeAmenities(widget.id,operation,context);
                              //auth.shopModel.amenities = null;
                            });
                          },
                          child: Text(
                            "Remove",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
          operation.shopIdList[0].amenities.length > 2
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () => ViewAllAmenities(context, operation, widget.id),
                    child: Text(
                      "View all amenities",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _openingHoursBuilder(
      String heading, DiscountShopProvider operation) {
    Size size = MediaQuery.of(context).size;
    final String sat = operation.shopIdList[0].sat == null
        ? ''
        : '  Saturday: ${operation.shopIdList[0].sat[0]}-${operation.shopIdList[0].sat[1]}';
    final String sun = operation.shopIdList[0].sun == null
        ? ''
        : '  Sunday: ${operation.shopIdList[0].sun[0]}-${operation.shopIdList[0].sun[1]}';
    final String mon = operation.shopIdList[0].mon == null
        ? ''
        : '  Monday: ${operation.shopIdList[0].mon[0]}-${operation.shopIdList[0].mon[1]}';
    final String tue = operation.shopIdList[0].tue == null
        ? ''
        : '  Tuesday: ${operation.shopIdList[0].tue[0]}-${operation.shopIdList[0].tue[1]}';
    final String wed = operation.shopIdList[0].wed == null
        ? ''
        : '  Wednesday: ${operation.shopIdList[0].wed[0]}-${operation.shopIdList[0].wed[1]}';
    final String thu = operation.shopIdList[0].thu == null
        ? ''
        : '  Thursday: ${operation.shopIdList[0].thu[0]}-${operation.shopIdList[0].thu[1]}';
    final String fri = operation.shopIdList[0].fri == null
        ? ''
        : '  Friday: ${operation.shopIdList[0].fri[0]}-${operation.shopIdList[0].fri[1]}';
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Color(0xffF4F7F5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _headingBuilder(heading),
          SizedBox(height: 15),
          Container(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(sat, style: TextStyle(fontSize: 18)),
                Text(sun, style: TextStyle(fontSize: 18)),
                Text(mon, style: TextStyle(fontSize: 18)),
                Text(tue, style: TextStyle(fontSize: 18)),
                Text(wed, style: TextStyle(fontSize: 18)),
                Text(thu, style: TextStyle(fontSize: 18)),
                Text(fri, style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateSchedule(id: widget.id))),
            child: outlineIconButton(context, Icons.update, 'Update Schedule',
                Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _featureProductBuilder(
      String heading, String id, DiscountShopProvider operation) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Color(0xffF4F7F5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0xffF4F7F5),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('Featured Products',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                SizedBox(height: 15),
                ListView.builder(
                  itemCount: operation.productList.length > 2
                      ? 2
                      : operation.productList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FeatureProductTile(
                      id: operation.productList[index].id,
                      shopId: operation.productList[index].shopId,
                      productName: operation.productList[index].productName,
                      productPrice: operation.productList[index].productPrice,
                      productImage: operation.productList[index].imageUrl,
                    );
                  },
                ),
                operation.productList.length > 2
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () => ViewFeaturedProducts(context),
                          child: Text(
                            "View all products",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeaturedProduct(id: id)));
                    },
                    child: outlineIconButton(
                        context,
                        Icons.add,
                        'Add Featured Products',
                        Theme.of(context).primaryColor))
              ],
            ),
          );
  }

  _showDialog(DiscountShopProvider operation) {
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
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            operation.loadingMgs='Updating amenities...';
                            showLoadingDialog(context, operation);
                            if (_addKey.currentState.validate()) {
                              _addKey.currentState.save();
                              AmenitiesModel ap = AmenitiesModel();
                              ap.amenitiesName = name;
                              setState(() {
                                shopAmenities.clear();
                                shopAmenities.add(name);
                                operation.shopModel.amenities = null;
                                operation.shopModel.amenities = shopAmenities;
                                operation.updateAmenities(operation, widget.id,context);
                              });
                              //Navigator.of(context).pop();
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

//ignore: must_be_immutable
class FeatureProductTile extends StatelessWidget {
  String id, shopId,productImage, productName, productPrice;

  FeatureProductTile(
      {this.id, this.productImage, this.productName, this.productPrice,this.shopId});

  @override
  Widget build(BuildContext context) {
    DiscountShopProvider operation =
        Provider.of<DiscountShopProvider>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
        leading: CachedNetworkImage(
          width: size.width * .20,
          imageUrl: productImage,
          placeholder: (context, url) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.fill,
        ),
        title: Text("ProductName: " + productName),
        subtitle: Text("ProductPrice: " + productPrice),
        trailing: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  Widget okButton = FlatButton(
                    child: Text("YES"),
                    onPressed: () {
                      operation.loadingMgs='Deleting...';
                      showLoadingDialog(context, operation);
                      operation.deleteFeaturedProduct(id,shopId, context,operation);
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
                    title:
                        Text("Are you sure you want to delete this Product?"),
                    content: Text("This product will be deleted"),
                    actions: [noButton, okButton],
                  );
                  return alert;
                },
              );
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            )));
  }
}
