import 'package:bmi_calculator_app/entities/history_antity.dart';
import 'package:flutter/material.dart';

class UsersHistory extends StatefulWidget {
  List<HistoryEntity> usersHistoryList;
  UsersHistory({required this.usersHistoryList, super.key});

  @override
  State<UsersHistory> createState() => _UsersHistoryState();
}

class _UsersHistoryState extends State<UsersHistory> { 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Users History"),
      ),
      body: Container(
        child: Column(children: [
          Container(
            child: widget.usersHistoryList.isNotEmpty
              ? SizedBox(
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("Name: ${widget.usersHistoryList[index].name}\nBMI: ${widget.usersHistoryList[index].bmi!.toStringAsFixed(2)}\nAssessment: ${widget.usersHistoryList[index].assessment}"),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: widget.usersHistoryList.length),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
                child: Text("Nenhum registro encontrado"),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close")
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
