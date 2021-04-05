import 'package:admin_panel/providers/discount_shop_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';


// ignore: non_constant_identifier_names
void ViewFeaturedProducts(BuildContext context) {
  Size size= MediaQuery.of(context).size;
  showModalBottomSheet(
      context: context,
      builder: (context){
        return Consumer<DiscountShopProvider>(
          builder: (context, operation, child){
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
                      itemCount: operation.productList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return ListTile(
                            leading: CachedNetworkImage(
                              width: size.width * .20,
                              imageUrl: operation.productList[index].imageUrl,
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                            title: Text("ProductName: "+ operation.productList[index].productName),
                            subtitle: Text("ProductPrice: "+ operation.productList[index].productPrice),
                            trailing: GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      Widget okButton = FlatButton(
                                        child: Text("YES"),
                                        onPressed: () {
                                          operation.loadingMgs='Deleting...';
                                          showLoadingDialog(context, operation);
                                          operation.deleteFeaturedProduct(operation.productList[index].id,operation.productList[index].shopId,context,operation);
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
                                        title: Text("Are you sure you want to delete this Product?"),
                                        content: Text("This product will be deleted"),
                                        actions: [
                                          noButton,
                                          okButton
                                        ],
                                      );
                                      return alert;
                                    },
                                  );
                                },
                                child: Icon(Icons.delete,color: Colors.red,)
                            )
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
  );
}

