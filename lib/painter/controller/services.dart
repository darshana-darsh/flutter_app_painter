import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/painter/model/CustomerModel.dart';

class Services {
  CollectionReference painterRef = Firestore.instance.collection("painter");
  Stream<Iterable<CustomerModel>> findAll(userId) {
    return painterRef
        .where("user_id", isEqualTo: userId)
        .getDocuments()
        .then((value) {
      return value.documents.map((e) => CustomerModel.fromSnapshot(e)).toList();
    }).asStream();
  }

  Future<CustomerModel> findOne(String id) async {
    var result = await painterRef.document(id).get();
    return CustomerModel.fromSnapshot(result);
  }

  Future<CustomerModel> addOne(
      String userId,
      String fullname,
      String email,
      String contact,
      String address,
      String city,
      String state,
      String pincode,
      String customerType,
      String customerStatus,
      {bool done = false}) async {
    var result = await painterRef.add({
      "user_id": userId,
      "fullname": fullname,
      "email": email,
      "contact": contact,
      "address": address,
      "city": city,
      "state": state,
      "pincode": pincode,
      "customerType": customerType,
      "customerStatus": customerStatus,
      "done": done
    });
    return CustomerModel(
        id: result.documentID,
        fullname: fullname,
        email: email,
        contact: contact,
        address: address,
        city: city,
        state: state,
        pincode: pincode,
        customerType: customerType,
        customerStatus: customerStatus,
        done: done);
  }

  Future<void> updateOne(CustomerModel todo) async {
    painterRef.document(todo.id).updateData(todo.toJson());
  }

  deleteOne(String id) {
    painterRef.document(id).delete();
  }
}
