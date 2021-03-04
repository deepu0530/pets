import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pets/pets_list.dart';
import 'package:pets/pets_model.dart';

class SinglePetDetails extends StatefulWidget {
  SinglePetDetails({
    this.name,
    this.age,
    this.breed,
    this.distance,
    this.sex,
    this.image,
    this.description,
  });

  final String name;

  final String age;
  final String breed;
  final String distance;
  final String sex;
  final String image;
  final String description;

  @override
  _SinglePetDetailsState createState() => _SinglePetDetailsState();
}

class _SinglePetDetailsState extends State<SinglePetDetails> {
  List<TodoModel> listTodos = List();
  bool liked = false;

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  bool _fetching = true;

  void getHttp() async {
    setState(() {
      _fetching = true;
    });
    try {
      Response response =
          await Dio().get("https://api.npoint.io/a145beb7c3963677dd5d?");
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Color(0xFF939393),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PetsList(),
                  ),
                );
              }),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 5,right: 20),
              child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFBECE9),
                  ),
                  child: IconButton(
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      size: 25,
                      color: liked
                          ? Color(0xFFF17E69)
                          : Color(0xFFF17E69),
                    ),
                    onPressed: () => _pressed(),
                  )),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                child:
                Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, right: 0, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${widget.name}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Icon(
                                        Icons.zoom_in,
                                        color: Color(0xFFDADADA),
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${widget.breed}",
                                        style: TextStyle(
                                            color: Color(0xFFB7B7B6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "${widget.age}",
                                        style: TextStyle(
                                            color: Color(0xFFB7B7B6),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
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
                                        "${widget.distance} kms away",
                                        style: TextStyle(
                                            color: Color(0xFFDADADA),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    height: 300,
                                    width: 60,
                                    child: ListView.separated(
                                      primary: false,
                                      itemCount: 4,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return SinglePetImagesList();
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: 20,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    height: 350,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFBE88C),
                                      image: DecorationImage(
                                        image: NetworkImage("${widget.image}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "About",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "${widget.description}",

                                style: TextStyle(
                                   color: Color(0xFFDADADA),
                                  //  fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 70,
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                  color: Color(0xFFF17E69),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "ADOPT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        )
        );

  }
}

class SinglePetImagesList extends StatelessWidget {
  const SinglePetImagesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 2, color: Colors.grey[300]),
        image: DecorationImage(
            image: AssetImage("assets/images/p2.jfif"), fit: BoxFit.cover),
      ),
    );
  }
}
