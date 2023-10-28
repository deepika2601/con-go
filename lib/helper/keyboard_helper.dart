

import 'package:flutter/material.dart';

class KeyboardHelper{

  static hideKeyboard(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }

}