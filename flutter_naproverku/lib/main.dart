import 'package:flutter/material.dart';

enum GenderList {male, female}

class MyForm extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new Column(children: <Widget>[
      new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value) {
        if (value.isEmpty) RaisedButton(
          onPressed: null, color: Colors.grey,
          child: const Text('Проверить'),
        );
      }),

      new SizedBox(height: 20.0),

      new Text('Контактный E-mail:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty)  {RaisedButton(
          onPressed: null,color: Colors.grey,
          child: const Text('Проверить'),
        );}

        String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
        RegExp regExp = new RegExp(p);

        if (regExp.hasMatch(value)) return null;

        return 'Это не E-mail';
      }),

      new SizedBox(height: 20.0),

      new Text('Ваш пол:', style: TextStyle(fontSize: 20.0),),

      new RadioListTile(
        title: const Text('Мужской'),
        value: GenderList.male,
        groupValue: _gender,
        onChanged: (GenderList value) {setState(() { _gender = value;});},
      ),

      new RadioListTile(
        title: const Text('Женский'),
        value: GenderList.female,
        groupValue: _gender,
        onChanged: (GenderList value) {setState(() { _gender = value;});},
      ),

      new SizedBox(height: 20.0),

      new CheckboxListTile(
          value: _agreement,
          title: new Text('Я ознакомлен'+(_gender==null?'(а)':_gender==GenderList.male?'':'а')+' с документом "Согласие на обработку персональных данных" и даю согласие на обработку моих персональных данных в соответствии с требованиями "Федерального закона О персональных данных № 152-ФЗ".'),
          onChanged: (bool value) => setState(() => _agreement = value)
      ),

      new SizedBox(height: 20.0),



      RaisedButton(onPressed: _formKey.currentState.validate() ? () {Text('Заполните форму');} : null, child: const Text('Проверить'),)
        ],)));
  }
}


void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(title: new Text('Форма регистрации')),
            body: new MyForm()
        )
    )
);
