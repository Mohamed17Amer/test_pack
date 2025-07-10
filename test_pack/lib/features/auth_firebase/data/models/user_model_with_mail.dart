import 'package:test_pack/features/auth_firebase/domain/entity/user_entity_with_phone.dart';

class UserModelWithPhone extends UserEntityWithPhone {
  UserModelWithPhone({required String uid, required String phoneNumber})
    : super(uid: uid, phone: phoneNumber);

  factory UserModelWithPhone.fromJson(Map<String, dynamic> json) {
    return UserModelWithPhone(uid: json['uid'], phoneNumber: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'phone': phone};
  }
}
