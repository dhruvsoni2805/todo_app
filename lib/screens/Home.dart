import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todooList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todooList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                //search box containter added by the widget functioon call
                searchBox(),
                //Title Container For All ToDos
                toDoTitleView(),
                //List View For the all the ToDos Items.
                // listViewForToDos(),
                Expanded(
                  flex: 1,
                  child: listViewForToDos(),
                ),
              ],
            ),
          ),
          //Bottom new ToDo item add layout
          newToDoItem(),
        ],
      ),
      //creating the add the new ToDo Item at the bottom screen.
    );
  }

  void _handleToDoChange(ToDo toDo) {
    setState(() {
      toDo.isDone = !toDo.isDone;
    });
  }

  void _onDeleteToDoItem(String id) {
    setState(() {
      todooList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todooList.insert(
          0,
          ToDo(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              todoText: toDo));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];

    if (enteredKeyword.isEmpty) {
      results = todooList;
    } else {
      results = todooList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget toDoTitleView() {
    return //Title Container For All ToDos
        Container(
      width: double.infinity,
      color: tdBGColor,
      padding: const EdgeInsets.all(10),
      child: const Text(
        "All ToDos",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget newToDoItem() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          // TextInput container for the new ToDo Item
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  hintText: "Add a new ToDo item",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          //Add ToDo Item Icon Button
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              right: 20,
            ),
            child: ElevatedButton(
              onPressed: () {
                _addToDoItem(_todoController.text);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(60, 60),
                elevation: 10,
              ),
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listViewForToDos() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 70),
      // shrinkWrap: true,
      physics: const ScrollPhysics(),
      // physics: const ClampingScrollPhysics(),
      itemCount: _foundToDo.length,
      itemBuilder: (context, index) {
        return ToDoItem(
          todo: _foundToDo[index],
          onDeleteItem: _onDeleteToDoItem,
          onToDoChanged: _handleToDoChange,
        );
      },
    );
  }

  Widget searchBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avatar.jpeg'),
            ),
          )
        ],
      ),
    );
  }
}
