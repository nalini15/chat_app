import 'package:chat_app/domain/app_constants.dart';
import 'package:chat_app/domain/constants.dart';
import 'package:chat_app/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? displayNameController;
  TextEditingController? aboutMeController;
  final TextEditingController _phoneController = TextEditingController();
  late ProfileProvider profileProvider;
  String id = '';
  String displayName = '';
  String photoUrl = '';
  String phoneNumber = '';
  String aboutMe = '';
  String dialCodeDigits = '+00';

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
  }

  void readLocal() {
    setState(() {
      id = profileProvider.getPref(FirestoreConstants.id) ?? "";
      displayName =
          profileProvider.getPref(FirestoreConstants.displayName) ?? "";
      photoUrl = profileProvider.getPref(FirestoreConstants.photoUrl) ?? "";
      phoneNumber =
          profileProvider.getPref(FirestoreConstants.phoneNumber) ?? "";
      aboutMe = profileProvider.getPref(FirestoreConstants.aboutMe) ?? "";
    });
    displayNameController = TextEditingController(text: displayName);
    aboutMeController = TextEditingController(text: aboutMe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.profileTitle,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(photoUrl,fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                    errorBuilder: (context, object, stackTrace) {
                      return const Icon(Icons.account_circle, size: 90,
                        color: Colors.grey,);
                    },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress){
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      width: 90,
                      height: 90,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes! : null,
                        ),
                      ),
                    );
                  },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
