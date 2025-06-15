import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight;
  Box? _taskBox;
  bool checkedBox = false;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: Text(
          "TASKLY APP",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: _addTaskBoxDB(),
    );
  }

  Widget _addListView() {
    List tasks = _taskBox!.values.toList();
    log("_addListView");
    log(tasks.toString());
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        var task = AddTask.fromMap(tasks[index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              fontSize: 30,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            task.dateTime.toString(),
          ),
          trailing: Icon(
            task.isDone
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank,
            color: task.isDone ? Colors.green : Colors.red,
          ),
          onTap: () {
            task.isDone = !task.isDone;
            _taskBox!.putAt(index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _taskBox!.deleteAt(index);
            setState(() {});
          },
        );
      },
    );
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Enter Task",
            ),
            onSubmitted: (String value) {
              if (value.isEmpty) {
                return;
              }
              var addNewTask = AddTask(
                content: value,
                dateTime: DateTime.now(),
                isDone: false,
              );
              // _taskBox ??= Hive.box("tasks");
              _taskBox!.add(
                addNewTask.toMap(),
              );
              log("Added Task: $value");
              setState(() {});
              Navigator.of(context).pop();
            },
          ),
          
        );
      },
    );
  }

  Widget _addTaskBoxDB() {
    return FutureBuilder(
        future: Hive.openBox("tasks"),
        builder: (BuildContext context, AsyncSnapshot<Box<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            _taskBox = snapshot.data;
            return _addListView();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(fontSize: 30),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red[200],
              ),
            );
          }
        });
  }
}


