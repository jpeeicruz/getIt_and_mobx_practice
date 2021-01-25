import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:test_app/model/Task.dart';
import 'package:test_app/store/task-store.dart';

class CrudMobxScreen extends StatefulWidget {
  @override
  _CrudMobxScreenState createState() => _CrudMobxScreenState();
}

class _CrudMobxScreenState extends State<CrudMobxScreen> {
  final store = TaskStore();
  TextEditingController _task = TextEditingController();
  bool isEdit = false;
  final _formKey = GlobalKey<FormState>();
  List<Task> _list = [];
  int _listIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crud Mobx Sample')),
      body: Container(
          color: Colors.grey.shade200,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              _InputTask(),
              Observer(
                builder: (_) => Column(
                  children: store.tasks?.map((task) {
                        int index = store.tasks.indexOf(task);
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Card(
                            child: ListTile(
                              leading: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isEdit = true;
                                      _task.text = task.title;
                                      _listIndex = index;
                                    });
                                  },
                                  icon: Icon(Icons.fiber_new)),
                              trailing: !isEdit
                                  ? IconButton(
                                      onPressed: () => store.deleteTask(index),
                                      icon: Icon(Icons.delete),
                                    )
                                  : null,
                              title: Text(task.title.toString()),
                            ),
                          ),
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!isEdit) {
              if (_formKey.currentState.validate()) {
                store.addTask(_task.text);
                setState(() {
                  _task.text = '';
                });
              }
            } else {
              store.updateTask(_task.text, _listIndex);
              setState(() {
                isEdit = false;
                _listIndex = 0;
                _task.text = '';
              });
            }
          },
          child: !isEdit
              ? Icon(Icons.check)
              : Text('Update', style: TextStyle(color: Colors.white))),
    );
  }

  Widget _InputTask() {
    return Container(
      child: Card(
        elevation: 2,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _task,
                  cursorColor: Colors.black,
                  decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Enter Task"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Task';
                    }
                    return null;
                  },
                )
              ],
            )),
      ),
    );
  }
}
