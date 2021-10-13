import 'package:flutter/material.dart';
import 'package:hck_case_management/Apis/ApiServices.dart';
import 'package:hck_case_management/Helpers/utils.dart';
import 'package:hck_case_management/Models/bench_model.dart';
import 'package:hck_case_management/Models/case_type_model.dart';
import 'package:hck_case_management/Models/sync_resp.dart';
import 'package:hck_case_management/Providers/global_provider.dart';
import 'package:hck_case_management/Widgets/drop_down_field.dart';
import 'package:provider/provider.dart';
import 'CaseStatusModal.dart';
import 'sql_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(DBExp());

class Mycases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'HCK',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _casedt = [];

  List<BenchModel> benchList = [];
  BenchModel selectedBench;

  List<Case_types> caseTypeList = [];
  Case_types selectedCaseType;

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _casedt = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getphone();
    getCaseTypes();
    yearsList = Utils.getYearList();
    _refreshJournals(); // Loading the diary when the app starts
  }

  var mnumber;
  _getphone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mno = (prefs.getString('Mobile_NUMBER') ?? 0);
    var us = prefs.getString('loginUser');
    setState(() {
      mnumber = mno;
    });
  }

  //CALLING Casetype API HERE
// Get Casetype information by API

  List<String> yearsList = [];

  getCaseTypes() async {
    CaseTypeModel res = await ApiService.getCaseType(context);
    if (res != null) {
      setState(() {
        caseTypeList = res.caseTypes;
      });
    }

    List<BenchModel> bench = await ApiService.getBench(context);
    if (res != null) {
      setState(() {
        benchList = bench;
        selectedBench = benchList[0];
      });
    }

  }

  String selectedYear;
  TextEditingController _casetypeController = new TextEditingController();
  TextEditingController _casenoController = new TextEditingController();
  TextEditingController _caseyearController = new TextEditingController();
  TextEditingController _benchController = new TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _casedt.firstWhere((element) => element['caseId'] == id);
      _casetypeController.text = existingJournal['caseType'];
      _casenoController.text = existingJournal['caseNo'];
      _caseyearController.text = existingJournal['caseYear'];
      _benchController.text = existingJournal['location'];
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text("Add Case"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<BenchModel>(
                  items: benchList
                      .map((label) => DropdownMenuItem(
                    child: Text(label.bench),
                    value: label,
                  ))
                      .toList(),
                  hint: Text('Select Bench'),
                  onChanged: (val) {
                    setState(() {
                      selectedBench = val;
                      print(selectedBench.id+":"+selectedBench.bench);
                    });
                  },
                ),
                DropdownButtonFormField<Case_types>(
                  items: caseTypeList
                      .map((label) => DropdownMenuItem(
                    child: Text(label.typeName),
                    value: label,
                  ))
                      .toList(),
                  hint: Text('Select Case Type'),
                  onChanged: (val) {
                    setState(() {
                      selectedCaseType = val;
                      print(selectedCaseType.typeName);
                    });
                  },
                ),
                TextField(
                  controller: _casenoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Case No'),
                ),
                SizedBox(
                  height: 0.5,
                ),

                DropdownButtonFormField<String>(
                  items: yearsList
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  hint: Text('Select Case Year'),
                  onChanged: (String newValue) {
                    setState(() {
                      selectedYear = newValue;
                      print(selectedYear);
                    });
                  },
                ),
                SizedBox(
                  height: 0.5,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                child: const Text('Add'),
                onPressed: () async {
                  // Save new journal
                  if (id == null) {
                    await _addItem();
                  }

                  if (id != null) {
                    await _updateItem(id);
                  }

                  // Clear the text fields
                  _casetypeController.text = '';
                  _casenoController.text = '';
                  _caseyearController.text = '';
                  _benchController.text = '';

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                color: Colors.red,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]);
      },
    );

  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    if (selectedCaseType == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Case Type'),
      ));
    } else if (selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select Case Type'),
      ));
    } else if (_casenoController.text == null ||
        _casenoController.text == "" ||
        _casenoController.text.length > 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Invalid Case No'),
      ));
    } else {
      await SQLHelper.createItem(
          selectedCaseType.typeName, _casenoController.text, selectedYear, selectedBench.bench, mnumber);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Added Successfully!'),
      ));
      _refreshJournals();
    }
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, selectedCaseType.typeName, _casenoController.text, selectedYear, selectedBench.bench);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Deleted Successfully!'),
    ));
    _refreshJournals();
  }

  // Case Deatils of item
  void _casedetailsItem(int id, String casetype, String caseno, String caseyear,
      String bench, String mobile) async {
    var ben;
    print(id);
    print(casetype + ' ' + caseno + ' ' + caseyear + ' ' + bench);
    print(mobile);
    if (bench == 'Bengaluru') {
      ben = 'B';
    } else if (bench == 'Dharwad') {
      ben = 'D';
    } else if (bench == 'Kalaburagi') {
      ben = 'K';
    }
    print(ben);
    var url1 =
        "http://karnatakajudiciary.kar.nic.in/api/casedetails_new.php?bench=" +
            ben +
            "&type=C" +
            "&case_type=" +
            casetype +
            "&case_no=" +
            caseno +
            "&case_year=" +
            caseyear;
    print(url1);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CasesPopupResult(text: url1)));
  }

  Future<void> _syncItem() async {

    final data = await SQLHelper.getItems();

    var bodydata = json.encode(data);

    var url = 'syncdata.php?mobile=' + mnumber.toString() + '&bodydata=' + bodydata;
    SyncResp res = await ApiService.getSync(context,url);
    print(res.msg);

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //Navigator.of(context).pop();
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      content: Text(res.msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop('dialog');
            }),
        title: Text('My Cases'),
        actions: /*<Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  await _syncItem();
                },
                child: Icon(
                  Icons.sync,
                  size: 26.0,
                ),
              )),
        ],*/
        <Widget>[
          Container(
            width: 100,
            child: FlatButton(
              onPressed: () {_syncItem(); },
              color: Colors.red,
              padding: EdgeInsets.all(1.0),
              child: Row(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[Icon(Icons.sync,size: 26.0,color: Colors.white,), Text("Sync Data",style: TextStyle(color: Colors.white,fontSize: 14),)],
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          :
     Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Total Cases : ", style: TextStyle(fontWeight: FontWeight.w900, color: Colors.redAccent,fontSize: 16),)
                            ],
                          ),
                          Text(_casedt.length.toString(), style: TextStyle(fontWeight: FontWeight.w900, color: Colors.green,fontSize: 16),)
                        ],
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: _casedt.length,
                    itemBuilder: (context, index) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      //color: Colors.orange[200],
                      color: Colors.white,
                      margin: EdgeInsets.all(8),

                      child: ListTile(
                          title: Text(
                            _casedt[index]['caseType'] +
                                ' ' +
                                _casedt[index]['caseNo'] +
                                ' ' +
                                _casedt[index]['caseYear'],
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w900,color: Colors.redAccent),
                          ),
                          subtitle: Text(
                            _casedt[index]['location'],
                            style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w900),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.info_outline, color: Colors.blue,),
                                  onPressed: () => _casedetailsItem(
                                      _casedt[index]['caseId'],
                                      _casedt[index]['caseType'],
                                      _casedt[index]['caseNo'],
                                      _casedt[index]['caseYear'],
                                      _casedt[index]['location'],
                                      _casedt[index]['mobile']),
                                ),

                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.black,),
                                  onPressed: () =>
                                      _deleteItem(_casedt[index]['caseId']),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showForm(null),
        ),
      ),
    );
  }

  Future<void> saveIntInLocalMemory(String key, int value) async {
    var pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
    print('sett');
  }
}
