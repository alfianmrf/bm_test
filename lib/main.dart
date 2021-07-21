import 'dart:convert';

import 'package:bm_test/Data.dart';
import 'package:bm_test/Database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DataModel> data = [];
  List keyData = [];
  List valueData = [];
  List saved = [];
  bool load = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      getTest().then((value){
        value.forEach((element) {
          DatabaseHelper.instance.getData(element.date).then((value) {
            if(value.length>0)
              setState(() {
                saved.add(1);
              });
            else
              setState(() {
                saved.add(0);
              });
          });
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            load = false;
          });
        });
      });
    });
  }

  Future<List<DataModel>> getTest() async {
    data = [];
    load = true;
    try{
      final result = await http.get(Uri.parse("https://www.smartcash.co.id:81/web/test_programmer.php"));
      if(result.statusCode == 200){
        final responseJson = json.decode(result.body);
        responseJson.forEach((k, v){
          if(v.isNotEmpty){
            setState(() {
              data.add(DataModel.fromJson(v[0], k));
            });
          }
        });
      }
      return data;
    }catch(err){
      print("Get Category");
      print("error."+err.toString());
      return data;
    }
  }

  Future<void> _showMyDialog(DataModel data) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        keyData = [];
        valueData = [];
        data.toJson().forEach((k, v){
          keyData.add(k);
          valueData.add(v.toString());
        });
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.all(5),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  itemCount: keyData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(keyData[index], style: TextStyle(fontSize: 14)),
                        Text(valueData[index], style: TextStyle(fontSize: 14)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load == true ? Container() : SafeArea(
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              MaterialButton(
                onPressed: (){
                  DatabaseHelper.instance.delete().then((value){
                    for(var i = 0; i < data.length; i++){
                      setState(() {
                        saved[i] = 0;
                      });
                    }
                  });
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Refresh'),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for(var i = 0; i < data.length; i++)
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('date'),
                                Text(data[i].date.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('label'),
                                Text(data[i].label.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('nb_visits'),
                                Text(data[i].nbVisits.toString()),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('status'),
                                Text(saved[i]==1?'saved':'not saved'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MaterialButton(
                                  onPressed: (){
                                    _showMyDialog(data[i]);
                                  },
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  child: Text('Lihat Detil'),
                                ),
                                MaterialButton(
                                  onPressed: (){
                                    DatabaseHelper.instance.insert(data[i].toJson()).then((value){
                                      setState(() {
                                        saved[i] = 1;
                                      });
                                    });
                                  },
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  child: Text('Simpan'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
