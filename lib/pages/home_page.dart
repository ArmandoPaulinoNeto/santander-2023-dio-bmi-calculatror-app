import 'package:bmi_calculator_app/entities/history_antity.dart';
import 'package:bmi_calculator_app/pages/users_history.dart';
import 'package:flutter/material.dart';

import '../services/calculator_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String weight = "";
  String height = "";
  CalculatorService calculatorService = CalculatorService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator"),
        ),
        drawer: Drawer(
            child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("ISoftware"),
              accountEmail: Text("www.bmi-calcularor-app.com"),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color.fromARGB(255, 74, 20, 140),
                      width: 2,
                    )),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage("https://www.blundellharling.com/wp-content/uploads/2022/10/Full-colour-logo-here-P6098-BMI.jpg"),
                ),
              ),
            ),
            ListTile(
              title: Text("Shared Users History"),
              leading: Icon(Icons.history),
              onTap: () async {
                Navigator.of(context).pop();
                await callUsersHistory(context, 0);
              },
            ),
            ListTile(
              title: Text("Hive Users History"),
              leading: Icon(Icons.history),
              onTap: () async {
                Navigator.of(context).pop();
                await callUsersHistory(context, 1);
              },
            ),
            ListTile(
              title: Text("Sqlite Users History"),
              leading: Icon(Icons.history),
              onTap: () async {
                Navigator.of(context).pop();
               await callUsersHistory(context, 2);
              },
            ),
            ListTile(
              title: Text("About"),
              leading: Icon(Icons.library_books_rounded),
            ),
          ],
        )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  shadowColor: Colors.lightBlueAccent,
                  child:
                      Image.network("https://img.freepik.com/free-vector/bmi-body-mass-index-isometric-landing-page-banner_107791-9278.jpg?size=626&ext=jpg&ga=GA1.2.2026992169.1679521628&semt=sph"),
                ),
                Form(
                    key: _formKey,
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.lightBlueAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(labelText: "Entry your name", border: OutlineInputBorder()),
                              validator: (value) => value!.isEmpty ? "The field name cannot be empty!" : null,
                              onSaved: (value) => name = value!,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "Entry your tall", hintText: "Ex.: 1.90", border: OutlineInputBorder()),
                              validator: (value) => validationValues(value!) ? "The field tall cannot be empty!" : null,
                              onSaved: (value) => height = value!,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: "Entry your weight", hintText: "Ex.: 90.0", border: OutlineInputBorder()),
                              validator: (value) => validationValues(value!) ? "The field weight cannot be empty!" : null,
                              onSaved: (value) => weight = value!,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blueAccent),
                              child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _formKey.currentState!.reset();
                                      double bmi = calculatorService.calculateBMI(double.tryParse(weight)!, double.tryParse(height)!);
                                      String assessment = calculatorService.analyzeBMI(bmi);
                                      weight = "";
                                      height = "";
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext buildContext) {
                                            return Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Colors.amber[50],
                                                ),
                                                child: Stack(children: [
                                                  Container(
                                                      child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Card(
                                                      elevation: 10,
                                                      shadowColor: Colors.lightBlueAccent,
                                                      child: Image.network(
                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJIuHEXx4729HVFshUk7tzkYYWU5NKviyZ3x4zTzfcft_C91HfB4S2a3TGM3ANedjE0a4&usqp=CAU",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )),
                                                  Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 80),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: RichText(
                                                                  text: TextSpan(text: "Name: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), children: [
                                                                TextSpan(
                                                                  text: "$name",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.purple[700],
                                                                  ),
                                                                )
                                                              ])),
                                                            ),
                                                            elevation: 8,
                                                            shadowColor: Colors.lightBlueAccent,
                                                          ),
                                                          Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: RichText(
                                                                  text: TextSpan(text: "Assessment: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), children: [
                                                                TextSpan(
                                                                  text: "$assessment",
                                                                  style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: Colors.purple[700],
                                                                  ),
                                                                )
                                                              ])),
                                                            ),
                                                            elevation: 8,
                                                            shadowColor: Colors.lightBlueAccent,
                                                          ),
                                                          Card(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: RichText(
                                                                  text: TextSpan(text: "BMI: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), children: [
                                                                TextSpan(
                                                                  text: "${bmi.toStringAsFixed(2)}",
                                                                  style: TextStyle(fontSize: 16, color: Colors.purple[700]),
                                                                )
                                                              ])),
                                                            ),
                                                            elevation: 8,
                                                            shadowColor: Colors.lightBlueAccent,
                                                          ),
                                                          Container(
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(10)),
                                                            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                                                            child: TextButton.icon(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                              showDialog(
                                                                context: context,
                                                                builder: (BuildContext buildContext) {
                                                                  return AlertDialog(
                                                                    title: Text("Save History"),
                                                                    content: Wrap(children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width: 50,
                                                                            height: 50,
                                                                            margin: EdgeInsets.only(right: 10),
                                                                            child: Card(
                                                                              child: GestureDetector(
                                                                                child: Image.network("https://cdn-icons-png.flaticon.com/512/5658/5658359.png"),
                                                                                onTap: () =>
                                                                                    {calculatorService.createHistoryStorage(name, bmi, assessment, "shared"), Navigator.of(context).pop()},
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width: 50,
                                                                            height: 50,
                                                                            margin: EdgeInsets.only(right: 10),
                                                                            child: Card(
                                                                              child: GestureDetector(
                                                                                child: Image.network(
                                                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-ntnsR28A2cf6E6qefuVRJwqoLEy3rZ5VLoorBycG_Z_oymTmxv9wPbgFr5YCEOhw-F4&usqp=CAU"),
                                                                                onTap: () => {calculatorService.createHistoryStorage(name, bmi, assessment, "hive"), Navigator.of(context).pop()},
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width: 50,
                                                                            height: 50,
                                                                            margin: EdgeInsets.only(right: 10),
                                                                            child: Card(
                                                                              child: GestureDetector(
                                                                                child: Image.network("https://freesvg.org/img/SQLite_icon.png"),
                                                                                onTap: () =>
                                                                                    {calculatorService.createHistoryStorage(name, bmi, assessment, "sqlite"), Navigator.of(context).pop()},
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 20),
                                                                            child: Text("Shared"),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 22),
                                                                            child: Text("Hive"),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(right: 3),
                                                                            child: Text("SQLite"),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ]),
                                                                  );
                                                                }
                                                              );
                                                            },
                                                            icon: Icon(Icons.save,
                                                              color: Colors.black,
                                                            ),
                                                            label: Text("Save",
                                                              style: TextStyle(
                                                                color: Colors.black
                                                              ),
                                                            )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            );
                                          });
                                    }
                                  },
                                  child: Text(
                                    "Calculate",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> callUsersHistory(BuildContext context, int storage) async {
    late List<HistoryEntity> histories;
    if (storage == 0) {
      histories = await calculatorService.fetchAllHistoryShared();
    } else if(storage == 1) {
      histories = await calculatorService.fetchAllHistoryHive();
    }else{
      histories =await calculatorService.fetchAllHistorySqlite();
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => UsersHistory(usersHistoryList: histories)));
  }

  bool validationValues(String value) {
    value = value.replaceAll(RegExp('[^0-9\.]'), '');
    return value.isEmpty;
  }
}
