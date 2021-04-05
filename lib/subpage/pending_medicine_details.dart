import 'package:admin_panel/utils/static_variable_page.dart';
import 'package:admin_panel/utils/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/button_widgets.dart';
import 'package:admin_panel/notification_widget.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';
import 'package:admin_panel/providers/medicine_provider.dart';

// ignore: must_be_immutable
class PendingMedicineDetails extends StatefulWidget {
  String id;
  String name;
  String strength;
  String genericName;
  String dosage;
  String manufacturer;
  String price;
  String indications;
  String adultDose;
  String childDose;
  String renalDose;
  String administration;
  String contradiction;
  String sideEffect;
  String precautions;
  String pregnancy;
  String therapeutic;
  String modeOfAction;
  String interaction;
  String darNo;
  PendingMedicineDetails({
    this.id,
    this.name,
    this.strength,
    this.genericName,
    this.dosage,
    this.manufacturer,
    this.price,
    this.indications,
    this.adultDose,
    this.childDose,
    this.renalDose,
    this.administration,
    this.contradiction,
    this.sideEffect,
    this.precautions,
    this.pregnancy,
    this.therapeutic,
    this.modeOfAction,
    this.interaction,
    this.darNo});
  @override
  _PendingMedicineDetailsState createState() => _PendingMedicineDetailsState();
}

class _PendingMedicineDetailsState extends State<PendingMedicineDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final MedicineProvider provider = Provider.of<MedicineProvider>(context);
    FirebaseOperationProvider operation =
    Provider.of<FirebaseOperationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _customAppBar(),
      body: _bodyUI(),
      bottomNavigationBar:
      GestureDetector(
          onTap: (){
            operation.loadingMgs='Please wait...';
            showLoadingDialog(context,operation);
            provider.updatePendingMedicine(_scaffoldKey, widget.id, context, provider).
            then((value) {
              provider.getPendingMedicine();
              provider.getMedicine();
            });
          },
          child: ChangeButton(context,'Approve',Colors.blue)),
    );
  }

  Widget _customAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        // title: Text(
        //   widget.name,
        //   style: TextStyle(color: Colors.black, fontSize: 15),
        // ),
        //centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
                )),
          ),
        ),
      ),
    );
  }

  Widget _bodyUI() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Column(
        children: [
          //Header...
          Container(
            height: size.height * .17,
            width: size.width,
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 40,),
                  Text(
                    widget.name,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      widget.strength,
                      maxLines: 1,
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.genericName,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      widget.dosage,
                      maxLines: 1,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '৳ ${widget.price}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.manufacturer,
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    //SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),

          //body...
          Container(
            height: size.height * .65,
            width: size.width,
            color: Colors.white,
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) =>
                  EntryItemTile(medicineDataList(widget.indications,
                      widget.adultDose,
                      widget.childDose,
                      widget.renalDose,
                      widget.administration,
                      widget.contradiction,
                      widget.sideEffect,
                      widget.precautions,
                      widget.pregnancy,
                      widget.therapeutic,
                      widget.modeOfAction,
                      widget.interaction)[index]),
            ),
          ),
        ],
      ),
    );
  }
}

///Create the widget for the row...
// ignore: must_be_immutable
class EntryItemTile extends StatelessWidget {
  final Entry entry;

  EntryItemTile(this.entry);

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(
          root.title,
          style: TextStyle(color: Colors.grey[800], fontSize: 12),
        ),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      childrenPadding: EdgeInsets.all(0.0),
      //tilePadding: EdgeInsets.all(0.0),
      title: Text(
        root.title,
        style: TextStyle(fontSize: 14),
      ),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}