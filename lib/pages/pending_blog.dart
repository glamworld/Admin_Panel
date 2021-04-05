import 'package:admin_panel/model/article_model.dart';
import 'package:admin_panel/providers/article_provider.dart';
import 'package:admin_panel/subpage/read_pending_article.dart';
import 'package:admin_panel/utils/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../notification_widget.dart';

class PendingBlog extends StatefulWidget {
  @override
  _PendingBlogState createState() => _PendingBlogState();
}

class _PendingBlogState extends State<PendingBlog> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
        builder: (context,articleProvider,child){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _bodyUI(articleProvider),
    );
  });
}

Widget _bodyUI(ArticleProvider articleProvider) {
  return RefreshIndicator(
    backgroundColor: Colors.white,
    onRefresh: ()=>articleProvider.getPendingArticle(),
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
    articleProvider.pendingArticleList.isNotEmpty? _postBuilder('recent',articleProvider.pendingArticleList)
        :Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*.3),
            NoData(message:'No Pending Post \u{1f614}'),
          ],
        ),
      ],
    ),
  );
}

  Widget _postBuilder(String identifier, List<ArticleModel> list) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 310,
        width: size.width,
        //color: Colors.grey,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: list.length>50? 50: list.length,
            itemBuilder: (context, index) {
              return PostTile(
                  identifier: identifier,
                  index: index,
                  list: list);
            }));
  }

}
class PostTile extends StatelessWidget {
  int index;
  String identifier;
  List<ArticleModel> list;
  PostTile({this.identifier,this.index,this.list});

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, articleProvider, child){
        return GestureDetector(
          onTap: ()async{
            articleProvider.loadingMgs= 'Please wait...';
            showLoadingDialog(context,articleProvider);
            await articleProvider.getArticleComments(list[index].id).then((value){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadPendingArticle(
                articleIndex: index,
                id: list[index].id,
                photoUrl: list[index].photoUrl,
                date: list[index].date,
                title: list[index].title,
                author: list[index].author,
                authorPhoto: list[index].authorPhoto,
                category: list[index].category,
                abstract: list[index].abstract,
                introduction: list[index].introduction,
                methods: list[index].methods,
                results: list[index].results,
                conclusion: list[index].conclusion,
                acknowledgement: list[index].acknowledgement,
                reference: list[index].reference,
                doctorId: list[index].doctorId,
              )));
            });
          },
          child: Container(
            width: 200,
            height: 310,
            margin: EdgeInsets.only(right: 10, top: 5, bottom: 5, left: 2.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 2.0, offset: Offset(0, 1))
                ]),
            child: Stack(
              children: [
                ///Image
                Positioned(
                    top: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 90,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: list[index].photoUrl,
                              width: 200,
                              height: 90,
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/loadingimage.gif',height: 90, width: 200,fit: BoxFit.cover,),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),

                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),

                        ///Title, date, description
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Title...
                              Container(
                                  width: 195,
                                  child: Text(
                                    list[index].title,
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(height: 5),
                              //Vertical line
                              Container(
                                height: 3,
                                width: 100,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(height: 5),
                              //Date...
                              Container(
                                  width: 195,
                                  child: Text(
                                    list[index].date,
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(height: 20),
                              //Description...
                              Container(
                                  width: 195,
                                  child: Text(
                                    list[index].abstract,
                                    maxLines: 5,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        )
                      ],
                    )),

                ///Footer (like & share)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
