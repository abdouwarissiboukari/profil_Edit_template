class Profil {
  late String firstName;
  late String lastName;
  late int age;
  late double taille;
  late bool genre;
  late List<String> hobbies;
  late int languageFavori;
  late String secret;

  Profil(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.taille,
      required this.genre,
      required this.hobbies,
      required this.languageFavori,
      required this.secret});

  String userName() {
    return '$firstName $lastName';
  }

  String userAge() {
    if (age > 1) {
      return 'Age: $age ans';
    } else {
      return 'Age: $age an';
    }
  }

  String userTaille() {
    return 'Taille: ${taille.round()} cm';
  }

  String userGenre() {
    if (genre) {
      return 'Genre: Masculin';
    } else {
      return 'Genre: Feminin';
    }
  }

  String myHobbies() {
    String hobbie = 'Hobbies: ';
    if (hobbies.isNotEmpty) {
      hobbies.forEach((element) {
        hobbie = '$hobbie $element, ';
      });
    }

    return hobbie;
  }

  String userLanguageFavori() {
    switch (languageFavori) {
      case 0:
        return 'Language de programmation favori: Dart';
        break;
      case 1:
        return 'Language de programmation favori: Swift';
        break;
      case 2:
        return 'Language de programmation favori: Kotlin';
        break;
      case 3:
        return 'Language de programmation favori: Java';
        break;
      case 4:
        return 'Language de programmation favori: Python';
        break;
      default:
        return 'Language de programmation favori: ';
    }
  }
}
