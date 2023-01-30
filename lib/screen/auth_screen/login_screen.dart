import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  FocusNode? node = null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Check Internet Connect
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  //Form Widget
  Widget _email() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Theme.of(context).highlightColor),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10), // add padding to adjust icon
          child: Icon(Icons.email_outlined,
              color: Theme.of(context).highlightColor),
        ),
        labelText: "Enter Your Email Address",
        labelStyle: TextStyle(color: Colors.black54),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Email is required!";
        }
      },
      onSaved: (String? value) {
        email = value!;
      },
    );
  }

  Widget _password() {
    return TextFormField(
      focusNode: node,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Theme.of(context).highlightColor),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10), // add padding to adjust icon
          child: Icon(Icons.lock_open_outlined,
              color: Theme.of(context).highlightColor),
        ),
        labelText: "Enter Your Password",
        labelStyle: TextStyle(color: Colors.black54),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Password is required!";
        }
      },
      onSaved: (String? value) {
        password = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _connectionStatus == ConnectivityResult.none
          ? Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      "assets/images/nointernet.jpg",
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const Text("Please Check Your Internet Connection!"),
                ],
              ),
            )
          : Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 80),
                            Image.asset("assets/images/bd_logo.jpg",
                                width: 240),
                            const SizedBox(height: 20),
                            Text(
                              "Welcome to Burmese Dream",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            const SizedBox(height: 50),
                            _email(),
                            _password(),
                            //Forget Password Button
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Fogot Password?",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            //Login Button
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: InkWell(
                                onTap: () async {
                                  if (!_formKey.currentState!.validate()) {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          title: Text("Sorry"),
                                          content: Text("Login Failed!"),
                                        );
                                      },
                                    );
                                  }
                                  _formKey.currentState!.save();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.0, 5.0),
                                        blurRadius: 20,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                  width: 200,
                                  height: 50,
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //Login with GOOGLE or FB
                            const Text("Or Login Using"),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Image.network(
                                      "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png",
                                      height: 33.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Image.network(
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1024px-Facebook_Logo_%282019%29.png",
                                      height: 33.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: TextButton(
          onPressed: () {
            //GO to sign up screen
          },
          child: const Text("Don't have an account? Sign Up Here")),
    );
  }
}
