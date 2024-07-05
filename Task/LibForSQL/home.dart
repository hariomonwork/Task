import 'package:flutter/material.dart';

import 'db.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  List<Map<String, dynamic>> _items = [];
  int? _selectedItemId;

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

  void _refreshItems() async {
    final data = await _dbHelper.items();
    setState(() {
      _items = data;
    });
  }

  void _addItem() async {
    await _dbHelper.insertItem({'name': _nameController.text});
    _nameController.clear();
    _refreshItems();
  }

  void _updateItem(int id) async {
    await _dbHelper.updateItem({'id': id, 'name': _nameController.text});
    _nameController.clear();
    setState(() {
      _selectedItemId = null;
    });
    _refreshItems();
  }

  void _deleteItem(int id) async {
    await _dbHelper.deleteItem(id);
    _refreshItems();
  }

  void _saveItem() {
    if (_selectedItemId == null) {
      _addItem();
    } else {
      _updateItem(_selectedItemId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQL EXP'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _nameController.clear(),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveItem,
            child: Text(_selectedItemId == null ? 'Add Name' : 'Update Name'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ListTile(
                  title: Text(item['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _nameController.text = item['name'];
                            _selectedItemId = item['id'];
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteItem(item['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
