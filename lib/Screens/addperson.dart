import 'package:flutter/material.dart';
import 'package:safevision/Widgets/AddPersonCard.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/PersonCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Person {
  final String imageUrl;
  final String personName;
  final String relationship;

  Person({
    required this.imageUrl,
    required this.personName,
    required this.relationship,
  });
}

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Email and password for login
  String email = 'halilintardaiva@gmail.com';
  String password = 'kerenbanget';

  // Data to send to Firebase
  String name = 'John Doe';
  String phoneNumber = '123-456-7890';

  User? _user;

  // Function to login the user
  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        _user = userCredential.user;
      });
      print("User logged in: ${_user!.email}");
    } catch (e) {
      print("Error logging in: $e");
    }
  }

  // Function to send data to Realtime Database
  Future<void> _sendData() async {
    if (_user != null) {
      // Send name and phone number under the user's UID
      await _database.child('users/${_user!.uid}').set({
        'name': name,
        'phone': phoneNumber,
      });
      print("Data sent to Realtime Database.");
    } else {
      print("User not logged in.");
    }
  }

  @override
  void initState() {
    super.initState();
    _loginUser();
  }

  List<Person> people = [
    Person(
      imageUrl:
          'https://cdn.britannica.com/89/152989-050-DDF277EA/Johnny-Depp-2011.jpg',
      personName: 'Johnny Depp',
      relationship: 'Family',
    ),
    Person(
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod/images/index-dahmer-1664899555.jpg',
      personName: 'Jeffrey Dahmer',
      relationship: 'Family',
    ),
    Person(
      imageUrl:
          'https://akcdn.detik.net.id/visual/2024/09/26/p-diddy_169.jpeg?w=715&q=90',
      personName: 'Sean Combs',
      relationship: 'Colleague',
    ),
    Person(
      imageUrl:
          'https://hips.hearstapps.com/hmg-prod/images/jeffrey-epstein-attends-launch-of-radar-magazine-at-hotel-news-photo-591529968-1562782199.jpg?crop=1xw:0.66667xh;center,top&resize=1200:*',
      personName: 'Jeffrey Epstein',
      relationship: 'Friend',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    void onPressed() {
      _sendData();
      people.add(
        Person(
          imageUrl:
              "https://img.jakpost.net/c/2023/11/24/2023_11_24_144668_1700807263._large.jpg",
          personName: "Fufufafa",
          relationship: "Stranger",
        ),
      );
      setState(() {});
      // Call setState here
    }

    return Scaffold(
      appBar: Appbarwidget(
        title: 'Registered Person',
        subtitle: '${people.length} Registered',
        bold: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: GridView.count(
          childAspectRatio: 175 / 260,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            AddPersonCard(
              onPressed: onPressed,
            ),
            for (int i = 0; i < people.length; i++)
              Personcard(
                imageUrl: people[i].imageUrl,
                personName: people[i].personName,
                relationship: people[i].relationship,
              ),
              
          ],
        ),
      ),
    );
  }
}
