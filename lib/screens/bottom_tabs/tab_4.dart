import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../local_storage/hive_storage.dart';
import '../../permission_handler/permission_helper.dart';
import '../../utils/responsive.dart';
import '../mode_tracker.dart';

class BottomTab4 extends StatefulWidget {
  const BottomTab4({super.key});

  @override
  State<BottomTab4> createState() => _BottomTab4State();
}

class _BottomTab4State extends State<BottomTab4> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  StorageHelper? storageHelper;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  XFile? _webImage;

  String? selectedMood;
  Color? selectedColor;
  final box = Hive.box('LocalStorage');

  @override
  void initState() {
    super.initState();
    _initStorage();
    nameController.text = box.get('name', defaultValue: '') ?? '';
    selectedMood = box.get('mood');
  }

  void saveText(){
    if(_formKey.currentState!.validate()){
      box.put('name', nameController.text.trim());
      if(selectedMood != null) box.put('mood', selectedMood);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved successfully!")));
      setState(() {});
    }
  }

  Future<void> _openMoodTracker() async{
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => const ModeTracker()),
    );
    if (result != null) {
      setState(() {
        selectedMood = result['mood'];
        selectedColor = result['color'];
      });
    }
  }

  Future<void> _initStorage() async {
    storageHelper = await StorageHelper.getInstance();

    if (!kIsWeb) {
      final savedPath = storageHelper!.getImagePath();
      if (savedPath != null) {
        _imageFile = File(savedPath);
      }
    }

    setState(() {});
  }

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

    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (kIsWeb) {
        setState(() => _webImage = pickedFile);
      } else {
        final savedPath = await storageHelper!.saveImageLocally(File(pickedFile.path));
        if (savedPath != null) {
          setState(() => _imageFile = File(savedPath));
        }
      }
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
                  if (!kIsWeb)
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

  void saveText() {
    final value = nameController.text.trim();
    if (value.isNotEmpty) {
      storageHelper?.setName(value);
      nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    final double imgWidth = Responsive(context).width(80, tablet: 250, desktop: 300);
    final double imgHeight = Responsive(context).height(80, tablet: 250, desktop: 300);

    if (kIsWeb) {
      imageWidget = _webImage != null
          ? Image.network(_webImage!.path, width: imgWidth, height: imgHeight, fit: BoxFit.cover)
          : Container(
        width: imgWidth,
        height: imgHeight,
        color: Colors.grey.shade300,
        child: Icon(Icons.person, size: Responsive(context).iconSize(80, tablet: 120, desktop: 150), color: Colors.white70),
      );
    } else {
      imageWidget = _imageFile != null
          ? Image.file(_imageFile!, width: imgWidth, height: imgHeight, fit: BoxFit.cover)
          : Container(
        width: imgWidth,
        height: imgHeight,
        color: Colors.grey.shade300,
        child: Icon(Icons.person, size: Responsive(context).iconSize(80, tablet: 120, desktop: 150), color: Colors.white70),
      );
    }

    return SafeArea(
      child: Padding(
        padding: Responsive(context).symmetric(16, 12, tabletH: 24, tabletV: 20, desktopH: 40, desktopV: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: Responsive(context).padding(12, tablet: 24, desktop: 32),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Responsive(context).heights(80)),
                    child: SizedBox(
                      width: Responsive(context).width(150, tablet: 250, desktop: 300),
                      height: Responsive(context).height(150, tablet: 250, desktop: 300),
                      child: imageWidget,
                    ),
                  ),
                  Positioned(
                    left: Responsive(context).width(8, tablet: 16, desktop: 20),
                    top: Responsive(context).height(8, tablet: 16, desktop: 20),
                    child: IconButton(
                      onPressed: () => _showPickOptionsDialog(context),
                      icon: Icon(Icons.add_a_photo, color: Colors.blue, size: Responsive(context).iconSize(24, tablet: 32, desktop: 40)),
                    ),
                  ),
                ],
              ),
            ),

            // Hive + image name display
            if (storageHelper != null)
              ValueListenableBuilder(
                valueListenable: storageHelper!.listenable(),
                builder: (context, Box box, _) {
                  final nameSaved = storageHelper!.getName();
                  return Text("Name Text: $nameSaved", style: const TextStyle(fontSize: 18));
                },
              ),

            SizedBox(height: Responsive(context).heights(12, tablet: 20, desktop: 32)),

            Form(
              key: _formKey,
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Save Name Here", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return "Name cannot be empty";
                  if (value.trim().length < 3) return "Name must be at least 3 characters";
                  return null;
                },
              ),
            ),

            SizedBox(height: Responsive(context).heights(12, tablet: 20, desktop: 32)),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) saveText();
                },
                child: const Text("Save Text", style: TextStyle(color: Colors.black)),
              ),
            ),
            
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => ModeTracker()));
              }
                  , child: Text("Open Mode Tracker")),
            )
            
            
            
            
            
          ],
        ),
      ),
    );
  }
}
