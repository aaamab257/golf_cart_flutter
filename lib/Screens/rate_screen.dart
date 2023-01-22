// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'package:flutter/material.dart';

// class RateScreen extends StatefulWidget {
  

//   @override
//   State<RateScreen> createState() => _RateScreenState();
// }

// class _RateScreenState extends State<RateScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return buildAppScaffold(
//       context,
//       SafeArea(
//           child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 30),
//             child: Text(getTripStatusDescription(trip.activeTrip!.status),
//                 style: Theme.of(context).textTheme.headline5),
//           ),
//           Lottie.asset('assets/lottie/taxi-driver.json'),
//           Text('Rate your trip', style: Theme.of(context).textTheme.subtitle1),
//           RatingBar.builder(
//             initialRating: 3,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: true,
//             itemCount: 5,
//             itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//             itemBuilder: (context, _) => const Icon(
//               Icons.star,
//               color: Colors.amber,
//             ),
//             onRatingUpdate: (rating) {},
//           ),
//           // tripFromTo(context, trip.activeTrip!),
//           Expanded(
//             child: Container(),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             child: ElevatedButton(
//                 style: ThemeProvider.of(context).roundButtonStyle,
//                 onPressed: () => trip.deactivateTrip(),
//                 child: const Text('Close')),
//           )
//         ],
//       )));
//   }
// }
