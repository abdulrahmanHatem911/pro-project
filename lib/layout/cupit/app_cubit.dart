import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pre/modules/chat/chat_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../../app_router.dart';
import '../../models/message.dart';
import '../../models/post_modal.dart';
import '../../models/user_model.dart';
import '../../modules/archived_tasks/archived_tasks_screen.dart';
//import '../../modules/chat_details/chat.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/edit_profile/edit_profile_screen.dart';
import '../../modules/home_screen/home_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';
import '../../modules/notes.dart';
import '../../modules/settings/setting_screen.dart';
import '../../shared/services/local/cache_data.dart';
import '../../shared/services/local/cahce_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  // make object of the cubit
  static AppCubit get(context) => BlocProvider.of(context);

  // bottom nav bar items
  int currentIndex = 0;

  List<String> appBarTitles = [
    'Home',
    'notes',
    'chat',
    'Settings',
    'accaunt',
  ];

  List<Widget> screens = [
    const HomeScreen(),
    NoteScreen(),
    const ChatScreen(),
    const SettingScreen(),
    const EditProfileScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined), label: 'notes'),
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'settings'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.account_box_outlined), label: 'account'),
  ];

  void changeBottomNavigationBarItems(int index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  bool isDarkFromShared = (CacheHelper.getCacheData(key: 'isDark') == null)
      ? false
      : CacheHelper.getCacheData(key: 'isDark');
  void changeAppMode() {
    isDarkFromShared = !isDarkFromShared;
    emit(ChangeModeOfApp());
    print('📍 $isDarkFromShared');
    CacheHelper.saveCacheData(key: 'isDark', value: isDarkFromShared);
  }

  // void saveAppModeInFirstLaunch({bool? isDarkFromShared}) {
  //   if (isDarkFromShared != null) {
  //     isDark = isDarkFromShared;
  //     emit(ThemeLaunchMode());
  //   } else {
  //     CacheHelper.saveCacheData(key: 'isDark', value: isDark)
  //         .then((_) => emit(ThemeLaunchMode()));
  //   }
  // }

  int currentIndexx = 0;
  List<Widget> bodyScreens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];
  List<String> titleScreen = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void getCurrentUserData() {
    print("📍 ${CacheData.uId}");
    emit(GetCurrentUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheData.uId)
        .get()
        .then((value) {
      CURRENTUSER = UserModel.fromMap(value.data());
      print("📍 ${CURRENTUSER!.name}");
      emit(GetCurrentUserSuccess());
    }).catchError((error) {
      print('getCurrentUserData -- ${error.toString()}');
      emit(GetCurrentUserError(error.toString()));
    });
  }

  // Database
  late Database _database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database database, int version) {
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (Database database) {
        getDataFromDatabase(database);
        print('opened');
      },
    ).then((value) {
      _database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await _database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('task inserted');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(_database);
      }).catchError((err) {
        print(err.toString());
      });
    });
  }

  void getDataFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppCreateDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      }
      emit(AppGetDatabaseState());
    });
  }

  void updateData({required String status, required int id}) async {
    _database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getDataFromDatabase(_database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({required int id}) async {
    _database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(_database);
      emit(AppDeleteDatabaseState());
    });
  }

  // floating action bottom
  bool isBottomSheetShawn = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShawn = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // image picker (profile / cover / post)
  final ImagePicker _picker = ImagePicker();

  File? profileImage;

  Future<void> getProfileImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(ProfileImageSuccess());
    } else {
      emit(ProfileImageError());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(CoverImageSuccess());
    } else {
      emit(CoverImageError());
    }
  }

  File? postImage;

  Future<void> getPostImage() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      postImage = File(pickedImage.path);
      emit(PostImageSuccess());
    } else {
      emit(PostImageError());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemove());
  }

  // upload (profile / cover / post) image
  String profileImageUrl = '';

  Future<void> uploadProfileImage() async {
    try {
      var value = await FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!);

      var profileImageUrl = await value.ref.getDownloadURL();
      this.profileImageUrl = profileImageUrl;

      emit(UploadProfileImageSuccess());
    } catch (e) {
      print('uploadProfileImage -- ${e.toString()}');
      emit(UploadProfileImageError());
    }
  }

  String coverImageUrl = '';

  Future<void> uploadCoverImage() async {
    try {
      var value = await FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
          .putFile(coverImage!);

      var coverImageUrl = await value.ref.getDownloadURL();
      this.coverImageUrl = coverImageUrl;

      emit(UploadCoverImageSuccess());
    } catch (e) {
      print('uploadCoverImage -- ${e.toString()}');
      emit(UploadCoverImageError());
    }
  }

  String postImageUrl = '';

  Future<void> uploadPostImage() async {
    try {
      var value = await FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!);

      var postImageUrl = await value.ref.getDownloadURL();
      this.postImageUrl = postImageUrl;

      emit(UploadPostImageSuccess());
    } catch (e) {
      print('uploadPostImage -- ${e.toString()}');
      emit(UploadPostImageError());
    }
  }

  // update user data
  updateUser({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(UpdateUserLoading());

    if (coverImage != null && profileImage != null) {
      await uploadProfileImage();
      await uploadCoverImage();
    } else if (profileImage != null) {
      await uploadProfileImage();
    } else if (coverImage != null) {
      await uploadCoverImage();
    }

    _updateUserData(
      name: name,
      phone: phone,
      bio: bio,
    );
  }

  void _updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: profileImage == null ? CURRENTUSER!.image : profileImageUrl,
      cover: coverImage == null ? CURRENTUSER!.cover : coverImageUrl,
      email: CURRENTUSER!.email,
      emailVerified: CURRENTUSER!.emailVerified,
      uId: CURRENTUSER!.uId,
    );

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users.doc(CURRENTUSER!.uId).update(userModel.toMap()).then((_) {
      getCurrentUserData();
    }).catchError((e) {
      print('_updateUserData -- ${e.toString()}');
      emit(UpdateUserError());
    });
  }

  void createNewPost({
    required String dateTime,
    required String text,
  }) async {
    emit(CreatePostLoading());

    if (postImage != null) {
      await uploadPostImage();
    }

    _createNewPostData(
      dateTime: dateTime,
      text: text,
    );
  }

  void _createNewPostData({
    required String dateTime,
    required String text,
  }) {
    PostModel newPost = PostModel(
      name: CURRENTUSER!.name,
      uId: CURRENTUSER!.uId,
      image: CURRENTUSER!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImageUrl,
    );

    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    posts.add(newPost.toMap()).then((_) {
      emit(CreatePostSuccess());
    }).catchError((e) {
      print('_createNewPostData -- ${e.toString()}');
      emit(CreatePostError());
    });
  }

  // getPostsData
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> postsLikes = [];

  void getPostsData() {
    emit(GetPostsLoading());

    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromMap(element.data()));
        }).catchError((error) {});
      }
      emit(GetPostsSuccess());
    }).catchError((error) {
      emit(GetPostsError(error.toString()));
    });
  }

  // likePost
  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(CURRENTUSER!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostsSuccess());
    }).catchError((error) {
      emit(LikePostsError(error.toString()));
    });
  }

  // TODOCOMMENTS_COUNTER

  // getAllUsers
  List<UserModel> allUsers = [];

  void getAllUsers() {
    emit(GetAllUsersLoading());

    if (allUsers.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          print(element.data()['uId']);
          if (element.data()['uId'] != CURRENTUSER!.uId) {
            allUsers.add(UserModel.fromMap(element.data()));
          }
          emit(GetAllUsersSuccess());
        }
      }).catchError((error) {
        emit(GetAllUsersError(error.toString()));
      });
    }
  }

  // signOut
  Future<void> signOutAndClraeCache(BuildContext context) async {
    await CacheHelper.clearCacheData();
    await FirebaseAuth.instance.signOut();

    Navigator.pushNamedAndRemoveUntil(
        context, AppRouter.loginScreen, (route) => false);
  }

  // chat
  sendMessage({
    required String recevierId,
    required String messageDate,
    required String messagetext,
  }) {
    MessageModel message = MessageModel(
      sinderId: CURRENTUSER!.uId,
      recevierId: recevierId,
      messageDate: messageDate,
      messagetext: messagetext,
    );

    // add chat message to sinderId
    FirebaseFirestore.instance
        .collection('users')
        .doc(CURRENTUSER!.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });

    // add chat message to recevierId
    FirebaseFirestore.instance
        .collection('users')
        .doc(recevierId)
        .collection('chats')
        .doc(CURRENTUSER!.uId)
        .collection('messages')
        .add(message.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({
    required String recevierId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CURRENTUSER!.uId)
        .collection('chats')
        .doc(recevierId)
        .collection('messages')
        .orderBy('messageDate')
        .snapshots()
        .listen((event) {
      messages = [];

      for (var element in event.docs) {
        messages.add(MessageModel.fromMap(element.data()));
      }

      emit(GetMessageSuccess());
    });
  }
}
