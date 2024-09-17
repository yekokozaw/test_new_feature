import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
   const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  Future selectImage() async{
    ImagePicker imagePicker = ImagePicker();
    // Create an instance of ImagePicker
    if(!kIsWeb){
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        File? selected = File(file.path);
        selected = await _cropImage(imageFile: selected);
        setState(() {
          _pickedImage = selected;
        });
      }
    }else if(kIsWeb){
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if(file != null){
        File? selected = File(file.path);
        selected = await _cropImage(imageFile: selected);
        var f = await selected!.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      }else{
        print('No image has been picked');
      }
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path,uiSettings: [
      WebUiSettings(
        context: context,
      ),
    ]);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ///Image Pick from Gallery
              Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child : (_pickedImage == null)
                        ? const SizedBox(height: 10)
                        : ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: kIsWeb
                            ? Image.memory(webImage,fit: BoxFit.fill,width: 200,height: 200)
                            : Image.file(_pickedImage!,fit: BoxFit.fill,width: 300,height: 400)
                    )
                ),
              ),
              IconButton(onPressed: (){
                selectImage();
              }, icon: const Icon(Icons.add_a_photo))
            ],
          ),
        ),
      ),
    );
  }
}
