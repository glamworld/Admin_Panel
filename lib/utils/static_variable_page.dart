import 'package:admin_panel/providers/doctor_provider.dart';
import 'package:admin_panel/providers/firebase_operation_provider.dart';

class StaticVariables {
  static const List<String> articleCategoryItems = [
    "News",
    "Diseases & Cause",
    "Health Tips",
    "Food & Nutrition",
    "Medicine & Treatment",
    "Medicare & Hospital",
    "Tourism & Cost",
    "Symptoms",
    "Visual Story",
  ];

  static const List<String> currency =['BD Taka', 'US Dollar'];

  static const List<String> genderItems = ['Male','Female','Others'];

  static const List<String> serviceCategoryItems = [
    'Cardiologist',
    'COVID-19 (corona virus)',
    'Dermatology',
    'Dietician',
    'Dentist',
    'Diabetes & Endocrinology',
    'Eye,Nose,Ear (ENT) Specialist',
    'General Practitioner',
    'Gestroenterology',
    'Gynecology',
    'General Physician',
    'Hematology',
    'Homeopathic',
    'Herbal',
    'Medicine',
    'Neuromedicine',
    'Nutritionest',
    'Nephrology (Kidney)',
    'Oncology (Cancer)',
    'Opthalmologist',
    'Orthodontist',
    'Orthopaedic',
    'Pain Medicine',
    'Psychiatrists‎',
    'Pediatrics (CHILD)',
    'Physical Medicine',
    'Physiotherapy',
    'Plastic Surgery',
    'Respiratory Medicine',
    'Surgeon',
    'Skin & VD',
    'Sonology',
    'Sexologist',
    'Urologist',
  ];

  static const List<String> medicineList = [
    'A-One',
    'A-One XR',
    'Ace',
    'Ace Power',
    'Asmol',
    'Centamol',
    'A-Forte',
    'Lifil-A',
    'Vitamin A-Forte',
    'Painex',
    'Pin Zero TR',
    'Alona',
    'Flacol',
    'Flac',
    'Flamyd',
    'Alprax XR',
    'AL-DS',
    'Alba',
    'Alprax',
    'Zerodol',
    'Zolax',
    'Z-Antacid',
    'Antacid Max',
    'Lactameal',
    'Lacticare',
    'Laczym',
  ];
  static const List<String> dosageList =[
    'Tablet', 'Suppository', 'Oral', 'Suspension', 'Pediatric', 'Drops', 'Syrup'
  ];
  static const List<String> shopCategoryList=[
    'Hospital',
    'Lab',
    'Pharmacy',
    'Entertainment',
    'Hotel & Restaurant',
    'Travel & Tour',
    'Education & Training',
    'Family Needs',
    'Equipment & Tools',
    'Hire & Rent',
    'Wedding & Parlor',
    'Demand Service',
    'Automobile',
    'Real State',
    'Miscellaneous'
  ];

  static const List<String> hlpSubCategory=[
    'Clinic',
    'Hospital',
    'Pharmacy',
    'Lab/Diagnostic',
    'Ambulance',
    'Blood Bank',
    'Fitness Center',
    'Nursing Service',
    'Maternity Center',
    'Physiotherapy Center',

  ];
  static const List<String> tourSubCategory=[
    'Tickets',
    'Rent a car/bus',
    'Money Exchange',
    'Tour Guide',
    'Tour Package',
    'Travel/Visa Assistant',
    'Hajj Package',

  ];
  static const List<String> hotelSubCategory=[
    'Hotel',
    'Restaurant',
    'Bangla',
    'Thai',
    'Chinese',

  ];
  static const List<String> educationSubCategory=[
    'School & college',
    'Photography',
    'Coaching',
    'Drawing/Painting',
    'Digital training',
    'Sports & Music',
    'English school',
    'Online training',
    'Vocational Training',
    'Corporate Training',

  ];
  static const List<String> entertainSubCategory=[
    'Movies',
    'Festivals',
    'Social Events',
    'Cause Dating',
    'Art & Exhibitions',
    'Plays & Comedy',
    'Picnic/Theme Park',
    'Foods & Happy Hours',
    'Events & Nightlife',
  ];
  static const List<String> weddingSubCategory=[
    'Parlors',
    'Florists',
    'Cook',
    'Jewelry Shop',
    'Photographers',
    'Sound System',
    'Banquet Hall',
    'Dance/ Music Group',
    'Wedding Decoration',
    'Matrimonial Bureaus',
    'Caterers Supply',
    'Wedding Cards',
  ];
  static const List<String> familySubCategory=[
    'Supper Shop',
    'Grocery',
    'Home Appliance',
    'Family Care',
    'Fashion Care',
    'Dairy Products',
    'Beauty care',
    'Cleaning Products',
    'Books & Stationery',
    'Fish & Meat',
    'Animals care',
    'Cakes/Pastry',
    'Baby Care',
    'Luggage & Bags',
  ];
  static const List<String> demandSubCategory=[
    'Cleaning',
    'Electrical',
    'Gardening',
    'Plumbing',
    'Sanitary',
    'Thai Work',
    'Painting',
    'Ad/Printing',
    'Masonry',
    'Carpentry',
    'Daily Labor',
    'Key maker',
    'Home Design',
    'Civil Contractors',
    'Web Design',
    'Software Sales',
    'Event Management',
    'House Keeping',
    'Film & Movie Production',
  ];
  static const List<String> equipmentSubCategory=[
    'Electrical/Electronics',
    'Industrial Equipment’s',
    'Food & Beverages',
    'Fashion Accessories',
    'Furniture & Hardware',
    'Apparels Clothing Footwear',
    'Agriculture Equipment’s',
    'Chemical Equipment',
    'Construction Machinery',
    'Engineering Services',
    'Gardening Tools',
    'Interior Designer Architecture',
    'Leather Goods Accessories',
    'Logistic & Transportation',
    'Laboratory Test Equipment',
    'Packaging & Labeling',
    'Security Equipment’s',
    'Stone Tiles Flooring',
    'Textile Goods',
    'Telecom Products',
  ];
  static const List<String> hireSubCategory=[
    'Flat on Rent',
    'Lift on Hire',
    'Room on Hire',
    'Cottage on Hire',
    'Hostel on Hire',
    'Bungalows on Hire',
    'Office Space on Hire',
    'Sound System on Hire',
    'Hydraulic Crane on Hire',
    'Dead body Freezer on Hire',
  ];
  static const List<String> autoMobileSubCategory=[
    'Car',
    'Motor Bike',
    'Automobile Spare parts',
    'Heavy Transport & Parts'
  ];
  static const List<String> realStateSubCategory=[
  'Flat for Sale',
  'Land for Sale',
  'Office for Sale',
  'Hotel for Sale',
  'Business Space for Sale',
  'Farms House for Sale',
  'Other Property',
  ];
  static const List<String> miscellaneousSubCategory=[
    'Police Station',
    'RAB',
    'WASA',
    'PDB/ Electricity',
    'GAS Leakage',
    'Fire Station',
    'Roads/Highway',
    '24 Hour Pharmacy',
    'Funeral Service',
  ];
  static const List<String> sentNotificationCategoryList=[
    'Doctor','Patient',
  ];
  static const List<String> medicalCategoryList=[
    'COVID-19 (Coronavirus)',
    'Child Specialists (Pediatricians)',
    'Cardiologist',
    'Chest specialist',
    'Cancer Specialist',
    'Diabetes & Endocrinology',
    'Dentistry(Dentist)',
    'Dietitian & Nutrition Specialist',
    'Eye Specialist',
    'Eye, Nose, Ear (ENT) Specialist',
    'Gastroenterology & Hepatology',
    'Gynecologists & Obstetricians',
    'Hematology',
    'Homeopathic',
    'Medicine',
    'Neuromedicine',
    'Neuro-Surgery',
    'Oncology (Cancer)',
    'Orthopedic Surgeons',
    'Physical Medicine',
    'Pain Medicine',
    'Plastic Surgery',
    'Physiotherapists',
    'Psychiatrist',
    'Sex & Skin VD (Dermatology)',
    'Thyroid & Hormone',
    'Urology Specialist',
    'Urologists (Nephrology)',
    'Unani & Ayurveda',
    'Vascular Surgery'
  ];
}



class Entry {
  final String title;
  final List<Entry>
      children; //Since this is an expansion list...children can be another list of entries.

  Entry(this.title, [this.children = const <Entry>[]]);
}

///This is the entire multi-level list displayed by this app
List<Entry> faqDataList(DoctorProvider operation) {
  final List<Entry> data = <Entry>[
    Entry('1. How much experience Dr. ${operation.doctorList[0].fullName} in ${operation.doctorList[0].specification}?', <Entry>[
      Entry('Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].one}.'),
    ]),
    Entry(
        '2. How can I book an online appointment with Dr. ${operation.doctorList[0].fullName}, ${operation.doctorList[0].specification}?',
        <Entry>[
          Entry(
              'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].two}.'),
        ]),
    Entry('3. What are the consultation charges of Dr. ${operation.doctorList[0].fullName}?', <Entry>[
      Entry('Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].three}.'),
    ]),
    Entry(
        '4. What is the location of the hospital/clinic/chamber in ${operation.doctorList[0].state?? 'your area'}?',
        <Entry>[
          Entry(
              'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].four}.'),
        ]),
    Entry(
        '5. Can I view the OPD schedule, fee, and other details of Dr. ${operation.doctorList[0].fullName}?',
        <Entry>[
          Entry(
              'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].five}.'),
        ]),
    Entry('6. Is. Dr. ${operation.doctorList[0].fullName} available at any other hospital?', <Entry>[
      Entry(
          'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].six}.'),
    ]),
    Entry('7. What is Dr. ${operation.doctorList[0].fullName}\'s fee?', <Entry>[
      Entry(
          'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].seven}.'),
    ]),
    Entry('8. What are Dr. ${operation.doctorList[0].fullName}\'s specialty interests?', <Entry>[
      Entry(
          'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].eight}.'),
    ]),
    Entry('9. Where can I consult Dr. ${operation.doctorList[0].fullName}?', <Entry>[
      Entry(
          'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].nine}.'),
    ]),
    Entry('10. What societies is Dr. ${operation.doctorList[0].fullName} a member of?', <Entry>[
      Entry(
          'Ans: ${operation.faqList.isEmpty? 'Did not update answer':operation.faqList[0].ten}.'),
    ]),

    //First Row...
    // Entry(
    //   'Title 1',
    //   <Entry>[
    //     Entry('Subtitle 1',
    //       <Entry>[
    //         Entry('Sub Item 1'),
    //         Entry('Sub Item 2'),
    //         Entry('Sub Item 3'),
    //       ],
    //     ),
    //     Entry('Item 1'),
    //     Entry('Item 2'),
    //   ],
    // ),

    //Second Row...
    // Entry('title 2',
    //     <Entry>[
    //       Entry('Item 1'),
    //       Entry('Item 2'),
    //       Entry('Subtitle',
    //         <Entry>[
    //           Entry('Sub Item 1'),
    //           Entry('Sub Item 2'),
    //         ],
    //       )
    //     ]
    // ),
  ];
  return data;
}


///This is the entire multi-level list displayed by this app
List<Entry> medicineDataList(String indications, String adultDose, String childDose,
    String renalDose, String administration, String contradiction, String sideEffect,
    String precautions, String pregnancy, String therapeutic, String modeOfAction,
    String interaction){
  final List<Entry> data = <Entry>[
    Entry('Indications', <Entry>[
      Entry(indications),
    ]),
    Entry(
        'Adult dose',
        <Entry>[
          Entry(
              adultDose),
        ]),
    Entry('Child dose', <Entry>[
      Entry(childDose),
    ]),
    Entry(
        'Renal dose',
        <Entry>[
          Entry(
              renalDose),
        ]),
    Entry(
        'Administration',
        <Entry>[
          Entry(
              administration),
        ]),
    Entry('Contraindication', <Entry>[
      Entry(
          contradiction),
    ]),
    Entry('Side effect', <Entry>[
      Entry(
          sideEffect),
    ]),
    Entry('Precautions & warnings', <Entry>[
      Entry(
          precautions),
    ]),
    Entry('Pregnancy & Lactation', <Entry>[
      Entry(
          pregnancy),
    ]),
    Entry('Therapeutic class', <Entry>[
      Entry(
          therapeutic),
    ]),
    Entry('Mode of Action', <Entry>[
      Entry(
          modeOfAction),
    ]),
    Entry('Interaction', <Entry>[
      Entry(
          interaction),
    ]),
    //First Row...
    // Entry(
    //   'Title 1',
    //   <Entry>[
    //     Entry('Subtitle 1',
    //       <Entry>[
    //         Entry('Sub Item 1'),
    //         Entry('Sub Item 2'),
    //         Entry('Sub Item 3'),
    //       ],
    //     ),
    //     Entry('Item 1'),
    //     Entry('Item 2'),
    //   ],
    // ),

    //Second Row...
    // Entry('title 2',
    //     <Entry>[
    //       Entry('Item 1'),
    //       Entry('Item 2'),
    //       Entry('Subtitle',
    //         <Entry>[
    //           Entry('Sub Item 1'),
    //           Entry('Sub Item 2'),
    //         ],
    //       )
    //     ]
    // ),
  ];
  return data;
}
