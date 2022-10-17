import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
   const UserImagePicker({Key? key, required this.pickedImagePass}) : super(key: key);

   final void Function(File image) pickedImagePass;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  final ImagePicker _picker = ImagePicker();
  late  File _pickedImage = File('');

  Future <void> _pickImage() async{
    final imageSelected = await _picker.pickImage(
        source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if(imageSelected == null){
      return;
    }
    setState(() {
      _pickedImage = File(imageSelected.path);
    });
    widget.pickedImagePass(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
         backgroundImage: _pickedImage.isAbsolute ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(
              Icons.image
            ),
        label: const Text('Add Image'),
        ),
      ],
    );
  }
}
