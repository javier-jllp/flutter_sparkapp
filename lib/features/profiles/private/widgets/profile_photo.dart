import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sparkapp/features/profiles/private/bloc/profile_event.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';

import '../bloc/profile_bloc.dart';
import '../my_profile_screen.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

Widget profilePhoto(
    MyProfileBloc bloc, BuildContext context, String urlProfilePhoto) {
  return Row(
    children: [
      _buildProfilePhoto(urlProfilePhoto),
      const Spacer(),
      ProfilePhotoWidget(bloc: bloc),
    ],
  );
}

Widget _buildProfilePhoto(String urlProfilePhoto) {
  return SizedBox(
    width: 200, // Ajusta el tamaño según tus necesidades
    height: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(100), // Circular
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500), // Duración de la animación
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: CachedNetworkImage(
          key: ValueKey(urlProfilePhoto), // Key para la animación
          imageUrl: urlProfilePhoto,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => const Center(
              // Animación de carga
              child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )),
          errorWidget: (context, url, error) => const Center(
            // Manejo de errores
            child: Icon(Icons.error, color: Colors.red),
          ),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}


class ProfilePhotoWidget extends StatefulWidget {
  final MyProfileBloc bloc;

  const ProfilePhotoWidget({super.key, required this.bloc});

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... (Tu código para mostrar la foto de perfil actual) ...

        ElevatedButton(
          onPressed: () => _showImagePicker(context),
          child: const Text('Cambiar foto de perfil'),
        ),
      ],
    );
  }

  Future<void> _showImagePicker(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) => ImagePickerSheet(picker: picker),
    );

    if (pickedImage != null && mounted) {
      _handleImagePicked(context, File(pickedImage.path));
    }
  }

  void _handleImagePicked(BuildContext context, File image) {
    setState(() {
      _selectedImage = image;
    });
    _showConfirmationDialog(widget.bloc, _selectedImage!, context);
  }
}

class ImagePickerSheet extends StatelessWidget {
  final ImagePicker picker;

  const ImagePickerSheet({super.key, required this.picker});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Tomar foto'),
          onTap: () async {
            final XFile? image = await picker.pickImage(source: ImageSource.camera);
            Navigator.pop(context, image);
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Seleccionar de la galería'),
          onTap: () async {
            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
            Navigator.pop(context, image);
          },
        ),
      ],
    );
  }
}


void _showConfirmationDialog(
    MyProfileBloc bloc, File file, BuildContext context) {
  if (file.path.isEmpty) {
    // Manejo de error: archivo nulo
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error: No se seleccionó ningún archivo.')));
    return;
  }
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar cambio de foto de perfil'),
        content: SingleChildScrollView(
          // Permite scroll si el path es largo
          child: Text(
              '¿Está seguro de actualizar la foto de perfil con:\n${file.path}?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              try {
                bloc.add(UpdateProfilePhotoEvent(file: file));
                Navigator.of(context).pop();
              } catch (e) {
                // Manejo de error al agregar el evento al Bloc
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al actualizar la foto: $e')));
              }
            },
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
}