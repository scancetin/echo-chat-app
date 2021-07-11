// import 'package:flutter/material.dart';

// class SearchWidget extends StatelessWidget {
//   const SearchWidget({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//                 children: [
//                   Expanded(
//                       child: TextField(
//                     decoration: InputDecoration(hintText: "Search User", contentPadding: EdgeInsets.only(left: 5)),
//                     controller: _searchController,
//                   )),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _searchingWord = _searchController.text;
//                       });
//                     },
//                     child: Container(
//                       width: 45,
//                       height: 45,
//                       margin: EdgeInsets.only(left: 20),
//                       decoration: BoxDecoration(color: Color(0xff5eedcb), shape: BoxShape.circle),
//                       child: Icon(Icons.search, color: Colors.blueGrey[700], size: 23),
//                     ),
//                   ),
//                 ],
//               ),
//   }
// }
