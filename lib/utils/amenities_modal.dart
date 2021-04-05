import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/notification_widget.dart';


// ignore: non_constant_identifier_names

  void ViewAllAmenities(BuildContext context,DiscountShopProvider auth,String id) {
    List<String> shopAmenities = List();
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
                    color: Colors.white
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
                      child: ListView.builder(
                        itemCount: auth.shopIdList[0].amenities.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          return Container(
                            width: size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Container(
                              width: size.width * .82,
                              height: 50,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[50],
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(auth.shopIdList[0].amenities[index].toString()
                                      ,style: TextStyle(fontSize: 15, color: Colors.grey[900],fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                      onTap: () {
                                        auth.loadingMgs='Removing...';
                                        showLoadingDialog(context, auth);
                                          shopAmenities.clear();
                                          auth.shopModel.amenities = null;
                                          shopAmenities.add(auth
                                              .shopIdList[0].amenities[index]
                                              .toString());
                                          auth.shopModel.amenities = shopAmenities;
                                          auth.removeAmenities(id,auth,context);
                                          auth.shopModel.amenities = null;
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
                    ),
                  ],
                ),
              );

        }
    );
  }




