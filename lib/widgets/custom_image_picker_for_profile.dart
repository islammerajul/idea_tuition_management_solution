import 'dart:io';

import 'package:flutter/material.dart';
import 'package:idea_tuition_managment_app/constants/colors.dart';
import 'package:image_picker/image_picker.dart';


class CustomImagePickerForProfile extends StatefulWidget {
  const CustomImagePickerForProfile({super.key});

  @override
  State<CustomImagePickerForProfile> createState() =>
      _CustomImagePickerForProfileState();
}

class _CustomImagePickerForProfileState
    extends State<CustomImagePickerForProfile> {

  final TextEditingController _imagePathController = TextEditingController();
  File? imageFile;

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            // <-- SEE HERE
            title: const Text('Select a way for upload'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  _getFromGallery();
                  Navigator.of(context).pop();
                },
                child: const Text('Gallery'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  _getFromCamera();
                  Navigator.of(context).pop();
                },
                child: const Text('Camera'),
              ),
            ],
          );
        });
  }

  _getFromGallery() async {
    // PickedFile? pickedFile = await ImagePicker()
    //     .getImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _imagePathController.text = pickedFile.path;
      });
    }
  }

  _getFromCamera() async {
    // PickedFile? pickedFile = await ImagePicker()
    //     .getImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _imagePathController.text = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageFile == null
            ? Container(
                height: 106,
                width: 106,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                      image: AssetImage(
                    "assets/man.png",
                  )),
                ),
              )
            : ClipOval(
                child: Image.file(
                imageFile!,
                height: 106,
                width: 106,
                fit: BoxFit.cover,
              )),
        Positioned(
          top: 65,
          right: 0,
          child: InkWell(
            onTap: () {
              _showSimpleDialog();
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: CustomColors.White),
                  borderRadius: BorderRadius.circular(500),
                  color: CustomColors.PrimaryColor),
              child: Icon(
                Icons.edit,
                size: 18,
                color: CustomColors.White,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
