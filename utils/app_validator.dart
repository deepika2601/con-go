class AppValidator {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "veuillez entrer l'adresse e-mail  ";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) {
      return "veuillez saisir une adresse e-mail valide sssss";
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "veuillez entrer le mot de passe ";
    } else if (value.length < 5) {
      return "Le mot de passe doit comporter au moins 6 caractères";
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return "veuillez entrer le nom ";
    } else if (value.length < 3) {
      return "Le nom d'utilisateur doit comporter au moins 3 caractères";
    }
    return null;
  }

  static String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "veuillez entrer le nom ";
    }
    return null;
  }
}
