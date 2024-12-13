// import 'package:flutter/material.dart';
// import 'package:pet_adoption/main.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// class Petdetails extends StatefulWidget {
//   late final int id;
//   // ignore: prefer_const_constructors_in_immutables
//   Petdetails({super.key, required this.id});
//
//   @override
//   State<Petdetails> createState() => _PetdetailsState();
// }
//
// class _PetdetailsState extends State<Petdetails> {
//   Widget card(String label, String value) {
//     return Expanded(
//         child: ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Container(
//               color: const Color.fromARGB(255, 194, 233, 106),
//               height: 60,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     label,
//                     style:
//                         const TextStyle(color: Color.fromARGB(125, 8, 9, 10)),
//                   ),
//                   Text(
//                     value,
//                     style: const TextStyle(
//                         color: Color.fromARGB(255, 8, 9, 10),
//                         fontWeight: FontWeight.w600),
//                   )
//                 ],
//               ),
//             )));
//   }
//
//   // ignore: non_constant_identifier_names
//   Widget ContinueButton() {
//     return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(7),
//           child: Container(
//             width: double.infinity,
//             color: const Color.fromARGB(255, 194, 233, 106),
//             child: TextButton(
//               onPressed: () {
//                 Alert(
//                   context: context,
//                   type: AlertType.info,
//                   title: "Owner Information",
//                   desc: "Email: ${getPetById(widget.id)?.owner.emailAddress} Phone Number: ${getPetById(widget.id)?.owner.phonenumber}",
//                   buttons: [
//                     DialogButton(
//                       onPressed: () => Navigator.pop(context),
//                       width: 120,
//                       child: const Text(
//                         "Done",
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     )
//                   ],
//                 ).show();
//               },
//               child: const Text(
//                 "Adopt me",
//                 style: TextStyle(
//                     fontSize: 18, color: Color.fromARGB(255, 38, 92, 63)),
//               ),
//             ),
//           ),
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var pet = getPetById(widget.id);
//
//     return Scaffold(
//       body: SafeArea(
//           child: Container(
//         color: const Color.fromARGB(255, 255, 255, 255),
//         child: ListView(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Color.fromARGB(255, 8, 9, 10),
//                     ))
//               ],
//             ),
//             Image(
//               image: AssetImage(pet!.imageUrl[0]),
//               height: 300,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Center(
//               child: Text(
//                 pet.name,
//                 style: const TextStyle(
//                     fontSize: 32, color: Color.fromARGB(255, 8, 9, 10)),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Row(
//                 children: [
//                   card("Age", pet.age),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   card("Breed", pet.breed),
//                   const SizedBox(
//                     width: 6,
//                   ),
//                   card("Health Status", pet.healthStatus)
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   for (var element in pet.personalityTraits)
//                     Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Text(
//                         element,
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//               child: Text(
//                 pet.about,
//                 style: const TextStyle(fontSize: 16),
//               ),
//             ),
//             ContinueButton()
//           ],
//         ),
//       )),
//     );
//   }
// }
