import 'package:admin_panel/providers/doctor_provider.dart';
import 'package:admin_panel/subpage/doctor_detailes_page/update_faq_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/static_variable_page.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';

class FAQPage extends StatefulWidget {
  String id;

  FAQPage({this.id});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    //DoctorProvider drProvider=Provider.of<DoctorProvider>(context);
    return Consumer<DoctorProvider>(
      builder: (context, operation,child){
        return Scaffold(
          backgroundColor: Colors.white,
          //backgroundColor: Color(0xffF4F7F5),

          body: ListView.builder(
            itemCount: faqDataList(operation).length,
            itemBuilder: (context, index) => EntryItemTile(
              faqDataList(operation)[index],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateFAQ(id: widget.id,))),
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.update_rounded,color: Colors.white,size: 30,),
            tooltip: "Update Faq's",
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        );
      },
    );
  }
}

///Create the widget for the row...
class EntryItemTile extends StatelessWidget {
  final Entry entry;

  const EntryItemTile(this.entry);

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title,style: TextStyle(color: Colors.grey[800]),),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title,style: TextStyle(fontWeight: FontWeight.w500),),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
