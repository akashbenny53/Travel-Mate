import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/database/user.dart';
import 'package:travel_app/datamodel/usermodel.dart';
import 'package:travel_app/screens/privacypolicy.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController usercontroller = TextEditingController();
  String profile = '';

  @override
  void initState() {
    if (usernotifier.value != null) {
      profile = usernotifier.value!.profile;
      usercontroller.text = usernotifier.value!.user;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await getimage().then(
                    (value) {
                      if (value != null) {
                        setState(
                          () {
                            profile = value.path;
                          },
                        );
                      }
                    },
                  );
                },
                child: profile == ''
                    ? const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(
                          'assets/user-3331257_1280.png',
                        ),
                      )
                    : CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(
                          File(profile),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.always,
                cursorColor: Colors.green.shade600,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
                controller: usercontroller,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_2_outlined,
                    color: Colors.black,
                  ),
                  hintText: 'Name',
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.green.shade600,
                      width: 3.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.green.shade600,
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    child: const Icon(
                      Icons.save,
                    ),
                    onTap: () async {
                      if (usercontroller.text.trim() != '') {
                        UserModel userModel = UserModel(
                          user: usercontroller.text,
                          profile: profile,
                        );
                        UserDb().editUser(userModel);
                        await UserDb().editUser(userModel).then(
                          (value) {
                            var snackbar = SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green.shade600,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'User details saved successfully!',
                                    ),
                                  ),
                                ],
                              ),
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(30),
                            );
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            });
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.sizeOf(context).width * .1,
              ),
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy(),
                    ),
                  );
                },
                child: Text(
                  'Privacy Policy',
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              'Presented by',
              style: GoogleFonts.lato(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            Text(
              'GARAGE 53',
              style: GoogleFonts.lato(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<XFile?> getimage() async {
    ImagePicker imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }
}
