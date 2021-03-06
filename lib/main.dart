import 'package:flutter/material.dart';
import 'dart:math';

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
  final _weightController = TextEditingController();

  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

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
                validator: (value) {
                  // 입력값이 없으면 메시지 출력
                  if (value.trim().isEmpty) {
                    return 'Enter your Height';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:'Your Height',
                ),
                controller: _heightController,
                keyboardType: TextInputType.number, //숫자만 입력할 수 있음.
              ),
              SizedBox(height:20.0),
              TextFormField(
                validator: (value) {
                  // 입력값이 없으면 메시지 출력
                  if (value.trim().isEmpty) {  //trim() 입력값의 앞뒤 공백을 없애준다.
                    return 'Enter your Weight';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:'Your Weight',
                ),
                controller: _weightController,
                keyboardType: TextInputType.number,
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 20.0),   //margin: top
                child: RaisedButton(
                  child: Text('Validation'),
                  onPressed: (){
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WcResult(
                            double.parse(_heightController.text.trim()), //문자열로 받은 값을 실수로 변환해주기.
                            double.parse(_weightController.text.trim()),
                          ),
                        ),
                      );
                    }
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

  final double height;   //클래스 내에서 쓸 변수 선언
  final double weight;

  WcResult(this.height, this.weight);   //클래스 내에서 변수를 받는다.

  String _calcBmi(double bmi){

    var result = 'row Weight';

    if(bmi >= 35){
      result = 'Very High Weight';
    } else if(35 > bmi && bmi >= 30){
      result = 'Level 2 Weight';
    } else if(30 > bmi && bmi >= 25){
      result = 'Level 1 Weight';
    } else if(25 > bmi && bmi >= 23){
      result = 'Hight Weight';
    } else if(23 > bmi && bmi >= 18.5){
      result = 'Normal';
    }
    return result;
  }

  Widget _buildIcon(double bmi){
    if(bmi >= 23){
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.redAccent,
        size: 100,
      );
    } else if(23 > bmi && bmi >= 18.5){
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.lightGreen,
        size: 100,
      );
    } else if(bmi < 18.5){
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.lightBlue,
        size: 100,
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final bmi = weight / ((height/100) * (height/100));

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildIcon(bmi),
            Text(
              _calcBmi(bmi),
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


