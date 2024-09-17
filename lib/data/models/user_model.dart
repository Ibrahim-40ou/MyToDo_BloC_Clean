import 'package:mytodo_bloc/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.user_id,
    required super.user_name,
    required super.user_email,
  });

  UserEntity toEntity() {
    return UserEntity(
      user_id: user_id,
      user_name: user_name,
      user_email: user_email,
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      user_id: user.user_id,
      user_name: user.user_name,
      user_email: user.user_email,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_email: json['user_email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'user_name': user_name,
        'user_email': user_email,
      };
}
