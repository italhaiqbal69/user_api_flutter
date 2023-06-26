import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api/models/users_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<UsersModel> usersList = [];
  Future<List<UsersModel>> getUsersApi() async {
    final Response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(Response.body.toString());

    if (Response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
        actions: [
          Icon(Icons.favorite),
          SizedBox(
            width: 20,
          ),
        ],
        backgroundColor: Colors.yellow,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUsersApi(),
                builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            borderOnForeground: true,
                            color: Colors.yellow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(usersList[index].name.toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Username',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(usersList[index].username.toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('email',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(usersList[index].email.toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Address',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(usersList[index]
                                        .address!
                                        .city
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('phone',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(usersList[index].phone.toString()),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('website',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    Text(usersList[index].website.toString()),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
