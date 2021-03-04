import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pets/pets_model.dart';
import 'package:pets/single_pet_details.dart';
import 'package:dio/dio.dart';

class PetsList extends StatefulWidget {

  @override
  _PetsListState createState() => _PetsListState();
}

class _PetsListState extends State<PetsList> {


  List<TodoModel> listTodos = List();
  bool _fetching = true;

  void getHttp() async {
    setState(() {
      _fetching = true;
    });
    try {
      Response response =
      await Dio().get("https://api.npoint.io/a145beb7c3963677dd5d");
      setState(() {
        listTodos = todoModelFromJson(jsonEncode(response.data));
        _fetching = false;
      });
    } catch (e) {
      setState(() {
        _fetching = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 0, right: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 3,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF9A9A9A),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 3,
                        width: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF9A9A9A),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 3,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF9A9A9A),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                            color: Color(0xFFDADADA),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cameron St,.Boston",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/p2.jfif"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: Color(0xFFF5F5F5),
                ),
                child: ListView.separated(
                  primary: false,
                  itemCount: listTodos.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    TodoModel todo = listTodos[index];
                    return ListOfPets(
                      name: todo.name,
                      image: todo.image,
                      breed: todo.breed,
                      distance: "${todo.distance}",
                      age: "${todo.age}",
                      sex: "${todo.sex}",
                      description: todo.description,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfPets extends StatefulWidget {
  const ListOfPets({
    this.name, this.image, this.distance, this.age, this.breed, this.sex, this.description,
    Key key,
  }) : super(key: key);

  final String name;
  final String breed;
  final String sex;
  final String distance;
  final String image;
  final String age;
  final String description;

  @override
  _ListOfPetsState createState() => _ListOfPetsState();
}

class _ListOfPetsState extends State<ListOfPets> {
  bool liked = false;

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SinglePetDetails(
                  name: widget.name,
                  age: "${widget.age}",
                  sex: "${widget.sex}",
                  distance: "${widget.distance}",
                  breed: widget.breed,
                  image: widget.image,
                  description: widget.description,
                ),
          ),
        );
      },

      child: Container(
        height: 140,
        width: 400,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Color(0xFFFFFFFF),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Container(
                //height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(widget.image),

                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            liked
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 25,
                            color: liked
                                ? Color(0xFFF17E69)
                                : Colors.grey,
                          ),

                          // onPressed: (){
                          //    setState(() {
                          //      liked = !liked;
                          //    });
                          // },
                          onPressed: () => _pressed(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.breed,
                      style: TextStyle(
                          color: Color(0xFFB7B7B6),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.sex}, ${widget.age} ",
                      style: TextStyle(
                          color: Color(0xFFDADADA),
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFFF29583),
                          size: 20,
                        ),
                        Text(
                          "${widget.distance} kms away ",
                          style: TextStyle(
                              color: Color(0xFFDADADA),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
