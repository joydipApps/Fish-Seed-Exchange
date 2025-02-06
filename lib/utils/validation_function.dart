class TextFieldValidation {
  static validateGeneralText(String? value) {
    if (value == null || value.isEmpty) {
      return " Field can't be empty";
    } else {
      return null;
    }
  }

  // Validation function for  password field
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password can't be empty";
    } else if (value.length < 6) {
      return "Password length must be at least 6 characters";
    } else {
      return null;
    }
  }

  static validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your  number';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    }
    return null;
  }

  static String? validateDecimalNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your decimal number';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid decimal number';
    }
    return null;
  }

  static validateDropDownField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }

  // Validation function for Phone Number field
  static validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length != 10 || int.tryParse(value) == null) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  static validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your pin code';
    }
    if (value.length != 6 || int.tryParse(value) == null) {
      return 'Please enter a valid 6-digit pin code';
    }
    return null;
  }

  // Validation function for Email field
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Allow blank email
    }
    // Check if the email format is valid
    if (!isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null; // Email is valid
  }

// Function to check if the email format is valid
  static bool isValidEmail(String email) {
    // You can use a regular expression for email validation
    // Here's a simple example:
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
