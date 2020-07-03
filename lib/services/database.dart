import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gofixit_demo_one/model/FixerModel.dart';
import 'package:gofixit_demo_one/model/ServiceOrderModel.dart';
import 'package:gofixit_demo_one/model/UserModel.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference userData =
      Firestore.instance.collection('userDetails');

  final CollectionReference serviceOrder =
      Firestore.instance.collection('serviceOrders');

  Future saveServiceOrders(
    String serviceOrdered,
    String address,
    String description,
    dynamic imageUrl,
  ) async {
    return await serviceOrder.document(uid).setData({
      'serviceOrdered': serviceOrdered,
      'address': address,
      'description': description,
      'imageUrl': imageUrl
    });
  }

  Future updateUserDetails(
      String username,String email,String phone, String gender, int strength) async {
    return await userData.document(uid).setData({
      'username': username,
      'email':email,
      'phone': phone,
      'gender': gender,
      'strength': strength
    });
  }

  List<FixerModel> _fixersList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return FixerModel(
          username: doc.data['username'] ?? '',
          email:doc.data['email'] ?? '',
          phone: doc.data['phone'] ?? '0',
          gender: doc.data['gender'] ?? '',
          strength: doc.data['strength']);
    }).toList();
  }

  List<ServiceOrderModel> historyList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return ServiceOrderModel(
        serviceOrdered:doc.data['serviceOrdered'],
        imageUrl:doc.data['imageUrl'],
        description:doc.data['description'],
        address:doc.data['address']
      );
    }).toList();
  }


  UserDataModel _currentUser(DocumentSnapshot snapshot) {
    return UserDataModel(
        uid: uid,
        username: snapshot.data['username'],
        email:snapshot.data['email'],
        phone: snapshot.data['phone'],
        gender: snapshot.data['gender'],
        strength: snapshot.data['strength']);
  }

  Stream<List<FixerModel>> get userDetails {
    return userData.snapshots().map(_fixersList);
  }

  Stream<List<ServiceOrderModel>> get history{
    return serviceOrder.snapshots().map(historyList);
  }

  // stream to get current user details
  Stream<UserDataModel> get currentUserData {
    return userData.document(uid).snapshots().map(_currentUser);
  }
}
