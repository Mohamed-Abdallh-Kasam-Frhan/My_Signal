import 'package:flutter/material.dart';
 import 'package:mysignal/models/category.dart';
import 'package:mysignal/models/signal.dart';

final List<Category> mainCategories = [
 const  Category(
    id: 1,
    title: "أفعال",
    numberOf: 50,
    icon: Icons.directions_run,
    color: Color(0xFFB0E0E6),
    signals: [
      Signal(id :1, title: "أكل", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "أكل الطعام" ),
      Signal(id: 2, title: "شرب", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "شرب الماء" ),
      Signal(id: 3, title: "نوم", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "النوم في السرير" ),
      Signal(id: 4, title: "لعب", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "لعب الألعاب" ),
      Signal(id: 5, title: "قراءة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "قراءة الكتب" ),
      Signal(id: 6, title: "كتابة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "كتابة النصوص" ),
      Signal(id: 7, title: "مشاهدة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "مشاهدة الأفلام" ),
     ]
  ),
  
 const  Category(
    id: 2,
    title: "طعام",
    numberOf: 45,
    icon: Icons.fastfood,
    color: Color(0xFFFFE8A3),
    signals: [
      
      Signal(id: 201, title: "تفاح", urlImage: "images/signal_Images/signal_apple.jpg", urlImageMean: "images/signal_Images/apple.png", description: "التفاح حالي بس غالي ياغالي" ),
      Signal(id: 202, title: "برتقال", urlImage: "images/signal_Images/signal_apple.jpg", urlImageMean: "images/signal_Images/orange.png", description: "البرتقال حالي بس غالي ياغالي" ),
      Signal(id: 203, title: "بطيخ", urlImage: "images/signal_Images/signal_apple.jpg", urlImageMean: "images/signal_Images/watermelon.jpg", description: " البطيخ حالي بس غالي ياغالي" ),
      Signal(id: 204, title: "موز", urlImage: "images/signal_Images/signal_apple.jpg", urlImageMean: "images/signal_Images/banana.png", description: " الموز حالي بس غالي ياغالي" ),
      Signal(id: 205, title: "ليمون", urlImage: "images/signal_Images/signal_apple.jpg", urlImageMean: "images/signal_Images/lemon.png", description: " الليمون حالي بس غالي ياغالي" ), 
    ]
  ),
 const Category(
    id: 3,
    title: "عائلة",
    numberOf: 30,
    icon: Icons.family_restroom,
    color:  Color(0xFFB7E4C7),
    signals: [
      Signal(id: 301, title: "أب", urlImage: "images/logoApp.png",urlImageMean: "images/logoApp.png", description: "الأب في العائلة" ),
      Signal(id: 302, title: "أم", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الأم في العائلة" ),
      Signal(id: 303, title: "ابن" , urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الابن في العائلة" ),
      Signal(id: 304, title: "ابنة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الابنة في العائلة" ),
      Signal(id: 305, title: "جد", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الجد في العائلة" ),
      Signal(id: 306, title: "جدة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الجدة في العائلة" ),
      Signal(id: 307, title: "أخ", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الأخ في العائلة" ),
    ],
  ),
 const Category(
    id: 4,
    title: "مشاعر",
    numberOf: 25,
    icon: Icons.emoji_emotions,
    color:  Color(0xFFFFB6C1),
    signals: [
      Signal(id: 401, title: "سعادة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "السعادة في العائلة" ),
      Signal(id: 402, title: "حزن", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الحزن في العائلة" ),
      Signal(id: 403, title: "غضب", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الغضب في العائلة" ),
      Signal(id: 404, title: "خوف", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الخوف في العائلة" ),
      Signal(id: 405, title: "حب", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الحب في العائلة" ),
      Signal(id: 406, title: "كره", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الكره في العائلة" ),
      Signal(id: 407, title: "دهشة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الدهشة في العائلة" ),
    ],
  ),
 const Category(
    id: 5,
    title: "رياضة",
    numberOf: 20,
    icon: Icons.sports_soccer,
    color:   Color(0xFFFFB86B),
    signals: [
      Signal(id: 501, title: "كرة قدم", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "كرة القدم في الرياضة" ),
      Signal(id: 502, title: "كرة سلة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "كرة السلة في الرياضة" ),
      Signal(id: 503, title: "سباحة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "السباحة في الرياضة" ),
      Signal(id: 504, title: "تنس", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "التنس في الرياضة" ),
      Signal(id: 505, title: "جري", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الجري في الرياضة" ),
      Signal(id: 506, title: "ركوب دراجة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "ركوب الدراجة في الرياضة" ),
    ],
  ),
 const Category(
    id: 6,
    title: "أرقام",
    numberOf: 15,
    icon: Icons.format_list_numbered,
    color: Color(0xFFD8B4FE),
    signals: [
      Signal(id: 601, title: "واحد", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الواحد في الأرقام" ),
      Signal(id: 602, title: "اثنان", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الاثنان في الأرقام" ),
      Signal(id: 603, title: "ثلاثة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الثلاثة في الأرقام" ),
      Signal(id: 604, title: "أربعة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الأربعة في الأرقام" ),
      Signal(id: 605, title: "خمسة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الخمسة في الأرقام" ),
      Signal(id: 606, title: "ستة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الستة في الأرقام" ),
      Signal(id: 607, title: "سبعة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "السبعة في الأرقام" ),
    ],
  ),
 const Category(
    id: 7,
    title: "حيوانات",
    numberOf: 35,
    icon: Icons.pets,
    color:  Color(0xFFD7C4A5),
    signals: [
      Signal(id: 701, title: "قطة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "القطة في الحيوانات" ),
      Signal(id: 702, title: "كلب", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الكلب في الحيوانات" ),
      Signal(id: 703, title: "طائر", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الطائر في الحيوانات" ),
      Signal(id: 704, title: "سمكة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "السمكة في الحيوانات" ),
      Signal(id: 705, title: "حصان", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "الحصان في الحيوانات" ),
      Signal(id: 706, title: "بقرة", urlImage: "images/logoApp.png", urlImageMean: "images/logoApp.png", description: "البقرة في الحيوانات" ),
    ],
  ),
];
