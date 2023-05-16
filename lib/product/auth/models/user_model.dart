// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart' show immutable;
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

typedef UserId = String;
typedef FirstName = String;
typedef LastName = String;
typedef UserEmail = String;
typedef UserPhone = String;
typedef PhotoUrl = String;

@immutable
@JsonSerializable()
class UserData {
  const UserData({
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
  });

  final UserId uid;
  final FirstName? firstName;
  final LastName? lastName;
  final UserEmail? email;
  final UserPhone? phoneNumber;
  final PhotoUrl? photoUrl;

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return _$UserDataFromJson(json);
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        photoUrl.hashCode;
  }

  @override
  String toString() {
    return '''UserData(uid: $uid, firstName: $firstName, lastName: $lastName, email: $email, phoneNumber: $phoneNumber, photoUrl: $photoUrl)''';
  }

  UserData copyWith({
    FirstName? firstName,
    LastName? lastName,
    UserEmail? email,
    UserPhone? phoneNumber,
    PhotoUrl? photoUrl,
  }) {
    return UserData(
      uid: uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
