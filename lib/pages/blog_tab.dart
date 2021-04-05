import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pending_blog.dart';
import 'blog_page.dart';

class BlogTab extends StatefulWidget {
  @override
  _BlogTabState createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Color(0xffF4F7F5),
        appBar: AppBar(
          title: Text("Daktarbari blog",style: TextStyle(
          fontSize: size.width * .040
          ),),
          centerTitle: true,
          bottom: TabBar(
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: size.width * .030
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.account_box,),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(Icons.article_sharp,),
                  text: 'pending',
                ),

              ]),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(

              children: [
                BlogPage(),
                PendingBlog(),
              ]
          ),
        ),
      ),
    );
  }
}
