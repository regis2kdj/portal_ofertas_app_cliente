class clientes {
  List<Cliente> cliente;

  clientes({this.cliente});

  clientes.fromJson(Map<String, dynamic> json) {
    if (json['clientes'] != null) {
      cliente = new List<Cliente>();
      json['clientes'].forEach((v) {
        cliente.add(new Cliente.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cliente != null) {
      data['clientes'] = this.cliente.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cliente {
  final int id;
  final String dateCreated;
  final String dateCreatedGmt;
  final Null dateModified;
  final Null dateModifiedGmt;
  final String email;
  final Null firstName;
  final Null lastName;
  final String role;
  final String username;
  final String password;

  Cliente(
      { this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.email,
        this.firstName,
        this.lastName,
        this.role,
        this.username,
        this.password});

  Cliente.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    dateCreated = json['date_created'],
    dateCreatedGmt = json['date_created_gmt'],
    dateModified = json['date_modified'],
    dateModifiedGmt = json['date_modified_gmt'],
    email = json['email'],
    firstName = json['first_name'],
    lastName = json['last_name'],
    role = json['role'],
    username = json['username'],
    password = json['password'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['role'] = this.role;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}