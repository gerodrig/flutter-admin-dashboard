import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:email_validator/email_validator.dart';

import 'package:provider/provider.dart';
import 'package:admin_dashboard/providers/index.dart';

import 'package:admin_dashboard/services/index.dart';

import 'package:admin_dashboard/models/User.dart';

import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';

class UserView extends StatefulWidget {
  final String uid;

  const UserView({super.key, required this.uid});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  User? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.uid).then((user) {
      if (user != null) {
        this.user = user;
        userFormProvider.formKey = GlobalKey<FormState>();
        userFormProvider.user = user;
        setState(() {});
      } else {
        NavigationService.replaceTo('/dashboard/users');
      }
    }).catchError((error) {
      NotificationService.showSnackbarError(error.toString());
    });
  }

  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text('User View', style: CustomLabels.h1),
            const SizedBox(height: 10),
            if (user == null)
              WhiteCard(
                child: Container(
                    alignment: Alignment.center,
                    height: 300,
                    child: const Center(child: CircularProgressIndicator())),
              ),
            if (user != null) _UserViewBody()
          ],
        ));
  }
}

class _UserViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        // column width
        columnWidths: const <int, TableColumnWidth>{0: FixedColumnWidth(250)},

        children: [
          TableRow(children: [
            //Avatar
            _AvatarContainer(),

            // User info for
            _UserViewForm()
          ])
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserFormProvider userFormProvider =
        Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    return WhiteCard(
        title: 'User info ${user.email}',
        child: Form(
            // Set key
            key: userFormProvider.formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: user.name,
                  decoration: CustomInputs.formInputDecoration(
                      hint: 'User name',
                      label: 'Name',
                      icon: Icons.supervised_user_circle_outlined),
                  onChanged: (value) =>
                      userFormProvider.copyUserWith(name: value),
                  validator: nameValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: user.email,
                  decoration: CustomInputs.formInputDecoration(
                      hint: 'User email',
                      label: 'Email',
                      icon: Icons.mark_email_read_outlined),
                  onChanged: (value) =>
                      userFormProvider.copyUserWith(email: value),
                  validator: emailValidator,
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 100),
                  child: ElevatedButton(
                      onPressed: () async {
                        final saved = await userFormProvider.updateUser();

                        if (saved) {
                          NotificationService.showSnackbarSuccess(
                              'User updated');
                          // Update users
                          if (context.mounted) {
                            Provider.of<UsersProvider>(context, listen: false)
                                .refreshUser(user);
                          }
                        } else {
                          NotificationService.showSnackbarError(
                              'Cannot save user');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.save_outlined, size: 20),
                          Text(' Save')
                        ],
                      )),
                )
              ],
            )));
  }

  String? nameValidator(value) =>
      value == null || value.isEmpty || value.length < 2
          ? 'Please enter a valid name. Name must be at least 2 characters long'
          : null;

  String? emailValidator(value) => (EmailValidator.validate(value ?? ''))
      ? null
      : 'The email address must be valid';
}

class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    final image = (user.image == null || user.image!.contains('user-default'))
        ? const Image(image: AssetImage('no-image.png'))
        : FadeInImage.assetNetwork(
            placeholder: 'loader.gif', image: user.image!);

    return WhiteCard(
        width: 250,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Profile',
                style: CustomLabels.h2,
              ),
              const SizedBox(height: 20),
              SizedBox(
                  width: 150,
                  height: 160,
                  child: Stack(
                    children: [
                      ClipOval(child: image),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 5)),
                            child: FloatingActionButton(
                              backgroundColor: Colors.indigo,
                              elevation: 0,
                              child: const Icon(Icons.camera_alt_outlined,
                                  size: 20),
                              onPressed: () async {
                                // Select image
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                                  allowMultiple: false,
                                );

                                if (result != null) {
                                  // loading widget
                                  if (context.mounted) {
                                    NotificationService.showBusyIndicator(
                                        context);
                                  }
                                  final updatedUser =
                                      await userFormProvider.uploadImage(
                                          '/uploads/users/${user.uid}',
                                          result.files.first.bytes!);

                                  //end loading widget
                                  if (context.mounted) {
                                    Provider.of<UsersProvider>(context,
                                            listen: false)
                                        .refreshUser(updatedUser);
                                    Navigator.of(context).pop();
                                  }
                                } else {
                                  // User canceled the picker
                                  print('User canceled the picker');
                                }
                              },
                            ),
                          ))
                    ],
                  )),
              const SizedBox(height: 20),
              Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}
