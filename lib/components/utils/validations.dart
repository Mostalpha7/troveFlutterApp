class GlobalValidations {
  emailValidator(e) {
    String testemail = e;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(testemail);
    if (emailValid == false) {
      return "Please insert valid Email";
    }
    return;
  }

  genericValidator(e) {
    if (e.isEmpty) {
      return "Required";
    }
    return;
  }

  passwordValidator(e) {
    if (e.isEmpty) {
      return "Enter Password";
    } else if (e.length < 8) {
      return "Password must be at least 8 characters";
    }
    return;
  }

  numberValidator(e, length) {
    if (e.isEmpty) {
      return "Enter number";
    } else if (e.length != int.parse(length)) {
      return "Number must be " + length + " digits";
    }

    return;
  }

  phoneNumberValidator(e, length) {
    if (e.isEmpty) {
      return "Enter number";
      // } else if ('${e[0]}' == '0') {
      //   return "Phone number should not start with ${e[0]}";
    } else if (e.length != int.parse(length)) {
      return "Number must be " + length + " digits";
    }

    return;
  }

  amountValidator(e, amount, balance) {
    if (e.isEmpty) {
      return "Enter amount";
    } else if (int.parse(e) < int.parse(amount)) {
      return "Amount must be at least " + amount;
    }
    // else if (int.parse(e) > int.parse(balance)) {
    //   return "Not enough balance ";
    // }
    return;
  }

  dropdownValidator(e) {
    if (e == null) {
      return "Choose an option";
    }
    return;
  }
}
