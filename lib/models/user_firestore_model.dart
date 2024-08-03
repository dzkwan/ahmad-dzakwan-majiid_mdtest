import 'dart:convert';

class UserFirestoreModel {
    String? email;
    String? nama;
    bool? emailVerified;
    String? uid;

    UserFirestoreModel({
        this.email,
        this.nama,
        this.emailVerified,
        this.uid,
    });

    factory UserFirestoreModel.fromRawJson(String str) => UserFirestoreModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserFirestoreModel.fromJson(Map<String, dynamic> json) => UserFirestoreModel(
        email: json["email"],
        nama: json["nama"],
        emailVerified: json["emailVerified"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "nama": nama,
        "emailVerified": emailVerified,
        "uid": uid,
    };
}
