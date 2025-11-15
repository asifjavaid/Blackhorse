// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';

// class SearchableActiveIngredientDropdown extends StatelessWidget {
//   final String selectedValue;
//   final ValueChanged<String?> onChange;

//   const SearchableActiveIngredientDropdown({
//     super.key,
//     required this.selectedValue,
//     required this.onChange,
//   });

//   // This function simulates asynchronous data fetching/filtering.
//   // In a real use-case, you may call an API (using Dio or http) and filter based on [filter].
//   Future<List<String>> fetchIngredients(String filter) async {
//     // A hard-coded large list of active ingredients for demonstration.
//     final allIngredients = <String>[
//       'Ibuprofen',
//       'Acetaminophen',
//       'Naproxen',
//       'Aspirin',
//       'Diclofenac',
//       'Ketorolac',
//       'Celecoxib',
//       'Indomethacin',
//       'Meloxicam'
//       // ... add more if needed.
//     ];

//     // Simulate network delay.
//     await Future.delayed(const Duration(milliseconds: 300));

//     if (filter.isNotEmpty) {
//       return allIngredients.where((ingredient) => ingredient.toLowerCase().contains(filter.toLowerCase())).toList();
//     }
//     return allIngredients;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<String>(
//       // If the selected value is an empty string, no item is pre-selected.
//       selectedItem: selectedValue.isNotEmpty ? selectedValue : null,
//       decoratorProps: const DropDownDecoratorProps(
//           // labelText: "Active Ingredient",
//           // border: OutlineInputBorder(),
//           ),
//       // The onFind callback is used for asynchronous fetching/filtering.
//       items: (String? filter, LoadProps? loadProps) => fetchIngredients(filter ?? ""),
//       onChanged: onChange,
//       popupProps: const PopupProps.menu(
//         showSearchBox: true,
//         // You may customize the popup further (e.g., constraints, search field style)
//       ),
//       validator: (v) => (v == null || v.isEmpty) ? 'Please select an ingredient' : null,
//     );
//   }
// }
