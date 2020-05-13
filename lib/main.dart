import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeightCheck(),
    );
  }
}

class WeightCheck extends StatefulWidget {
  @override
  _WeightCheckState createState() => _WeightCheckState();
}

class _WeightCheckState extends State<WeightCheck> {

  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Check'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form( //form에서 값을 받는 formkey가 필요하다
          key:_formKey,
          child:Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:'Your Height',
                ),
                controller: _heightController,
                keyboardType: TextInputType.number, //숫자만 입력할 수 있음.
              ),
              SizedBox(height:20.0),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:'Your Weight',
                ),
                keyboardType: TextInputType.number,
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 10.0),   //margin: top
                child: RaisedButton(
                  child: Text('Validation'),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WcResult(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WcResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_very_dissatisfied,
              color:Colors.red,
              size:100,
            ),
            Text(
              'Normal',
              style: TextStyle(
                fontSize: 36.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


