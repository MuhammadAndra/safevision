import 'package:flutter/material.dart';
import 'package:safevision/Widgets/AddPersonCard.dart';
import 'package:safevision/Widgets/AppBarWidget.dart';
import 'package:safevision/Widgets/PersonCard.dart';

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

class AddPerson extends StatelessWidget {
  const AddPerson({super.key});

  @override
  Widget build(BuildContext context) {
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
                AddPersonCard(),
                for (int i = 0; i < people.length; i++)
                  Personcard(
                    imageUrl: people[i].imageUrl,
                    personName: people[i].personName,
                    relationship: people[i].relationship,
                  ),
              ]
              // List.generate(people.length, (index) {
              //   return Personcard(
              //     imageUrl: people[index].imageUrl,
              //     personName: people[index].personName,
              //     relationship: people[index].relationship,
              //   );
              // }),
              )),
    );
  }
}
