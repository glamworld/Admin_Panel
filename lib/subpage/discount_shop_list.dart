import 'package:admin_panel/model/shop_model.dart';
import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'discount_shop_detailes.dart';
import 'package:admin_panel/providers/review_provider.dart';
import '../notification_widget.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';

class DiscountShopList extends StatefulWidget {
  String subCategory;

  DiscountShopList(this.subCategory);

  @override
  _DiscountShopListState createState() => _DiscountShopListState();
}

class _DiscountShopListState extends State<DiscountShopList> {
  List<ShopModel> filteredShops = List();
  List<ShopModel> shopList = List();
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    DiscountShopProvider operation =
    Provider.of<DiscountShopProvider>(context);
    if (_counter == 0) {
        setState(() {
          shopList=operation.shopList;
          filteredShops=shopList;
          _counter++;
        });
    }
      return Scaffold(
        backgroundColor: Color(0xffF4F7F5),
        appBar: customAppBarDesign(context,widget.subCategory),
        body: Column(
          children: [
            TextField(
            keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Search by Executive Phone No..',
              ),
              onChanged: (string) {
                setState(() {
                  filteredShops = shopList
                      .where((u) => (u.executivePhoneNo
                      .contains(string.toLowerCase())))
                      .toList();
                });

              },
            ),
            SizedBox(height: 5,),
            Expanded(child: _counter==0?Center(child: CircularProgressIndicator()):_bodyUI()),
          ],
        )
      );
  }
  Widget _bodyUI() {
    DiscountShopProvider operation =
    Provider.of<DiscountShopProvider>(context);
          return RefreshIndicator(
            backgroundColor: Colors.white,
            onRefresh: ()async{
              await operation.getShop(widget.subCategory).then((value){
                setState(() {
                  shopList=operation.shopList;
                  filteredShops=shopList;
                });
              });
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: filteredShops.length,
              itemBuilder: (BuildContext context, int index) {
                return DiscountShopTile(
                  id: filteredShops[index].id,
                  name: filteredShops[index].shopName,
                  about: filteredShops[index].about,
                  subCategory: filteredShops[index].subCategory,
                  location: filteredShops[index].shopAddress,
                  urlImage: filteredShops[index].shopImage,
                  executivePhone: filteredShops[index].executivePhoneNo,
                  review: filteredShops[index].avgReviewStar,
                );
              }),
          );
  }

}
class DiscountShopTile extends StatelessWidget {
  String id,name, about,subCategory, review,executivePhone,location, urlImage;
  static const Color starColor = Color(0xffFFBA00);

  DiscountShopTile(
      {
        this.id,
        this.about,
        this.name,
        this.subCategory,
        this.review,
        this.location,
        this.executivePhone,
        this.urlImage});

  @override
  Widget build(BuildContext context) {
    DiscountShopProvider operation = Provider.of<DiscountShopProvider>(context);
    ReviewProvider reviewProvider = Provider.of<ReviewProvider>(context);
    return GestureDetector(
      onTap: ()async{
        operation.loadingMgs='Please wait...';
        showLoadingDialog(context,operation);
        await operation.getShopId(id).then((value)async{
          await reviewProvider.getAllShopReview(id).then((value)async{
            await operation.getFeaturedProduct(id).then((value){
              reviewProvider.getShopOneStar();
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DiscountShopDetails(id: id,subcategory: subCategory,)));
            });

        },onError: (error){
          Navigator.pop(context);
          showAlertDialog(context, error.toString());
        });
        });

      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffF4F7F5),
          border: Border.all(
              color: Theme.of(context).primaryColor
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image Container
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, offset: Offset(0, 1), blurRadius: 2)
                    ]),
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: urlImage,
                  placeholder: (context, url) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/loadingimage.gif',height: 90, width: 200,fit: BoxFit.cover,),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                  height: 180,

                  fit: BoxFit.fill,
                ),),
            //Content Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Shop Name
                  Text(
                    name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  //Shop Location
                  Text(
                    location,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  //Shop About
                  Text(about,maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 15,)
                  ),
                  SizedBox(height: 10),
                  Text(executivePhone,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 15,)
                  ),
                  SizedBox(height: 10),

                  Divider(color: Theme.of(context).primaryColor,),
                  //Footer Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                        decoration:BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text("Open",style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                        ),),
                      ),

                      //Rating Section
                      Row(
                        children: [
                          Text(
                            "Ratings:",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5),
                          review == '5.0'
                              ? Row(
                            children: [
                              Icon(Icons.star, size: 15, color: starColor),
                              Icon(Icons.star, size: 15, color: starColor),
                              Icon(Icons.star, size: 15, color: starColor),
                              Icon(Icons.star, size: 15, color: starColor),
                              Icon(Icons.star, size: 15, color: starColor),
                            ],
                          )
                              : review == '4.0'
                              ? Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          )
                              : review == '4.5'
                              ? Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          )
                              : review == '3.0'
                              ? Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          )
                              : review == '3.5'
                              ? Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          )
                              : review == '2.0'
                              ? Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          )
                              : review == '2.5'
                              ? Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          )
                              : Row(
                            children: [
                              Icon(Icons.star,
                                  size: 15, color: starColor),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
