// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Theme extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Theme',
//         ),
//       ),
//       body: Consumer(
//         builder: (ctx, provider, __){
//           return SwitchListTile.adaptive(
//             value: isDarkMode,
//             onChanged: (value) {
//               isDarkMode = value;
//             }
//           );
//         },
//       ),
//     );
//   }
// }