import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inventory_app/core/models/service_response_model.dart';
import 'package:inventory_app/core/models/user_record/user_record_model.dart';
import 'package:inventory_app/core/utils/constants.dart';
import 'package:inventory_app/core/utils/enums.dart';
import 'package:inventory_app/providers/app_providers.dart';

class SecondaryUsersViewModel extends StateNotifier<SecondaryUsersState> {
  SecondaryUsersViewModel(this.reader) : super(SecondaryUsersState());

  final Reader reader;

  Future<ServiceResponse> fetchSecondaryUsers() async {
    state = state.copyWith(loadStatus: Loader.loading);
    if (!(await checkNetwork()))
      {return ServiceResponse(errorMessage: enableConnection);}
    final userId = reader(authViewModelProvider).user!.uid;
    try{
      final response = await reader(userDataCrudProvider).retrieveSecondaryUserRecords(primaryUid: userId);
      state = state.copyWith(loadStatus: Loader.loaded, secondaryUsers: response,);
      return ServiceResponse(successMessage: 'Secondary Users fetched successfuly');
    } on FirebaseException catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      return ServiceResponse(errorMessage: e.code);
    } catch (e) {
      state = state.copyWith(loadStatus: Loader.error);
      rethrow;
    }
  }

  Future<bool> checkNetwork() async {
    final cResult = await Connectivity().checkConnectivity();
    if (cResult != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}

class SecondaryUsersState {
  SecondaryUsersState({this.loadStatus, this.secondaryUsers,});

  Loader? loadStatus;
  List<UserRecord>? secondaryUsers;

  SecondaryUsersState copyWith({Loader? loadStatus, List<UserRecord>? secondaryUsers,}) {
    return SecondaryUsersState(
      loadStatus: loadStatus ?? this.loadStatus,
      secondaryUsers: secondaryUsers ?? this.secondaryUsers,
    );
  }
}