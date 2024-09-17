import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytodo_bloc/domain/failure/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<Either<Failure, UserModel>> googleSignIn() async {
    await _supabaseClient.auth.signOut();
    await GoogleSignIn().signOut();
    const webClientId =
        '246466059237-eghapj8acilkoptbfbb1cilcsoljq8in.apps.googleusercontent.com';
    const iosClientId =
        '246466059237-v3d26uietv60h37mrssfm73v67pkeb89.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;
    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    try {
      await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      final User? user = Supabase.instance.client.auth.currentUser;
      UserModel userModel = UserModel(
        user_id: '',
        user_name: '',
        user_email: '',
      );
      if (user != null) {
        userModel = UserModel(
          user_id: user.id,
          user_name: user.userMetadata?['full_name'] ?? 'No name',
          user_email: user.email ?? 'No Email',
        );
        await Supabase.instance.client.from('users').insert(userModel.toJson());
      }
      return Right(userModel);
    } on Exception catch (e) {
      if (kDebugMode) {
      }
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, UserModel>> signIn(
    String email,
    String password,
  ) async {
    try {
      final AuthResponse response =
          await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(
        UserModel(
          user_id: response.user!.id,
          user_email: response.user!.email!,
          user_name: response.user!.userMetadata?['full_name'] ?? 'No name',
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print('$e');
      }
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, UserModel>> register(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final AuthResponse response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        await Supabase.instance.client.from('users').insert(
              UserModel(
                user_id: response.user!.id,
                user_name: fullName,
                user_email: email,
              ).toJson(),
            );
      }
      return Right(
        UserModel(
          user_id: response.user!.id,
          user_email: response.user!.email!,
          user_name: response.user!.userMetadata?['full_name'] ?? 'No name',
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print('$e');
      }
      return Left(Failure(message: '$e'));
    }
  }
}
