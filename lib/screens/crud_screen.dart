import 'package:flutter/material.dart';
import 'package:test_app/model/Task.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/services/TaskService.dart';

GetIt getIt = GetIt.instance;

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
  void initState() {
    getIt
      .isReady<TaskModel>()
      .then((_) => getIt<TaskModel>().addListener(update));
    update();
    super.initState();
  }

  @override
  void dispose() {
    getIt<TaskModel>().removeListener(update);
    super.dispose();
  }

  void update () => setState(() {
    _list = getIt<TaskModel>().tasks;
    _task.text = '';
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get It Crud Sample')
      ),
      body: FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Container(
              color: Colors.grey.shade200,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ListView(
                children: [
                  _InputTask(),
                  ..._list?.map((task) {
                    int index = _list.indexOf(task);
                    return Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
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
                              getIt<TaskModel>().deleteTask(index);
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
            );
          } else {
            return Center(
              child: Text('Waiting for initialization')
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(!isEdit) {
            if(_formKey.currentState.validate()) {
              getIt<TaskModel>().addTask(_task.text);
            }
          } else {
            getIt<TaskModel>().updateTask(_task.text, _listIndex);
            setState(() {
              isEdit = false;
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