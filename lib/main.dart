import 'package:flutter/material.dart';
import 'package:varargs/varargs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Demo';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        body: MyHomePage(title: appTitle),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class HPClusterConstant {
  getRegions() => const ["us-east-1", "us-west-2"];
}

class InputFieldObject {
  String _defaultValue;
  String _selectedValue;

  String get defaultValue => _defaultValue;

  set defaultValue(String value) {
    _defaultValue = value;
  }

  String get selectedValue => _selectedValue;

  set selectedValue(String value) {
    _selectedValue = value;
  }
}

class InputAWSRegion extends InputFieldObject {}


class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode inputTextFocusNode;
  final hpClusterConfig = new HPClusterConstant();
  final region = new InputAWSRegion();

  _MyHomePageState() {
    region.defaultValue = hpClusterConfig.getRegions()[0];
  }

  @override
  void initState() {
    super.initState();
    inputTextFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    inputTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(children: <Widget>[
                  getExpansionTile(
                      "AWS",
                      getWidgets(List.from([
                        getDropdownButtonFormField(
                            "Region",
                            hpClusterConfig.getRegions(),
                            region)
                      ]))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("region: " + region.selectedValue)));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ]),
              ),
            )));
  }

  ExpansionTile getExpansionTile(String title, List<Widget> widgets) {
    return ExpansionTile(
        title: Text(title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        children: widgets);
  }

  List<Widget> getWidgets(List<Widget> widgets) {
    return widgets;
  }

  DropdownButtonFormField getDropdownButtonFormField(String label,
      List<String> items, InputFieldObject inputFieldObject) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.orange)),
      value: inputFieldObject.defaultValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      onChanged: (String newValue) {
        setState(() {
          inputFieldObject.selectedValue = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
