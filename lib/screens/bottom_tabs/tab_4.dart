import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

import '../../permission_handler/permission_helper.dart';
import '../../utils/responsive.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../utils/responsive.dart';

class BottomTab4 extends StatefulWidget {
  const BottomTab4({super.key});

  @override
  State<BottomTab4> createState() => _BottomTab4State();
}

class _BottomTab4State extends State<BottomTab4> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final Box box = Hive.box("LocalStorage");

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  XFile? _webImage; // For web preview

  Future<void> _pickImage(ImageSource source) async {
    bool granted = false;

    if (source == ImageSource.camera) {
      granted = await PermissionHelper.requestCameraPermission();
    } else {
      granted = await PermissionHelper.requestStoragePermission();
    }

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${source == ImageSource.camera ? "Camera" : "Storage"} permission denied",
          ),
        ),
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
                  // ✅ On mobile show Camera + Gallery
                  // ✅ On web show only Gallery
                  if (!kIsWeb) ...[
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text("Camera"),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ],
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

  /// Save the text directly to Hive (local storage)
  void saveText() {
    final value = nameController.text.trim();
    if (value.isNotEmpty) {
      box.put('nameSaveHere', value);
      nameController.clear(); // clear the text field
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget imageWidget;

    if (kIsWeb) {
      // Web preview
      final double imgWidth = Responsive(context).width(80, tablet: 250, desktop: 300);
      final double imgHeight = Responsive(context).height(80, tablet: 250, desktop: 300);

      if (_webImage != null) {
        imageWidget = Image.network(
          _webImage!.path,
          width: imgWidth,
          height: imgHeight,
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = Container(
          width: imgWidth,
          height: imgHeight,
          color: Colors.grey.shade300,
          child: Icon(
            Icons.person,
            size: Responsive(context).iconSize(80, tablet: 120, desktop: 150),
            color: Colors.white70,
          ),
        );
      }
    } else {
      // Mobile preview
      final double imgWidth = Responsive(context).width(80, tablet: 250, desktop: 300);
      final double imgHeight = Responsive(context).height(80, tablet: 250, desktop: 300);

      if (_imageFile != null) {
        imageWidget = Image.file(
          _imageFile!,
          width: imgWidth,
          height: imgHeight,
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = Container(
          width: imgWidth,
          height: imgHeight,
          color: Colors.grey.shade300,
          child: Icon(
            Icons.person,
            size: Responsive(context).iconSize(80, tablet: 120, desktop: 150),
            color: Colors.white70,
          ),
        );
      }
    }


    return SafeArea(
      child: Padding(
        padding: Responsive(context).symmetric(
          16, 12, // mobile horizontal & vertical
          tabletH: 24, tabletV: 20,
          desktopH: 40, desktopV: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Column(
              children: [
         Padding(
        padding: Responsive(context).padding(
          12,      // mobile
          tablet: 24,
          desktop: 32,
        ),
        child: Stack(
          alignment: Alignment.topLeft, // optional, can be topLeft
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                Responsive(context).heights(80),
              ), // responsive border radius
              child: SizedBox(
                width: Responsive(context).width(150, tablet: 250, desktop: 300),
                height: Responsive(context).height(150, tablet: 250, desktop: 300),
                child: imageWidget,
              ),
            ),
            Positioned(
              left: Responsive(context).width(8, tablet: 16, desktop: 20), // move to left
              top: Responsive(context).height(8, tablet: 16, desktop: 20), // move to top
              child: IconButton(
                onPressed: () => _showPickOptionsDialog(context),
                icon: Icon(
                  Icons.add_a_photo,
                  color: Colors.blue,
                  size: Responsive(context).iconSize(24, tablet: 32, desktop: 40),
                ),
              ),
            ),
          ],
        ),
      ),
              ],
            ),
            // Listen to Hive changes and automatically update UI
            ValueListenableBuilder(
              valueListenable: box.listenable(keys: ['nameSaveHere']),
              builder: (context, Box value, _) {
                final nameSaved = value.get('nameSaveHere', defaultValue: '') ?? '';
                return Text(
                  "Name Text: $nameSaved",
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),

            SizedBox(
              height: Responsive(context).heights(12, tablet: 20, desktop: 32),
            ),

            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Save Name Here",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name cannot be empty";
                  }
                  if (value.trim().length < 3) {
                    return "Name must be at least 3 characters";
                  }
                  return null;
                },
              ),
            ),

            SizedBox(
              height: Responsive(context).heights(12, tablet: 20, desktop: 32),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    saveText(); // saves to Hive without setState
                  }
                },
                child: const Text(
                  "Save Text",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

