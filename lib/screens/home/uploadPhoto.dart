import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File imagefile;
  _openGallery(BuildContext context) async {
    var pic = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imagefile = pic;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var pic = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imagefile = pic;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Pick from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imagefile == null) {
      return Text('No image selected');
    } else {
      return Image.file(
        imagefile,
        width: 400.0,
        height: 400,
      );
    }
  }

  Future<void> upload() async {
    final StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child(new DateTime.now().millisecondsSinceEpoch.toString() +
            "." +
            imagefile.path);

    StorageUploadTask uploadTask = storageReference.putFile(imagefile);
    
    StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      print('EVENT ${event.type}');
    });
    await uploadTask.onComplete;
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image uploader"),
      ),
      body: SafeArea(
          child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text("No Image Selected"),
              _decideImageView(),
              RaisedButton(
                onPressed: () {
                  _showChoiceDialogue(context);
                },
                child: Text("Select Image"),
              ),
              RaisedButton(
                onPressed: () {
                  if (imagefile == null) {
                    Fluttertoast.showToast(
                        msg: 'Please Select an image',
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 2);
                  } else {
                    upload();
                  }
                },
                child: Text("upload Image"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
