import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppTheme {
  static ThemeData themeData = ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.teal.shade300,
    ),
    primaryColor: Colors.teal.shade200, // Change primary color
    hintColor: Colors.lightBlue, // Change accent color
    scaffoldBackgroundColor: Colors.white, // Change scaffold background color
    textTheme: GoogleFonts.montserratTextTheme(ThemeData().textTheme),

    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent.shade200,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    ),
    cardTheme: CardTheme(
        color: Colors.cyan.shade50,
        shadowColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(8)),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal.shade200,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 20,
      ),
      toolbarTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
    ),

    tabBarTheme: TabBarTheme(
      dividerColor: Colors.grey,
      dividerHeight: 1.0,
      indicatorColor: Colors.red,
      labelColor: Colors.white,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelColor: Colors.grey.shade50,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.teal.shade200,
      type: BottomNavigationBarType.fixed,
      elevation: 10.0,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      unselectedIconTheme: const IconThemeData(color: Colors.black),
      selectedLabelStyle: const TextStyle(color: Colors.black),
      unselectedLabelStyle: const TextStyle(color: Colors.black),
    ),

    //BottomNavigationBarThemeData

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      // You can customize other properties here like labelStyle, hintStyle, etc.
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      elevation: 4,
    ),

    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: Colors.teal.shade200, // Background color for the dialog
      shadowColor: Colors.red, // Shadow color for the dialog
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.teal.shade800, // Text color for the title
        fontSize: 20, // Font size for the title
      ),
      contentTextStyle: TextStyle(
        color: Colors.teal.shade600, // Text color for the content
        fontSize: 16, // Font size for the content
      ),
      // Define additional styles as needed
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
      backgroundColor: Colors.grey[900], // Your preferred background color
      contentTextStyle: const TextStyle(
        color: Colors.white, // Your preferred text color
        fontSize: 16, // Your preferred font size
      ),
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    ),

    // Add more default styles for other widgets as needed
  );
  static Color? get popupMenuColor =>
      themeData.bottomNavigationBarTheme.backgroundColor;
}
