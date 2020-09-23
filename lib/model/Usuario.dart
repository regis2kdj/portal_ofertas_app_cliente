class Usuario {
  final int iD;
  final String userLogin;
  final String userPass;
  final String userNicename;
  final String userEmail;
  final String userUrl;

  Usuario(
      {this.iD,
        this.userLogin,
        this.userPass,
        this.userNicename,
        this.userEmail,
        this.userUrl});

  Usuario.fromJson(Map<String, dynamic> json) :
    iD = json['ID'],
    userLogin = json['user_login'],
    userPass = json['user_pass'],
    userNicename = json['user_nicename'],
    userEmail = json['user_email'],
    userUrl = json['user_url'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['user_login'] = this.userLogin;
    data['user_pass'] = this.userPass;
    data['user_nicename'] = this.userNicename;
    data['user_email'] = this.userEmail;
    data['user_url'] = this.userUrl;
    return data;
  }
}