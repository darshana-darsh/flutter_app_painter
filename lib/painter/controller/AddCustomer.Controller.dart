/*
import 'package:flutter_app/auth/auth.controller.dart';
import 'package:flutter_app/painter/controller/services.dart';
import 'package:flutter_app/painter/model/CustomerModel.dart';


class AddCustomer_Controller  {

  CustomerModel activeCustomer;
  Services _customerService;
  AddCustomer_Controller() {
    _customerService = Services();
  }

  onInit() {
    customers.bindStream(loadCustomers());

  }

  Stream<List<CustomerModel>> loadCustomers() {

    return _customerService.findAll(authController.user.value.uid);
  }

  Future<CustomerModel> loadDetails(String id) async {
    try {
      isLoadingDetails.value = true;
      activeCustomer = await _customerService.findOne(id);
      print(activeCustomer);
      isLoadingDetails.value = false;
      return activeCustomer;
    } catch (e) {}
  }

  addCustomer(String fullname,
      String email,
      String contact,
      String address,
      String city,
      String state,
      String pincode,
      String customerType,
      String customerStatus,
      ) async {
    try {
      AuthController authController = AuthController.to;
      isAddingCustomer.value = true;
      var todo =
      await _customerService.addOne(authController.user.value.uid,fullname,
      email,contact,address,city,state,pincode,customerType,customerStatus
      );
      customers.add(todo);
    //  Get.snackbar("Success", todo.title, snackPosition: SnackPosition.BOTTOM);
      isAddingCustomer.value = false;
    } catch (e) {
      isAddingCustomer.value = false;
      print(e);
    }
  }

  */
/*updateTodo(CustomerModel custmermodel) async {
    try {
      isAddingTodo.value = true;
      await _customerService.updateOne(custmermodel);
      int index = custmermodel.value.indexWhere((element) => element.id == custmermodel.id);

      customers[index] = custmermodel;
      print(custmermodel);
    //  Get.snackbar("Success", " updated", snackPosition: SnackPosition.BOTTOM);
      isAddingTodo.value = false;
    } catch (e) {
      isAddingTodo.value = false;
      print(e);
    }
  }*//*


 */
/* deleteTodo(String id) async {
    try {
      await _customerService.deleteOne(id);
      int index = todos.value.indexWhere((element) => element.id == id);
      todos.removeAt(index);
      Get.snackbar("Success", "Deleted", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print(e);
    }
  }*//*

}*/
