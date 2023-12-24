part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class AppChangeBottomNavBarState extends AppState {}

class AppCreateDatabaseLoadingState extends AppState {}

class AppCreateDatabaseState extends AppState {}

class AppGetDatabaseState extends AppState {}

class AppInsertDatabaseState extends AppState {}

class AppUpdateDatabaseState extends AppState {}

class AppDeleteDatabaseState extends AppState {}

class ChangeBottomSheetState extends AppState {}


class ThemeLaunchMode extends AppState {}

class ThemeChangeMode extends AppState {}


// getCurrentUserData
class GetCurrentUserLoading extends AppState {}

class GetCurrentUserSuccess extends AppState {}

class GetCurrentUserError extends AppState {
  final String error;
  GetCurrentUserError(this.error);
}

// bottom nav bar items
class ChangeBottomNav extends AppState {}

class NewPost extends AppState {}

// image picker (profile / cover / post)
class ProfileImageSuccess extends AppState {}

class ProfileImageError extends AppState {}

class CoverImageSuccess extends AppState {}

class CoverImageError extends AppState {}

class PostImageSuccess extends AppState {}

class PostImageError extends AppState {}

class PostImageRemove extends AppState {}

// upload (profile / cover / post) image
class UploadProfileImageSuccess extends AppState{}

class UploadProfileImageError extends AppState {}

class UploadCoverImageSuccess extends AppState {}

class UploadCoverImageError extends AppState{}

class UploadPostImageSuccess extends AppState {}

class UploadPostImageError extends AppState{}

// update user data
class UpdateUserLoading extends AppState{}

class UpdateUserError extends AppState {}

//  create new post
class CreatePostLoading extends AppState {}

class CreatePostSuccess extends AppState {}

class CreatePostError extends AppState {}

// getPostsData
class GetPostsLoading extends AppState {}

class GetPostsSuccess extends AppState {}

class GetPostsError extends AppState {
  final String error;
  GetPostsError(this.error);
}

// likePost
class LikePostsSuccess extends AppState {}

class LikePostsError extends AppState {
  final String error;
  LikePostsError(this.error);
}
class ChangeMode extends AppState {}

// getAllUsers
class GetAllUsersLoading extends AppState {}

class GetAllUsersSuccess extends AppState {}

class GetAllUsersError extends AppState {
  final String error;
  GetAllUsersError(this.error);
}

// chat
class SendMessageSuccess extends AppState {}

class SendMessageError extends AppState {}

class GetMessageSuccess extends AppState {}
