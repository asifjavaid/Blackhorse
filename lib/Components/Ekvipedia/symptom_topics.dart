// import 'package:ekvi/Components/Ekvipedia/flat_news_card.dart';
// import 'package:flutter/material.dart';

// final List<Map<String, String>> newsData = [
//   {
//     'imagePath': 'assets/images/flat_news_card.svg',
//     'date': 'Jan 23',
//     'readTime': '7 minutes',
//     'title': 'User read: Una’s Road to Diagnosis',
//   },
//   {
//     'imagePath': 'assets/images/flat_news_card.svg',
//     'date': 'Jan 24',
//     'readTime': '5 minutes',
//     'title': 'Breaking: New Advances in Medicine',
//   },
//   {
//     'imagePath': 'assets/images/flat_news_card.svg',
//     'date': 'Jan 25',
//     'readTime': '6 minutes',
//     'title': 'The Future of Healthcare in 2024',
//   },
//   {
//     'imagePath': 'assets/images/flat_news_card.svg',
//     'date': 'Jan 25',
//     'readTime': '6 minutes',
//     'title': 'The Future of Healthcare in 2024',
//   },
//   {
//     'imagePath': 'assets/images/flat_news_card.svg',
//     'date': 'Jan 25',
//     'readTime': '6 minutes',
//     'title': 'The Future of Healthcare in 2024',
//   },
// ];

// class SymptomTopicsTopics extends StatelessWidget {
//   const SymptomTopicsTopics({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Symptom Topics", style: textTheme.displaySmall),
//           Column(
//             children: newsData.map((newsItem) {
//               return FlatNewsCard(
//                 imagePath: newsItem['imagePath']!,
//                 date: newsItem['date']!,
//                 readTime: newsItem['readTime']!,
//                 title: newsItem['title']!,
//                 onPressed: () {},
//               );
//             }).toList(),
//           )
//         ],
//       ),
//     );
//   }
// }
