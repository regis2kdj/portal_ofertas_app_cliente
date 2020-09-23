
class Cliente {
  final int id;
  final String dateCreated;
  final String dateCreatedGmt;
  final String dateModified;
  final String dateModifiedGmt;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String username;
  //final String password;
  final String avatarUrl;

  
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
        //this.password,
        this.avatarUrl});

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
    //password = json['password'],
    avatarUrl = json['avatar_url'];


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
    //data['password'] = this.password;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}