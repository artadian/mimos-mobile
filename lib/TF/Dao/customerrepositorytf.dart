import 'package:mimos/TF/Dao/customerdaotf.dart';
//import 'package:mimos/TF/Model/customermodeltf.dart';
import 'package:mimos/TF/Model/konsumenmodelsqllite.dart';

class CustomerRepositoryTF {
  final _customerDao = CustomerDaoTF();
  Future getAllCustomer({String query}) =>
      _customerDao.getSelectCustomer(query: query);
  Future insertCustomer(KonsumenModelSQLite _customer) =>
      _customerDao.insertCustomer(_customer);
  Future updateCustomer(KonsumenModelSQLite _customer) =>
      _customerDao.updateCustomer(_customer);
  Future deleteCustomerByCustomerNo(String _customerNo) =>
      _customerDao.deleteCustomer(_customerNo);
  //We are not going to use this in the demo
  Future deleteAllCustomer() => _customerDao.deleteAllCustomer();
  Future getJumlahCustomer() => _customerDao.countData();
  Future getKonsumenTerkunjungi() => _customerDao.countKonsumenTerkunjungi();
  Future getNotaKonsumen() => _customerDao.countNotaKonsumen();
}
