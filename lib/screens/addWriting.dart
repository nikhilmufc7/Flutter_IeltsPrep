// import 'package:flutter/material.dart';
// import 'package:ielts/models/speaking.dart';
// import 'package:ielts/viewModels/speakingCrudModel.dart';
// import 'package:provider/provider.dart';

// class AddWriting extends StatefulWidget {
//   @override
//   _AddWritingState createState() => _AddWritingState();
// }

// class _AddWritingState extends State<AddWriting> {
//   final _formKey = GlobalKey<FormState>();
//   String title;
//   String level;
//   double indicatorValue;
//   List thingsToSpeak;
//   List vocabulary;
//   String answer;

//   @override
//   Widget build(BuildContext context) {
//     var lessonsProvider = Provider.of<SpeakingCrudModel>(context);
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: EdgeInsets.all(12),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: <Widget>[
//               TextFormField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Reading Title',
//                     fillColor: Colors.grey[300],
//                     filled: false,
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter Reading Title';
//                     }
//                   },
//                   onSaved: (value) => title = value),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Reading Level',
//                     fillColor: Colors.grey[300],
//                     filled: false,
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter Level ';
//                     }
//                   },
//                   onSaved: (value) => level = value),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                   keyboardType: TextInputType.numberWithOptions(),
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Indicator Value',
//                     fillColor: Colors.grey[300],
//                     filled: false,
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter The price';
//                     }
//                   },
//                   onSaved: (value) => indicatorValue = double.parse(value)),
//               TextFormField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Reading Question',
//                     fillColor: Colors.grey[300],
//                     filled: false,
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter Level ';
//                     }
//                   },
//                   onSaved: (value) => question = value),
//               TextFormField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Reading Answer',
//                     fillColor: Colors.grey[300],
//                     filled: false,
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter Level ';
//                     }
//                   },
//                   onSaved: (value) => answer = value),
//               TextFormField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Reading image',
//                     fillColor: Colors.grey[300],
//                     filled: false,
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter Level ';
//                     }
//                   },
//                   onSaved: (value) => image = value),
//               RaisedButton(
//                 splashColor: Colors.red,
//                 onPressed: () async {
//                   if (_formKey.currentState.validate()) {
//                     _formKey.currentState.save();
//                     await lessonsProvider.addSpeaking(Speaking(
//                         title: title,
//                         level: level,
//                         indicatorValue: indicatorValue,
//                         question: question,
//                         answer: answer,
//                         image: image));
//                     Navigator.pop(context);
//                   }
//                 },
//                 child:
//                     Text('add Product', style: TextStyle(color: Colors.white)),
//                 color: Colors.blue,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
