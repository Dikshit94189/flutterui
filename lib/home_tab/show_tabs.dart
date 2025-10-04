 import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../permission_handler/permission_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

 class ShowsPage extends StatefulWidget {
   const ShowsPage({super.key});

   @override
   State<ShowsPage> createState() => _ShowsPageState();
 }

 class _ShowsPageState extends State<ShowsPage> {
   File? _imageFile;
   final ImagePicker _picker = ImagePicker();
   XFile? _webImage; // For web preview

   Future<void> _pickImage(ImageSource source) async {
     // 🔑 Request permission first
     bool granted = false;
     if (source == ImageSource.camera) {
       granted = await PermissionHelper.requestCameraPermission();
     } else {
       granted = await PermissionHelper.requestStoragePermission();
     }

     if (!granted) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text("${source == ImageSource.camera ? "Camera" : "Storage"} permission denied")),
       );
       return;
     }

     // Pick image
     final pickedFile = await _picker.pickImage(source: source);
     if (pickedFile != null) {
       setState(() {
         if (kIsWeb) {
           _webImage = pickedFile;
         } else {
           _imageFile = File(pickedFile.path);
         }
       });
     }
   }

   Future<void> _showPickOptionsDialog(BuildContext context) async {
     showDialog(
       context: context,
       barrierDismissible: true,
       builder: (context) {
         return SlideInDown(
           duration: const Duration(milliseconds: 400),
           child: Dialog(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16),
             ),
             child: SafeArea(
               child: Wrap(
                 children: [
                   ListTile(
                     leading: const Icon(Icons.camera_alt),
                     title: const Text("Camera"),
                     onTap: () {
                       Navigator.pop(context);
                       _pickImage(ImageSource.camera);
                     },
                   ),
                   ListTile(
                     leading: const Icon(Icons.photo),
                     title: const Text("Gallery"),
                     onTap: () {
                       Navigator.pop(context);
                       _pickImage(ImageSource.gallery);
                     },
                   ),
                 ],
               ),
             ),
           ),
         );
       },
     );
   }

   @override
   Widget build(BuildContext context) {
     Widget imageWidget;

     if (kIsWeb) {
       // Web
       if (_webImage != null) {
         imageWidget = Image.network(
           _webImage!.path,
           width: 150,
           height: 150,
           fit: BoxFit.cover,
         );
       } else {
         imageWidget = Container(
           width: 150,
           height: 150,
           color: Colors.grey.shade300,
           child: const Icon(Icons.person, size: 80, color: Colors.white70),
         );
       }
     } else {
       // Mobile
       if (_imageFile != null) {
         imageWidget = Image.file(
           _imageFile!,
           width: 150,
           height: 150,
           fit: BoxFit.cover,
         );
       } else {
         imageWidget = Container(
           width: 150,
           height: 150,
           color: Colors.grey.shade300,
           child: const Icon(Icons.person, size: 80, color: Colors.white70),
         );
       }
     }

     return Center(
       child: Stack(
         alignment: Alignment.bottomRight,
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(80),
             child: imageWidget,
           ),
           Positioned(
             right: 0,
             bottom: 0,
             child: IconButton(
               onPressed: () => _showPickOptionsDialog(context),
               icon: const Icon(Icons.add_a_photo, color: Colors.blue),
             ),
           ),
         ],
       ),
     );
   }
 }