import 'package:flutter/material.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';

Widget fullName( MyProfileBloc bloc, BuildContext context, String fullName) {
  return Row(
    children: [
      const Icon(Icons.person),
      const SizedBox(width: 8),
      Text(
        fullName,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      const Spacer(),
      IconButton(
          onPressed: () {
            updateFullName(bloc, context, fullName);
          },
          icon: const Icon(Icons.edit))
    ],
  );
}


void updateFullName(MyProfileBloc bloc, BuildContext context, String fullName) {
  String? _newFullName = fullName; // Inicializa con el nombre actual

  showDialog(
    context: context,
    builder: (context) => AnimatedDialog( // Usa un AnimatedDialog personalizado
      child: AlertDialog(
        title: const Text('Update Full Name'),
        content: TextField(
          controller: TextEditingController(text: fullName), // Usa un TextEditingController
          decoration: const InputDecoration(hintText: 'Enter new full name'),
          onChanged: (value) => _newFullName = value, // Actualiza _newFullName
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Simplifica la navegación
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_newFullName != null && _newFullName != fullName) { // Evita actualizaciones sin cambios
                bloc.add(UpdateFullNameEvent(fullName: _newFullName!));
                Navigator.of(context).pop(); // Simplifica la navegación
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}


class AnimatedDialog extends StatefulWidget {
  final Widget child;

  const AnimatedDialog({Key? key, required this.child}) : super(key: key);

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Duración de la animación
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Curva de animación suave
      ),
    );
    _controller.forward(); // Iniciar la animación
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}