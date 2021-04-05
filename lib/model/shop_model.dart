
class ShopModel{
  String id;
  String shopImage;
  String shopName;
  String about;
  String executiveName;
  String executivePhoneNo;
  String shopCategory;
  String subCategory;
  String webAddress;
  String mailAddress;
  String twitterLink;
  String facebookLink;
  String phoneNo;
  String linkedinLink;
  String discount;
  List<dynamic> amenities;
  List<dynamic> sat;
  List<dynamic> sun;
  List<dynamic> mon;
  List<dynamic> tue;
  List<dynamic> wed;
  List<dynamic> thu;
  List<dynamic> fri;
  String shopAddress;
  String avgReviewStar;
  String currency;
  String latitude;
  String longitude;

  ShopModel(
      {this.id,
      this.shopImage,
      this.shopName,
      this.about,
      this.executiveName,
      this.executivePhoneNo,
      this.shopCategory,
      this.subCategory,
      this.webAddress,
      this.mailAddress,
      this.twitterLink,
      this.facebookLink,
      this.phoneNo,
      this.linkedinLink,
      this.discount,
      this.amenities,
      this.sat,
      this.sun,
      this.mon,
      this.tue,
      this.wed,
      this.thu,
      this.fri,
      this.shopAddress,
      this.avgReviewStar,
      this.currency,
      this.latitude,
      this.longitude});
}