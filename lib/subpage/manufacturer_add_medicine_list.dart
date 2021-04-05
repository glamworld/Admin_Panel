import 'package:admin_panel/providers/representative_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManufacturerRepresentativeDetails extends StatefulWidget {
  String representativePhone;

  ManufacturerRepresentativeDetails({this.representativePhone});

  @override
  _ManufacturerRepresentativeDetailsState createState() => _ManufacturerRepresentativeDetailsState();
}

class _ManufacturerRepresentativeDetailsState extends State<ManufacturerRepresentativeDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      backgroundColor: Color(0xffF4F7F5),
      body: _bodyUI(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
  Widget _bodyUI() {
    RepresentativeProvider operation =
    Provider.of<RepresentativeProvider>(context);
    return ListView.builder(
        itemCount: operation.representativeMedicineList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MedicineTile(
              name: operation.representativeMedicineList[index].name,
              genericName: operation.representativeMedicineList[index].genericName,
              price: operation.representativeMedicineList[index].price,
              strength: operation.representativeMedicineList[index].strength,
              manufacturer: operation.representativeMedicineList[index].manufacturer,
              dosage: operation.representativeMedicineList[index].dosage,

            ),
          );
        });
  }
}
class MedicineTile extends StatelessWidget {
  String name, genericName,strength;
  String price,manufacturer,dosage;

  MedicineTile({this.name, this.genericName,this.price,this.strength,this.manufacturer,this.dosage});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10,),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300], offset: Offset(1, 1), blurRadius: 2)
            ]),
        child: ListTile(
          onTap: (){},
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                style: TextStyle(fontSize: 17, color: Colors.grey[900]),
              ),
              SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  strength,
                  maxLines: 1,
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                genericName,
                maxLines: 1,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),

              Text(
                dosage,
                maxLines: 1,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '৳ $price',
                maxLines: 1,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),

              SizedBox(
                height: 2,
              ),
              Text(
                manufacturer,
                maxLines: 1,
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ));
  }
}