import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gofixit_demo_one/screens/home/serviceRequestSuccess.dart';
import 'package:gofixit_demo_one/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';

class RequestService extends StatefulWidget {
  final String service;

  RequestService({this.service});
  @override
  _RequestServiceState createState() => _RequestServiceState(service: service);
}

class _RequestServiceState extends State<RequestService> {
  String service;
  _RequestServiceState({this.service});
  final _formKey = GlobalKey<FormState>();
  String serviceOrdered = '';
  String address = '';
  dynamic imageUrl;
  String description = '';
  String email = '';
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
        width: 200.0,
        height: 200.0,
      );
    }
  }

  String uploadEventStats = 'Please wait...';
  Future<void> upload() async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images').child(imagefile.path);

    StorageUploadTask uploadTask = storageReference.putFile(imagefile);

    StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.
      setState(() {
        uploadEventStats = event.type.toString();
      });
      print('EVENT ${event.type}');
    });
    await uploadTask.onComplete;
    setState(() {
      imageUrl = storageReference.toString();
    });
    streamSubscription.cancel();
  }

  void _uploadStatusPanel() {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: SettingsForm(stats: uploadEventStats),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Service Request",
            style: TextStyle(color: Colors.black, fontSize: 30.0)),
        elevation: 0.0,
        // backgroundColor:Color(0xFF263238),
        backgroundColor: Color(0xFFf3f4f4),
      ),
      body: SafeArea(
          child: Row(children: [
        Expanded(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 16.0),
                      child: ListView(
                        children: [
                          SizedBox(height: 50.0),
                          Text("Service required",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                            initialValue: service,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: widget.service,
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter a email ' : null,
                            onChanged: (val) {
                              setState(() => serviceOrdered = val);
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Address",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Address",
                            ),
                            validator: (val) => val.isEmpty ? 'required' : null,
                            onChanged: (val) {
                              setState(() => address = val);
                            },
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text("Service Description",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextFormField(
                            maxLines: 2,
                            decoration: InputDecoration(
                              hintText: "",
                            ),
                            validator: (val) => val.isEmpty ? 'required' : null,
                            onChanged: (val) {
                              setState(() => description = val);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text("Add a photo",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              GestureDetector(
                                child: Container(
                                      color: Colors.grey,
                                      width:50.0,
                                      height: 50.0,
                                      child: Center(
                                        child: IconButton(
                                            icon: Icon(Icons.photo),
                                            onPressed: null),
                                      ),
                                    ),
                                  onTap: () {
                                    _showChoiceDialogue(context);
                                  }),
                            ],
                          ),
                          _decideImageView(),
                          SizedBox(
                            height: 40.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                if (_formKey.currentState.validate()) {
                                  dynamic result =
                                      await DatabaseService(uid: user.userId)
                                          .saveServiceOrders(service, address,
                                              description, imageUrl);
                                  if (imagefile == null) {
                                    Fluttertoast.showToast(
                                        msg: 'Please Select an image',
                                        gravity: ToastGravity.TOP,
                                        toastLength: Toast.LENGTH_LONG,
                                        timeInSecForIosWeb: 2);
                                  } else {
                                    upload();
                                    _uploadStatusPanel();
                                    await Future.delayed(
                                        Duration(seconds: 5), () {
                                      // deleayed code here
                                      print('delayed execution');
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServiceReqSuccess()));
                                  }
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Container(
                              child: Center(
                                  child: Text(
                                'Book now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              )),
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.4),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF3366FF),
                                      const Color(0xFF00CCFF),
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ])),
    );
  }
}

class SettingsForm extends StatefulWidget {
  SettingsForm({this.stats});
  final String stats;
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: Row(
        children: [
          Text(
            "Please wait...",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(width:10.0,),
          SpinKitCircle(
            color: Colors.orange,
            size: 30,
          ),
        ],
      ),
    );
  }
}
