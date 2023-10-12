import 'package:flutter/material.dart';

import '../services/calculator_service.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  TextEditingController _textEditingControllerWeight = TextEditingController();
  TextEditingController _textEditingControllerHeight = TextEditingController();
  String weight = "";
  String height = "";
  late double result;
  CalculatorService calculatorService = CalculatorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  child: Image.network("https://gastrogynae.com/wp-content/uploads/2021/12/man-body-mass-index-vector.jpg"),
                  elevation: 8,
                  shadowColor: Colors.lightBlueAccent,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Text("Entry your tall"),
                        TextField(
                          controller: _textEditingControllerHeight,
                          onChanged: (value) => {
                            if (value.isNotEmpty) {print("passou height"), height = value}
                          },
                        ),
                      ],
                    ),
                  ),
                  elevation: 8,
                  shadowColor: Colors.lightBlueAccent,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Text("Entry your weight"),
                        TextField(
                          controller: _textEditingControllerWeight,
                          onChanged: (value) => {
                            if (value.isNotEmpty) {print("passou weight"), weight = value}
                          },
                        ),
                      ],
                    ),
                  ),
                  elevation: 8,
                  shadowColor: Colors.blueAccent,
                ),
                ElevatedButton(
                    onPressed: () => {
                          if (validationValues(height, weight))
                            {
                              result = calculatorService.calculateBMI(double.tryParse(weight)!, double.tryParse(height)!),
                              weight = "",
                              height = "",
                              _textEditingControllerHeight.text = "",
                              _textEditingControllerWeight.text = "",
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext buildContext) {
                                    return Stack(children: [
                                      Container(
                                          child: Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJIuHEXx4729HVFshUk7tzkYYWU5NKviyZ3x4zTzfcft_C91HfB4S2a3TGM3ANedjE0a4&usqp=CAU",
                                        fit: BoxFit.cover,
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
                                                      text: TextSpan(text: "Assessment: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), children: [
                                                    TextSpan(
                                                      text: "${calculatorService.analyzeBMI(result)}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.purple[700],
                                                      ),
                                                    )
                                                  ])),
                                                ),
                                                elevation: 8,
                                                shadowColor: Colors.amber[700],
                                              ),
                                              Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: RichText(
                                                      text: TextSpan(text: "BMI: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), children: [
                                                    TextSpan(
                                                      text: "${result.toStringAsFixed(2)}",
                                                      style: TextStyle(fontSize: 16, color: Colors.purple[700]),
                                                    )
                                                  ])),
                                                ),
                                                elevation: 8,
                                                shadowColor: Colors.amber[800],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]);
                                  })
                            }
                          else
                            {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext buildContext) {
                                    return AlertDialog(
                                      title: Text("Warning!"),
                                      content: Container(
                                        child: Text("Verifique se os campos foram preenchidos corretamente!"),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Ok!"))
                                      ],
                                    );
                                  }),
                            }
                        },
                    child: Text("Calc")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validationValues(String height, String weight) {
    weight = weight.replaceAll(RegExp('[^0-9\.]'), '');
    height = height.replaceAll(RegExp('[^0-9\.]'), '');
    return (height.isEmpty || weight.isEmpty) ? false : true;
  }
}
