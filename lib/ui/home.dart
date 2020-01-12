import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/scopedmodel/base_model.dart';
import 'package:weather/ui/weather.dart';
import 'package:weather/utils/uilibs.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var namacontroller = TextEditingController();
  var kotacontroller = TextEditingController();
  final FocusNode namaFocus = FocusNode();
  final FocusNode kotaFocus = FocusNode();
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void snackBar(String str, Color color) {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(
        str,
        style: TextStyle(fontSize: 15.0),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    return Scaffold(
        key: _scaffoldState,
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xff281251),
                      offset: Offset(10, 10),
                      blurRadius: 15,
                      spreadRadius: 0.1),
                ]),
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14)),
                      color: Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        'Cek cuaca di kota kamu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20),
                  //   child: Divider(
                  //     color: Theme.of(context).primaryColor,
                  //     thickness: 1,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        controller: namacontroller,
                        focusNode: namaFocus,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 10),
                            // hasFloatingPlaceholder: false,
                            fillColor: Colors.grey[300],
                            filled: true,
                            labelText: 'Nama',
                            prefixIcon: Icon(Icons.people),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))
                            // border: ,
                            ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nama harus diisi';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            UiLibs.nama = value;
                          });
                        },
                        onFieldSubmitted: (value) {
                          _fieldFocusChange(context, namaFocus, kotaFocus);
                        },
                        onSaved: (value) {
                          setState(() {
                            UiLibs.nama = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50,
                      child: TextFormField(
                        controller: kotacontroller,
                        focusNode: kotaFocus,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(fontSize: 10),
                            // hasFloatingPlaceholder: false,
                            fillColor: Colors.grey[300],
                            filled: true,
                            labelText: 'Kota',
                            prefixIcon: Icon(Icons.business),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))
                            // border: ,
                            ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Kota harus diisi';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            UiLibs.kota = value;
                          });
                        },
                        onFieldSubmitted: (value) {
                          kotaFocus.unfocus();
                        },
                        onSaved: (value) {
                          setState(() {
                            UiLibs.kota = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(14),
                              bottomRight: Radius.circular(14))),
                      onPressed: () async {
                        final form = _key.currentState;
                        if (form.validate()) {
                          form.save();
                          print('save');
                          setState(() {
                            isLoading = true;
                          });
                          var temp = await apiBase.fetchpostweatherCheck();
                          if (temp ==
                              'Please check your connection, try again') {
                            setState(() {
                              isLoading = false;
                            });
                            snackBar(temp.toString(), Colors.red);
                          } else if (temp['message'] != null) {
                            setState(() {
                              isLoading = false;
                            });
                            snackBar(temp['message'], Colors.red);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WeatherPage()));
                          }
                        }
                      },
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'CEK CUACA',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
