class User {
  var _email;
  var _password;

  User(this._email, this._password); //Constructor de la clase

  User.Empty();

  // // Resivimos la información del usuario
  // User.fromJson(Map<String, dynamic> json)
  //     : _email = json['email'],
  //       _password = json['password'];

  // // Convertimos la información del usuario en formato Json
  // Map<String, dynamic> ToJson() => {'email': _email, 'password': _password};

  get email => _email;

  set email(value) => _email = value;

  get password => _password;

  set password(value) => _password = value;
}
