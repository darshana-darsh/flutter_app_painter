import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String id;
  String fullname,
      email,
      contact,
      address,
      city,
      state,
      pincode,
      customerType,
      customerStatus;
  bool done;
  String userId;
  CustomerModel(
      {this.id,
      this.userId,
      this.fullname,
      this.email,
      this.contact,
      this.address,
      this.city,
      this.state,
      this.pincode,
      this.customerType,
      this.customerStatus,
      this.done = false});
  copyWith(
      {fullname,
      email,
      contact,
      address,
      city,
      state,
      pincode,
      customerTypr,
      customerStatus,
      done}) {
    return CustomerModel(
      id: id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      customerType: customerType ?? this.customerType,
      customerStatus: customerStatus ?? this.customerStatus,
      userId: userId ?? this.userId,
      done: done ?? this.done,
    );
  }

  factory CustomerModel.fromSnapshot(DocumentSnapshot snap) {
    return CustomerModel(
      id: snap.documentID,
      done: snap.data["done"],
      fullname: snap.data['fullname'],
      email: snap.data['email'],
      contact: snap.data['contact'],
      address: snap.data['address'],
      city: snap.data['city'],
      state: snap.data['state'],
      pincode: snap.data['pincode'],
      customerType: snap.data['customerType'],
      customerStatus: snap.data['customerStatus'],
    );
  }

  toJson() {
    return {
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
    };
  }
}
