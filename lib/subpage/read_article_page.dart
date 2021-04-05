import 'package:admin_panel/providers/article_provider.dart';
import 'package:admin_panel/utils/comment_modal.dart';
import 'package:admin_panel/utils/custom_app_bar.dart';
import 'package:admin_panel/utils/no_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/utils/button_widgets.dart';
import '../notification_widget.dart';
import 'package:expandable_text/expandable_text.dart';

// ignore: must_be_immutable
class ReadArticle extends StatefulWidget {
  int articleIndex;
  String id;
  String photoUrl;
  String date;
  String title;
  String author;
  String authorPhoto;
  String like;
  String share;
  String category;
  String abstract;
  String introduction;
  String methods;
  String results;
  String conclusion;
  String acknowledgement;
  String reference;
  String doctorId;

  ReadArticle({
        this.articleIndex,
        this.id,
        this.photoUrl,
        this.date,
        this.title,
        this.author,
        this.like,
        this.share,
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
  _ReadArticleState createState() => _ReadArticleState();
}

class _ReadArticleState extends State<ReadArticle> {
  final _formKey = GlobalKey<FormState>();
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

          ///Comment builder
          _sectionHeading('All comments'),
          SizedBox(height: 5),
          articleProvider.articleCommentList.isNotEmpty?
              ListView.builder(
                itemCount: articleProvider.articleCommentList.length>2? 2
                    : articleProvider.articleCommentList.length,
                shrinkWrap: true,
                itemBuilder: (context, index)=> _commentTile(index,size),
              )
              :NoData(message: 'No comments yet \u{1f614}'),

          articleProvider.articleCommentList.length>2? Container(
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: ()=> ViewAllComment(context),
              child: Text("View all comments",textAlign: TextAlign.end,style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),),
            ),
          ):Container(),
          _divider(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      Widget okButton = FlatButton(
                        child: Text("YES"),
                        onPressed: () {
                          articleProvider.loadingMgs = 'Deleting blog...';
                          showLoadingDialog(context, articleProvider);
                          articleProvider.deleteBlog(widget.id, context).then((value){
                            articleProvider.getAllArticle();
                            articleProvider.getPopularArticle();
                          });

                        },
                      );
                      Widget noButton = FlatButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        title: Text("Are you sure you want to delete this Blog?"),
                        content: Text("This Blog will be deleted"),
                        actions: [
                          noButton,
                          okButton
                        ],
                      );
                      return alert;
                    },
                  );
                },
                child: ChangeButton(context,'Delete',Colors.red))
            ),
          _sectionHeading("Related Articles"),
          _relatedArticle(size),
          SizedBox(height: 20),
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
            textAlign: TextAlign.justify,

            style: TextStyle(
                color: Colors.grey[900],
                fontSize: size.width*.045,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),

        ///Date, like, share Section...
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${widget.like??'0'}",
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
                  SizedBox(width: 10),
                  Text(
                    "${widget.share??'0'}",
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

  Widget _sectionHeading(String heading){
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(heading,style: TextStyle(
          color: Colors.grey[600],
          fontSize: 17,
          fontWeight: FontWeight.w500),),
    );
  }

  Widget _commentTile(int index, Size size) {
    return Consumer<ArticleProvider>(
      builder: (context, articleProvider, child){
        return Container(
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width * .11,
                height: size.width * .11,
                decoration: BoxDecoration(
                  color: Color(0xffAAF1E8),
                  image: DecorationImage(
                    image: articleProvider.articleCommentList[index].commenterPhoto==null? AssetImage('assets/male.png')
                        :NetworkImage(articleProvider.articleCommentList[index].commenterPhoto),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              SizedBox(width: size.width * .01),
              Container(
                width: size.width * .81,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(articleProvider.articleCommentList[index].commenterName
                        ,style: TextStyle(fontSize: 13, color: Colors.grey[900],fontWeight: FontWeight.bold)),
                    ExpandableText(
                      articleProvider.articleCommentList[index].comment,
                      expandText: 'more',
                      collapseText: 'less',
                      maxLines: 2,
                      linkColor: Theme.of(context).primaryColor,
                      style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                    ),
                    Text(
                      articleProvider.articleCommentList[index].commentDate,
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }


  Widget _relatedArticle(Size size){
    return Consumer<ArticleProvider>(
      builder: (context, articleProvider, child){
        return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 310,
            width: size.width,
            child: articleProvider.popularArticleList.isNotEmpty? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: articleProvider.popularArticleList.length>50? 50
                    :articleProvider.popularArticleList.length,
                itemBuilder: (context, index) {
                  return PostTile(
                    index: index,
                  );
                })
                : NoData(message:'Something went wrong \u{1f614}')
        );
      },
    );
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadArticle(
                id: articleProvider.popularArticleList[index].id,
                articleIndex: index,
                photoUrl: articleProvider.popularArticleList[index].photoUrl,
                date: articleProvider.popularArticleList[index].date,
                title: articleProvider.popularArticleList[index].title,
                author: articleProvider.popularArticleList[index].author,
                authorPhoto: articleProvider.popularArticleList[index].authorPhoto,
                like: articleProvider.popularArticleList[index].like,
                share: articleProvider.popularArticleList[index].share,
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