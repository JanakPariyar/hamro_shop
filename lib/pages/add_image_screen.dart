// // add_image_screen.dart
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:hive/hive.dart';
//
// import '../models/image_model.dart';
//
// class AddImageScreen extends StatefulWidget {
//   @override
//   _AddImageScreenState createState() => _AddImageScreenState();
// }
//
// class _AddImageScreenState extends State<AddImageScreen> {
//   final ImagePicker _imagePicker = ImagePicker();
//   File? _imageFile;
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final imagePickerResult = await _imagePicker.pickImage(source: source);
//
//       if (imagePickerResult != null) {
//         setState(() {
//           _imageFile = File(imagePickerResult.path);
//         });
//       }
//     } catch (e) {
//       // Handle exceptions (e.g., canceled picker, permission issues)
//       print('Error picking image: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking image')),
//       );
//     }
//   }
//
//   Future<void> _addImage() async {
//     try {
//       if (_imageFile == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please pick an image first')),
//         );
//         return;
//       }
//
//       final imagesBox = Hive.box<ImageModel>('images');
//       final newImage = ImageModel()..imageFile = _imageFile!;
//       imagesBox.add(newImage);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Image added successfully')),
//       );
//     } catch (e) {
//       // Handle exceptions (e.g., writing to Hive, other issues)
//       print('Error adding image: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error adding image')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Image'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () => _pickImage(ImageSource.gallery),
//               child: Text('Pick Image from Gallery'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () => _pickImage(ImageSource.camera),
//               child: Text('Capture Image from Camera'),
//             ),
//             SizedBox(height: 16.0),
//             if (_imageFile != null)
//               Image.file(
//                 _imageFile!,
//                 height: 100.0,
//                 width: 100.0,
//                 fit: BoxFit.cover,
//               ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _addImage,
//               child: Text('Add Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
