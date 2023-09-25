import 'package:flutter/material.dart';
import 'package:shoping_app/sql_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isLoading = true;
  List<Map<String, dynamic>> _journals = [];

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    // print("..number of items ${_journals.length}");
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _addItem() async {
    await SQLHelper.createItem(
        _titleController.text, _descriptionController.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Successfully add a journal')));
    _refreshJournals();
    // print("..number of items ${_journals.length}");
    // print(_journals);
  }

  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(
        id, _titleController.text, _descriptionController.text);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully updated a journal')));
    _refreshJournals();
    // print("..number of items ${_journals.length}");
    // print(_journals);
  }

  Future<void> _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully deleted a journal')));
    _refreshJournals();
  }

  void _showForm(int? id) {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _titleController.text = existingJournal['title'];
      _descriptionController.text = existingJournal['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 120,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: 'Title',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange))),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await _addItem();
                    }

                    if (id != null) {
                      await _updateItem(id);
                    }

                    _titleController.text = '';
                    _descriptionController.text = '';
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[300]),
                  child: Text(id == null ? 'Create Now' : 'Update'),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: SpinKitFadingCircle(
            color: Colors.orange[300],
            size: 100.0,
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text("SQL"),
              backgroundColor: Colors.orange[300],
            ),
            body: ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(_journals[index]['title']),
                  subtitle: Text(_journals[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showForm(_journals[index]['id']),
                        ),
                        IconButton(
                            onPressed: () =>
                                _deleteItem(_journals[index]['id']),
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _showForm(null),
              backgroundColor: Colors.orange[300],
            ),
          );
  }
}
