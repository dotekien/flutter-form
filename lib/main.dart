import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() {
  //debugPaintSizeEnabled=true;
  runApp(MyApp());
}

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
  getClusterTemplate() => const ["default", "template1"];
}

class InputFieldStringObject {
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

class InputAWSRegion extends InputFieldStringObject {}

class InputClusterTemplate extends InputFieldStringObject {}

class InputFieldBooleanObject {
  bool _defaultValue;
  bool _selectedValue;

  bool get defaultValue => _defaultValue;

  set defaultValue(bool value) {
    _defaultValue = value;
  }

  bool get selectedValue => _selectedValue;

  set selectedValue(bool value) {
    _selectedValue = value;
  }
}

class InputUpdateCheck extends InputFieldBooleanObject {}

class InputSanityCheck extends InputFieldBooleanObject {}

class InputSSHCFNUser extends InputFieldStringObject {}

class InputSSHMasterIP extends InputFieldStringObject {}

class InputSSHArgs extends InputFieldStringObject {}

class InputKeyName extends InputFieldStringObject {}

class InputBaseOS extends InputFieldStringObject {}

class InputScheduler extends InputFieldStringObject {}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode inputTextFocusNode;
  final hpClusterConfig = new HPClusterConstant();
  final region = new InputAWSRegion();
  final clusterTemplate = new InputClusterTemplate();
  final updateCheck = new InputUpdateCheck();
  final sanityCheck = new InputSanityCheck();
  final sshCFNUser = new InputSSHCFNUser();
  final sshMasterIP = new InputSSHMasterIP();
  final sshArgs = new InputSSHArgs();
  final keyName = new InputKeyName();
  final baseOS = new InputBaseOS();
  final scheduler = new InputScheduler();

  _MyHomePageState() {
    region.defaultValue = hpClusterConfig.getRegions()[0];
    region.selectedValue = region.defaultValue;
    clusterTemplate.defaultValue = hpClusterConfig.getClusterTemplate()[0];
    clusterTemplate.selectedValue = clusterTemplate.defaultValue;
    updateCheck.defaultValue = true;
    updateCheck.selectedValue = updateCheck.defaultValue;
    sanityCheck.defaultValue = true;
    sanityCheck.selectedValue = sanityCheck.defaultValue;
    sshCFNUser.defaultValue = null;
    sshCFNUser.selectedValue = sshCFNUser.defaultValue;
    sshMasterIP.defaultValue = null;
    sshMasterIP.selectedValue = sshMasterIP.defaultValue;
    sshArgs.defaultValue = null;
    sshArgs.selectedValue = sshArgs.defaultValue;
    keyName.defaultValue = "anh-hpclinux";
    keyName.selectedValue = keyName.defaultValue;
    baseOS.defaultValue = "centos7";
    baseOS.selectedValue = baseOS.defaultValue;
    scheduler.defaultValue = "slurm";
    scheduler.selectedValue = scheduler.defaultValue;
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
          child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                          child: Text('AWS',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))),
                  getDropdownButtonFormField(
                      "Region", hpClusterConfig.getRegions(), region),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                          child: Text('Global',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))),
                  getDropdownButtonFormField("Template",
                      hpClusterConfig.getClusterTemplate(), clusterTemplate),
                  getSwitchFormField("Update Check", updateCheck),
                  getSwitchFormField("Sanity Check", sanityCheck),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                          child: Text('Aliases',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))),
                  getTextFormField("CFN User", sshCFNUser),
                  getTextFormField("Master IP", sshMasterIP),
                  getTextFormField("Args", sshArgs)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                          child: Text('Cluster Default',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))),
                  getTextFormField("Key name", keyName),
                  getTextFormField("Base OS", baseOS),
                  getTextFormField("Scheduler", scheduler)
                ],
              ),
              SizedBox(
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(SnackBar(
                          duration: const Duration(minutes: 5),
                          content: Text("aws_region_name: " +
                              region.selectedValue +
                              ", " +
                              "cluster_template: " +
                              clusterTemplate.selectedValue +
                              ", " +
                              "update_check: " +
                              updateCheck.selectedValue.toString() +
                              ", " +
                              "sanity_check: " +
                              sanityCheck.selectedValue.toString() +
                              ", " +
                              "CFN_USER: " +
                              sshCFNUser.selectedValue +
                              ", " +
                              "MASTER_IP: " +
                              sshMasterIP.selectedValue +
                              ", " +
                              "ARGS: " +
                              sshArgs.selectedValue +
                              ", " +
                              "key_name: " +
                              keyName.selectedValue +
                              ", " +
                              "base_os: " +
                              baseOS.selectedValue +
                              ", " +
                              "scheduler: " +
                              scheduler.selectedValue)));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      color: Colors.transparent,
                      child: Center(child: Text(''))),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  ExpansionTile getExpansionTile(String title, List<Widget> widgets) {
    return ExpansionTile(
        key: new PageStorageKey(title),
        title: Text(title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        children: widgets);
  }

  DropdownButtonFormField getDropdownButtonFormField(String label,
      List<String> items, InputFieldStringObject inputFieldObject) {
    return DropdownButtonFormField<String>(
      key: new PageStorageKey(label),
      decoration: InputDecoration(labelText: label),
      value: inputFieldObject.defaultValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
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

  SwitchListTile getSwitchFormField(
      String label, InputFieldBooleanObject inputFieldBooleanObject) {
    return SwitchListTile(
        key: new PageStorageKey(label),
        title: Text(label),
        value: inputFieldBooleanObject.selectedValue,
        onChanged: (bool newValue) {
          setState(() {
            inputFieldBooleanObject.selectedValue = newValue;
          });
        });
  }

  TextFormField getTextFormField(
      String label, InputFieldStringObject inputFieldStringObject) {
    return TextFormField(
      key: new PageStorageKey(label),
      decoration: InputDecoration(
        hintText: "Enter " + label,
        labelText: label,
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(30)],
      initialValue: inputFieldStringObject.defaultValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter ' + label;
        }
        return null;
      },
      onChanged: (String newValue) {
        setState(() {
          inputFieldStringObject.selectedValue = newValue;
        });
      },
    );
  }
}
