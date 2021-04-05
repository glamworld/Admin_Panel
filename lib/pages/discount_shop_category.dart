import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:admin_panel/subpage/add_discount_shop.dart';
import 'package:admin_panel/utils/form_decoration.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/static_variable_page.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import '../notification_widget.dart';
import 'package:admin_panel/subpage/discount_shop_list.dart';

class DiscountShopCategory extends StatefulWidget {
  @override
  _DiscountShopCategoryState createState() => _DiscountShopCategoryState();
}

class _DiscountShopCategoryState extends State<DiscountShopCategory> {
  String hospitalLabPharmacy;
  String travelTour;
  String hotelRestaurant;
  String educationTraining;
  String entertainment;
  String weddingParlor;
  String familyNeeds;
  String demandService;
  String equipmentTools;
  String hireRent;
  String automobiles;
  String realState;
  String miscellaneous;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBarDesign(context, "Discount Shop"),
      body:_bodyUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddDiscountShop())),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 2,
        tooltip: "Discount Shop List",
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
  Widget _bodyUI(){
    Size size = MediaQuery.of(context).size;
    return Container(
     // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        children: [
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Hospital/Lab/Pharmacy'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Travel & Tour'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Hotel & Restaurant'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Education & Training'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Entertainment'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Wedding & Parlor'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Family Needs'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Demand Service'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Equipment & Tools'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Hire & Rent'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Automobiles'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Real State'),
          SizedBox(height: size.width / 20),
          _dropDownBuilder('Miscellaneous'),
          SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Hospital/Lab/Pharmacy',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Travel & Tour',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Hotel & Restaurant',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Education & Training',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Entertainment',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Wedding & Parlor',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Family Needs',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Demand Service',),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Equipment & Tools'),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Hire & Rent'),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Automobiles'),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Real State'),
          // SizedBox(height: size.width / 20),
          // _dropDownBuilder('Select Miscellaneous'),
          // SizedBox(height: size.width / 20),
        ],
      ),
    );
  }
  Widget _dropDownBuilder(String hint){
    Size size=MediaQuery.of(context).size;
    DiscountShopProvider operation = Provider.of<DiscountShopProvider>(context);
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,),
      decoration: BoxDecoration(
        color: Colors.white, //Color(0xffF4F7F5),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: cardDecoration,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: hint=="Hospital/Lab/Pharmacy"? hospitalLabPharmacy
                : hint=="Travel & Tour"? travelTour
                : hint=="Hotel & Restaurant"? hotelRestaurant
                : hint=="Education & Training"? educationTraining
                : hint=="Entertainment"? entertainment
                : hint=="Wedding & Parlor"? weddingParlor
                : hint=="Family Needs"? familyNeeds
                : hint=="Demand Service"? demandService
                : hint=="Equipment & Tools"? equipmentTools
                : hint=="Hire & Rent"? hireRent
                : hint=="Automobiles"? automobiles
                : hint=="Real State"? realState
                :miscellaneous,
            hint: Text(hint,style: TextStyle(
                color: Colors.grey[900],
                fontSize: 16)),
            items: hint=='Hospital/Lab/Pharmacy'?
            StaticVariables.hlpSubCategory.map((hospitalLabPharmacy){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(hospitalLabPharmacy,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: hospitalLabPharmacy,
              );
            }).toList()
                :hint=='Travel & Tour'?
            StaticVariables.tourSubCategory.map((travelTour){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(travelTour,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: travelTour,
              );
            }).toList()
            //for service category
                :hint=='Hotel & Restaurant'?
            StaticVariables.hotelSubCategory.map((hotelRestaurant){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(hotelRestaurant,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: hotelRestaurant,
              );
            }).toList()
            //for service category
                :hint=='Education & Training'?
            StaticVariables.educationSubCategory.map((educationTraining){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(educationTraining,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: educationTraining,
              );
            }).toList()
            //for service category
                :hint=='Entertainment'?
            StaticVariables.entertainSubCategory.map((entertainment){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(entertainment,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: entertainment,
              );
            }).toList()
            //for service category
                :hint=='Wedding & Parlor'?
            StaticVariables.weddingSubCategory.map((weddingParlor){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(weddingParlor,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: weddingParlor,
              );
            }).toList()
            //for service category
                :hint=='Family Needs'?
            StaticVariables.familySubCategory.map((familyNeeds){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(familyNeeds,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: familyNeeds,
              );
            }).toList()
            //for service category
                :hint=='Demand Service'?
            StaticVariables.demandSubCategory.map((demandService){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(demandService,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: demandService,
              );
            }).toList()
            //for service category
                :hint=='Equipment & Tools'?
            StaticVariables.equipmentSubCategory.map((equipmentTools){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(equipmentTools,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: equipmentTools,
              );
            }).toList()
            //for service category
                :hint=='Hire & Rent'?
            StaticVariables.hireSubCategory.map((hireRent){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(hireRent,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: hireRent,
              );
            }).toList()
            //for service category
                :hint=='Automobiles'?
            StaticVariables.autoMobileSubCategory.map((automobiles){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(automobiles,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: automobiles,
              );
            }).toList()
            //for service category
                :hint=='Real State'?
            StaticVariables.realStateSubCategory.map((realState){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(realState,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: realState,
              );
            }).toList()
            //for service category
                :StaticVariables.miscellaneousSubCategory.map((miscellaneous){
              return DropdownMenuItem(
                child: Container(
                  width: size.width*.75,
                  child: Text(miscellaneous,style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,)),
                ),
                value: miscellaneous,
              );
            }).toList(),
            onChanged: (newValue)async{
              setState(() {
                hint=="Hospital/Lab/Pharmacy"? hospitalLabPharmacy = newValue
                    :hint=="Travel & Tour"? travelTour = newValue
                    :hint=="Hotel & Restaurant"? hotelRestaurant = newValue
                    :hint=="Education & Training"? educationTraining = newValue
                    :hint=="Entertainment"? entertainment = newValue
                    :hint=="Wedding & Parlor"? weddingParlor = newValue
                    :hint=="Family Needs"? familyNeeds = newValue
                    :hint=="Demand Service"? demandService = newValue
                    :hint=="Equipment & Tools"? equipmentTools = newValue
                    :hint=="Hire & Rent"? hireRent = newValue
                    :hint=="Automobiles"? automobiles = newValue
                    :hint=="Real State"? realState = newValue
                    :miscellaneous = newValue;
              });
              operation.loadingMgs='Please wait...';
              showLoadingDialog(context,operation);
              await operation.getShop(newValue).then((value)async{
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountShopList(newValue)));
              },onError: (error){
                Navigator.pop(context);
                showAlertDialog(context, error.toString());
              });
            },
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }

  // Widget _dropDownBuilder(String hint){
  //   FirebaseOperationProvider operation = Provider.of<FirebaseOperationProvider>(context);
  //   return Container(
  //     height: 55,
  //     padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
  //     decoration: BoxDecoration(
  //         color: Color(0xffF4F7F5),
  //         border: Border.all(
  //           color: Colors.blueGrey,
  //           width: 4,
  //         ),
  //         borderRadius: BorderRadius.all(Radius.circular(10))
  //     ),
  //     width: MediaQuery.of(context).size.width,
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton(
  //         value: hint=="Select Hospital/Lab/Pharmacy"? hospitalLabPharmacy
  //             : hint=="Select Travel & Tour"? travelTour
  //             : hint=="Select Hotel & Restaurant"? hotelRestaurant
  //             : hint=="Select Education & Training"? educationTraining
  //             : hint=="Select Entertainment"? entertainment
  //             : hint=="Select Wedding & Parlor"? weddingParlor
  //             : hint=="Select Family Needs"? familyNeeds
  //             : hint=="Select Demand Service"? demandService
  //             : hint=="Select Equipment & Tools"? equipmentTools
  //             : hint=="Select Hire & Rent"? hireRent
  //             : hint=="Select Automobiles"? automobiles
  //             : hint=="Select Real State"? realState
  //             :miscellaneous,
  //         hint: Text(hint,style: TextStyle(
  //             color: Colors.grey[700],
  //             fontSize: 16)),
  //         items: hint=='Select Hospital/Lab/Pharmacy'?
  //         StaticVariables.hlpSubCategory.map((hospitalLabPharmacy){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(hospitalLabPharmacy,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: hospitalLabPharmacy,
  //           );
  //         }).toList()
  //             :hint=='Select Travel & Tour'?
  //         StaticVariables.tourSubCategory.map((travelTour){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(travelTour,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: travelTour,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Hotel & Restaurant'?
  //         StaticVariables.hotelSubCategory.map((hotelRestaurant){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(hotelRestaurant,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: hotelRestaurant,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Education & Training'?
  //         StaticVariables.educationSubCategory.map((educationTraining){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(educationTraining,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: educationTraining,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Entertainment'?
  //         StaticVariables.entertainSubCategory.map((entertainment){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(entertainment,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: entertainment,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Wedding & Parlor'?
  //         StaticVariables.weddingSubCategory.map((weddingParlor){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(weddingParlor,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: weddingParlor,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Family Needs'?
  //         StaticVariables.familySubCategory.map((familyNeeds){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(familyNeeds,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: familyNeeds,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Demand Service'?
  //         StaticVariables.demandSubCategory.map((demandService){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(demandService,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: demandService,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Equipment & Tools'?
  //         StaticVariables.equipmentSubCategory.map((equipmentTools){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(equipmentTools,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: equipmentTools,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Hire & Rent'?
  //         StaticVariables.hireSubCategory.map((hireRent){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(hireRent,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: hireRent,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Automobiles'?
  //         StaticVariables.autoMobileSubCategory.map((automobiles){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(automobiles,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: automobiles,
  //           );
  //         }).toList()
  //         //for service category
  //             :hint=='Select Real State'?
  //         StaticVariables.realStateSubCategory.map((realState){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(realState,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: realState,
  //           );
  //         }).toList()
  //         //for service category
  //             :StaticVariables.miscellaneousSubCategory.map((miscellaneous){
  //           return DropdownMenuItem(
  //             child: Container(
  //               width: MediaQuery.of(context).size.width*.75,
  //               child: Text(miscellaneous,style: TextStyle(
  //                 color: Colors.grey[900],
  //                 fontSize: 16,)),
  //             ),
  //             value: miscellaneous,
  //           );
  //         }).toList(),
  //         onChanged: (newValue)async{
  //           setState(() {
  //             hint=="Select Hospital/Lab/Pharmacy"? hospitalLabPharmacy = newValue
  //                 :hint=="Select Travel & Tour"? travelTour = newValue
  //                 :hint=="Select Hotel & Restaurant"? hotelRestaurant = newValue
  //                 :hint=="Select Education & Training"? educationTraining = newValue
  //                 :hint=="Select Entertainment"? entertainment = newValue
  //                 :hint=="Select Wedding & Parlor"? weddingParlor = newValue
  //                 :hint=="Select Family Needs"? familyNeeds = newValue
  //                 :hint=="Select Demand Service"? demandService = newValue
  //                 :hint=="Select Equipment & Tools"? equipmentTools = newValue
  //                 :hint=="Select Hire & Rent"? hireRent = newValue
  //                 :hint=="Select Automobiles"? automobiles = newValue
  //                 :hint=="Select Real State"? realState = newValue
  //                 :miscellaneous = newValue;
  //           });
  //           operation.loadingMgs='Please wait...';
  //           showLoadingDialog(context,operation);
  //           await operation.getShop(newValue).then((value)async{
  //             Navigator.pop(context);
  //             Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountShopList(newValue)));
  //           },onError: (error){
  //             Navigator.pop(context);
  //             showAlertDialog(context, error.toString());
  //           });
  //         },
  //         dropdownColor: Colors.white,
  //       ),
  //     ),
  //   );
  // }
}