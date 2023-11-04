// import 'package:flutter/material.dart';
// import 'package:idea_tuition_managment_app/utils/routes/routes.dart';
//
// class TeacherNotFoundDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return AlertDialog(
//     //   title: Text("No Teachers Found"),
//     //   content: Text("There are no teachers against this email"),
//     //   actions: <Widget>[
//     //     MaterialButton(
//     //       child: Text("OK"),
//     //       onPressed: () {
//     //         //Navigator.pop(context); // Close the dialog
//     //         Navigator.pushNamed(context, Routes.teacherForm);
//     //       },
//     //     ),
//     //   ],
//     // );
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("Alert Title"),
//           content: new SingleChildScrollView(
//             child: Container(),),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text("Close"),
//               onPressed: () {
//               },
//             ),
//           ],
//         )
//       },
//     );
//   }
// }