import 'package:flutter/material.dart';
import 'package:profil_editing/profil.dart';

class ProfilEditPage extends StatefulWidget {
  @override
  ProfilEditPageState createState() => ProfilEditPageState();
}

class ProfilEditPageState extends State<ProfilEditPage> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerSecret = TextEditingController();

  String hobbiesText = 'Hobbies: ';

  late Profil profil = profil = Profil(
      firstName: controllerLastName.text,
      lastName: controllerLastName.text,
      age: (controllerAge.text.isNotEmpty) ? int.parse(controllerAge.text) : 0,
      taille: 0,
      genre: false,
      hobbies: [],
      languageFavori: -1,
      secret: controllerSecret.text);

  bool obscurTextValue = false;
  bool switchValue = false;

  double taille = 0;
  int langageValue = 4;

  Map<String, bool> hobbies = {
    "Football": true,
    "Baseball": false,
    "Jeux videos": false,
    "Natation": true,
    "Lecture": false,
    "Voyage": false,
  };

  Map<int, String> langages = {
    0: "Dart",
    1: "Swift",
    2: "Kotlin",
    3: "Java",
    4: "Python"
  };

  Color colorAccent = Colors.deepPurple;
  Color colorLight = Colors.deepPurple.shade300;
  Color colorTitle = Colors.white;

  @override
  void initState() {
    super.initState();
    setState(() {
      hobbies.forEach((key, value) {
        if (value) {
          hobbiesText = '$hobbiesText $key, ';

          if (value) {
            if (!profil.hobbies.contains(key)) {
              profil.hobbies.add(key);
            }
          }
        }
      });

      profil.languageFavori = langageValue;
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerAge.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mon profil",
          style: TextStyle(color: colorTitle),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            displayInfos(),
            Divider(
              color: colorAccent,
              thickness: 2,
            ),
            modifyInfos(),
            Divider(
              color: colorAccent,
              thickness: 2,
            ),
            displayHobbies(),
            Divider(
              color: colorAccent,
              thickness: 2,
            ),
            displayLanguage(),
          ],
        ),
      ),
    );
  }

  Widget displayLanguage() {
    List<Widget> children = [];

    langages.forEach((key, value) {
      children.add(langageColumn(number: key, text: value));
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: titleText("Langage préféré"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: children,
        )
      ],
    );
  }

  Widget langageColumn({required int number, required String text}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(text),
        Radio(
          value: number,
          groupValue: langageValue,
          onChanged: ((value) {
            setState(() {
              langageValue = value!;
              profil.languageFavori = value;
            });
          }),
        )
      ],
    );
  }

  onSetControllerFirstName(int int) {
    setState(() {
      switch (int) {
        case 1:
          profil.firstName = controllerFirstName.text;
          break;
        case 2:
          profil.lastName = controllerLastName.text;
          break;
        case 3:
          profil.age =
              (controllerAge.text.isNotEmpty) ? toInto(controllerAge.text) : 0;
          break;
        case 4:
          profil.secret = controllerSecret.text;
          break;
      }
    });
  }

  Widget displayHobbies() {
    List<Widget> children = [];
    // profil.hobbies.clear();

    hobbies.forEach((key, value) {
      children.add(hobbieRow(text: key, bool: value));
    });

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        titleText("Mes Hobbies"),
        Column(
          children: children,
        )
      ],
    );
  }

  Widget hobbieRow({required String text, required bool bool}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(text),
        Checkbox(
          value: bool,
          onChanged: (value) {
            setState(() {
              hobbies[text] = value!;
              if (value) {
                if (!profil.hobbies.contains(text)) {
                  profil.hobbies.add(text);
                }
              } else if (profil.hobbies.contains(text)) {
                profil.hobbies.remove(text);
              }
              hobbiesText = profil.myHobbies();
            });
          },
        )
      ],
    );
  }

  Widget modifyInfos() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        titleText("Modifier les infos"),
        TextField(
          onChanged: (string) => onSetControllerFirstName(1),
          controller: controllerFirstName,
          decoration: const InputDecoration(
              hintText: "Nom",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextField(
          onChanged: (string) => onSetControllerFirstName(2),
          controller: controllerLastName,
          decoration: const InputDecoration(
              hintText: "Prénoms",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextField(
          onChanged: (string) => onSetControllerFirstName(3),
          controller: controllerAge,
          decoration: const InputDecoration(
              hintText: "Age",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        TextField(
          onChanged: (string) => onSetControllerFirstName(4),
          controller: controllerSecret,
          obscuringCharacter: "*",
          obscureText: obscurTextValue,
          decoration: const InputDecoration(
              hintText: "Dites nous un secret",
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(profil.userGenre()),
            Switch(
                value: switchValue,
                onChanged: ((bool) {
                  setState(() {
                    switchValue = bool;
                    profil.genre = bool;
                  });
                }))
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(profil.userTaille()),
            Slider(
                min: 0,
                max: 300,
                value: taille,
                onChanged: ((double) {
                  setState(() {
                    taille = double;
                    profil.taille = double;
                  });
                }))
          ],
        ),
      ],
    );
  }

  Widget titleText(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: colorAccent, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget displayInfos() {
    return Card(
        elevation: 10,
        color: colorLight,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                profil.userName(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                profil.userAge(),
                textAlign: TextAlign.center,
              ),
              Text(
                profil.userTaille(),
                textAlign: TextAlign.center,
              ),
              Text(
                profil.userGenre(),
                textAlign: TextAlign.center,
              ),
              Text(
                hobbiesText,
                textAlign: TextAlign.center,
              ),
              Text(
                profil.userLanguageFavori(),
                textAlign: TextAlign.center,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      obscurTextValue = !obscurTextValue;
                    });
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: colorAccent),
                  child: Text(
                    "Montrer secret",
                    style: TextStyle(color: colorTitle),
                  ),
                ),
              ),
              (!obscurTextValue)
                  ? Text(profil.secret)
                  : Container(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
        ));
  }

  int toInto(String text) {
    return int.parse(text);
  }
}
