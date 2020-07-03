import 'package:flutter/material.dart';
import 'package:gofixit_demo_one/model/FixerModel.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';
import 'package:gofixit_demo_one/resusable_components/historyTiles.dart';
import 'package:gofixit_demo_one/resusable_components/listing.dart';
import 'package:gofixit_demo_one/screens/wrapper.dart';
import 'package:gofixit_demo_one/services/auth.dart';
import 'package:gofixit_demo_one/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  // final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: SettingsForm(),
            );
          });
    }

    // final userAuth = Provider.of<UserModel>(context);
    return  StreamProvider<List<FixerModel>>.value(
        value: DatabaseService().userDetails,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(
              Icons.local_drink,
            ),
            title: Text('TestPage'),
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () => _showSettingsPanel(),
              )
            ],
          ),
          body: Container(
            child: FixItList(),
            // child:HistoryList(),
          ),
        ),
      );
  }
}

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];

  // form vlaues
  String _currentUserame;
  String _currentPhone;
  String _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserDataModel>(
      stream: DatabaseService(uid: user.userId).currentUserData,
      builder: (context,snapshot){
        UserDataModel currentUser = snapshot.data;
        return Form(
        key:_formKey,
        child:ListView(
          
          children:[
            Center(child:  Text('Update details')),
            TextFormField(
              initialValue:currentUser.username,
              enabled: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText:currentUser.username,
              ),
              validator: (val) =>
                  val.isEmpty ? 'Enter a email ' : null,
              onChanged: (val) {
                setState(() => _currentUserame = val);
              },
            ),
            TextFormField(
              decoration:  InputDecoration(
                hintText: "User name",
              ),
              validator: (val)=>val.isEmpty ? 'field is empty ':null,
              onChanged:(val){
                setState(()=>_currentUserame=val);
              },
            ),
            TextFormField(
              decoration:  InputDecoration(
                hintText: "User name",
              ),
              validator: (val)=>val.isEmpty ? 'field is empty ':null,
              onChanged:(val){
                setState(()=>_currentUserame=val);
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child:RaisedButton(
                onPressed:null,
                child: Text('update'),
              ),
            )
          ]
        )
      );
      }
    );
  }
}
