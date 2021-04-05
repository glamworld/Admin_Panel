import 'package:admin_panel/providers/article_provider.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../notification_widget.dart';
import 'package:admin_panel/utils/button_widgets.dart';

// ignore: must_be_immutable
class ReadPendingArticle extends StatefulWidget {
  int articleIndex;
  String id;
  String photoUrl;
  String date;
  String title;
  String author;
  String authorPhoto;
  String category;
  String abstract;
  String introduction;
  String methods;
  String results;
  String conclusion;
  String acknowledgement;
  String reference;
  String doctorId;

  ReadPendingArticle({
    this.articleIndex,
    this.id,
    this.photoUrl,
    this.date,
    this.title,
    this.author,
    this.category,
    this.abstract,
    this.introduction,
    this.methods,
    this.results,
    this.conclusion,
    this.acknowledgement,
    this.reference,
    this.doctorId,
    this.authorPhoto});

  @override
  _ReadPendingArticleState createState() => _ReadPendingArticleState();
}

class _ReadPendingArticleState extends State<ReadPendingArticle> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController comController= TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: customAppBarDesign(context, 'Cervical Cancer'),
      body: _bodyUI(articleProvider),
    );
  }

  Widget _bodyUI(ArticleProvider articleProvider) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          _articleDetails(size,articleProvider),
          _divider(),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: (){
                articleProvider.loadingMgs='Please wait...';
                showLoadingDialog(context,articleProvider);
                articleProvider.updatePendingArticle(_scaffoldKey, widget.id, context, articleProvider).
                then((value) {
                  articleProvider.getAllArticle();
                  articleProvider.getPopularArticle();
                });
              },
                child: ChangeButton(context,'Approve',Colors.blue))
          )
        ],
      ),
    );
  }

  Widget _articleDetails(Size size, ArticleProvider articleProvider) {
    return Column(
      children: [
        ///Image Section...
        Container(
          height: size.width * .65,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: widget.photoUrl,
              width: size.width,
              height: size.width * .65,
              placeholder: (context, url) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/loadingimage.gif', height: size.width * .65,
                  width: size.width,fit: BoxFit.cover,),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),

              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),

        ///Title Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.grey[900],
                fontSize: 19,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),

        ///Date Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.date_range, color: Theme.of(context).primaryColor),
                  SizedBox(width: 4),
                  Text(
                    widget.date,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        ///Writer Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.authorPhoto==null? AssetImage('assets/male.png')
                        :NetworkImage(widget.authorPhoto),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              SizedBox(width: 5),
              Text(
                widget.author,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        ///Abstract Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Abstract: ${widget.abstract}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),

        ///Introduction Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Introduction: ${widget.introduction}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        ///Methods Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Methods: ${widget.methods}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        ///Results Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Results: ${widget.results}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        ///Conclusion Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Conclusion: ${widget.conclusion}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        ///Acknowledgement Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Acknowledgement: ${widget.acknowledgement}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        ///References Section...
        Container(
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'References: ${widget.reference}',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 13.5,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _divider() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Divider(
          color: Theme.of(context).primaryColor,
        ));
  }
}


// ignore: must_be_immutable
class PostTile extends StatelessWidget {
  int index;
  PostTile({this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, articleProvider, child){
        return GestureDetector(
          onTap: ()async{
            articleProvider.loadingMgs= 'Please wait...';
            showLoadingDialog(context,articleProvider);
            await articleProvider.getArticleComments(articleProvider.popularArticleList[index].id).then((value){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadPendingArticle(
                id: articleProvider.popularArticleList[index].id,
                articleIndex: index,
                photoUrl: articleProvider.popularArticleList[index].photoUrl,
                date: articleProvider.popularArticleList[index].date,
                title: articleProvider.popularArticleList[index].title,
                author: articleProvider.popularArticleList[index].author,
                authorPhoto: articleProvider.popularArticleList[index].authorPhoto,
                category: articleProvider.popularArticleList[index].category,
                abstract: articleProvider.popularArticleList[index].abstract,
                introduction: articleProvider.popularArticleList[index].introduction,
                methods: articleProvider.popularArticleList[index].methods,
                results: articleProvider.popularArticleList[index].results,
                conclusion: articleProvider.popularArticleList[index].conclusion,
                acknowledgement: articleProvider.popularArticleList[index].acknowledgement,
                reference: articleProvider.popularArticleList[index].reference,
                doctorId: articleProvider.popularArticleList[index].doctorId,
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
                              imageUrl: articleProvider.popularArticleList[index].photoUrl,
                              height: 90,
                              width: 200,
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
                                    articleProvider.popularArticleList[index].title,
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
                                    articleProvider.popularArticleList[index].date,
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
                                    articleProvider.popularArticleList[index].abstract,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${articleProvider.popularArticleList[index].like ?? '0'}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.suit_heart,
                                color: Colors.pink,
                                size: 20,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${articleProvider.popularArticleList[index].share ?? '0'}",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.arrowshape_turn_up_right,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
