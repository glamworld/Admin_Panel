class DoctorDetailsModel {
  String id;
  String fullName;
  String photoUrl;
  String phone;
  String password;
  String email;
  String about;
  String country;
  String state;
  String city;
  String joinDate;
  String gender;
  String specification;
  List<dynamic> optionalSpecification;
  String degree;
  String bmdcNumber;
  String appFee;
  String teleFee;
  String experience;
  String totalPrescribe;
  String countryCode;
  String currency;
  bool provideTeleService;
  List<dynamic> sat;
  List<dynamic> sun;
  List<dynamic> mon;
  List<dynamic> tue;
  List<dynamic> wed;
  List<dynamic> thu;
  List<dynamic> fri;
  String totalTeleFee;

  DoctorDetailsModel(
      {this.id,
        this.fullName,
        this.phone,
        this.password,
        this.email,
        this.about,
        this.joinDate,
        this.gender,
        this.country,
        this.state,
        this.city,
        this.specification,
        this.optionalSpecification,
        this.degree,
        this.bmdcNumber,
        this.appFee,
        this.teleFee,
        this.experience,
        this.photoUrl,
        this.totalPrescribe,
        this.provideTeleService,
        this.currency,
        this.sat,
        this.countryCode,
        this.fri,
        this.mon,
        this.sun,
        this.thu,
        this.tue,
        this.wed,
        this.totalTeleFee});
}