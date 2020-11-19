import 'package:mimos/TF/Dao/customerrepositorytf.dart';
import 'dart:async';
import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';
class CustomerBlocTF {
  final _customerRepo = CustomerRepositoryTF();
  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _customerController = StreamController<List<KonsumenModelSQLite>>.broadcast();
  get customerS => _customerController.stream;

  CustomerBlocTF() {
    getCustomerS(); 
  }
  getCustomerS({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _customerController.sink
        .add(await _customerRepo.getAllCustomer(query: query));
  }
 
  addCustomer(KonsumenModelSQLite _customer) async {
    await _customerRepo.insertCustomer(_customer);
    getCustomerS();
  }

  updateCustomer(KonsumenModelSQLite _customer) async {
    await _customerRepo.updateCustomer(_customer);
    getCustomerS();
  }

  deleteCustomerByCustomerNo(String _customerNo) async {
    _customerRepo.deleteCustomerByCustomerNo(_customerNo);
    getCustomerS();
  }

  getJumlahDataCustomer() async {
    _customerRepo.getJumlahCustomer();
   // getCustomerS();
  }

  dispose() {
    _customerController.close();
  }
}
