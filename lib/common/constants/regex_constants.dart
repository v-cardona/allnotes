class Regex {
  
  static final RegExp emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static final RegExp passwordRegExp = RegExp(
    r'^[A-Za-z0-9!"@#$%^&?*()_[\]{},.;:<>+=-]{8,50}$',
  );
}