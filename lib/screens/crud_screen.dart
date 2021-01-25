import 'package:flutter/material.dart';
import 'package:test_app/model/Task.dart';

class CrudScreen extends StatefulWidget {
  @override
  _CrudScreenState createState () => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen>{
  TextEditingController _task = TextEditingController();
  bool isEdit = false;
  final _formKey = GlobalKey<FormState>();
  List<Task> _list = [];
  int _listIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get It Crud Sample')
      ),
      body: Container(
        color: Colors.grey.shade200,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            _InputTask(),
            ..._list?.map((task) {
              int index = _list.indexOf(task);
              return Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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
                      icon: Icon(Icons.fiber_new)
                    ),
                    trailing: !isEdit ? IconButton(
                      onPressed: () {
                        setState(() {
                          _list.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete),
                    ) : null,
                    title: Text(task.title.toString()),
                  ),
                ),
              );
            })?.toList() ?? [],
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(!isEdit) {
            if(_formKey.currentState.validate()) {
              setState(() {
                _list.add(Task(title: _task.text));
                _task.text = '';
              });
            }
          } else {
            setState(() {
              isEdit = false;
              _list[_listIndex].title = _task.text;
              _listIndex = 0;
              _task.text = '';
            });
          }
        },
        child: !isEdit ?
          Icon(Icons.check) :
          Text('Update', style: TextStyle(color: Colors.white))
      ),
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
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Enter Task"),
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Please enter Task';
                  }
                  return null;
                },
              )
            ],
          )
        ),
      ),
    );
  }
}