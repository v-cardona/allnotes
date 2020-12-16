class Regex {
  
  static final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$',
  );

  static final RegExp passwordRegExp = RegExp(
    r'^[A-Za-z0-9!"@#$%^&?*()_[\]{},.;:<>+=-]{8,50}$',
  );
}