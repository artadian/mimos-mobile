import 'package:flutter/material.dart';
import 'package:mimos/Screen/login/login_vm.dart';
import 'package:mimos/utils/layout/loading_container.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _vm = LoginVM();
  var heightForm = 484.0;

  @override
  void initState() {
    super.initState();
    _vm.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LoginVM>(
        create: (_) => _vm,
        child: Consumer<LoginVM>(
          builder: (c, vm, _) => _initWidget(),
        ),
      ),
    );
    // return _sliverAppBar();
  }

  Widget _initWidget() {
    return _vm.loading
        ? Center(
            child: LoadingContainer(),
          )
        : _body();
  }

  Widget _body() {
    var mediaQueryData = MediaQuery.of(context);
    var screenSize = mediaQueryData.size;
    return SingleChildScrollView(
      child: Form(
        key: _vm.keyForm,
        child: Container(
          padding: EdgeInsets.all(16),
          height: screenSize.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/mimos_icon.png",
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormField(
                controller: _vm.username,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(
                    Icons.person,
                  ),
                ),
                validator: (String val) {
                  return val.isEmpty ? "Field is required" : null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _vm.password,
                obscureText: _vm.obscurePass,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _vm.obscurePass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[700]),
                    onPressed: _vm.togglePass,
                  ),
                ),
                validator: (String val) {
                  return val.isEmpty ? "Field is required" : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _vm.signin();
                  },
                  child: Text("LOGIN"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(0, 153, 130, 1.0),
                  )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
