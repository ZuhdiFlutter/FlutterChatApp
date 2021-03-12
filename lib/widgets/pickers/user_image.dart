import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File pickedImage;
  void _pickImage() async {
    final snapImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(snapImage.path);
    setState(() {
      pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: pickedImage != null ? FileImage(pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          label: Text('add image'),
          icon: Icon(Icons.image),
          textColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
