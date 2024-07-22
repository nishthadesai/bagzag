import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_structure/values/colors.dart';
import 'package:image_picker/image_picker.dart';

import '../../../router/app_router.dart';
import '../../../values/app_class.dart';

@RoutePage()
class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  @override
  void initState() {
    _openCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
    );
  }
}

Future<void> _openCamera() async {
  AppClass().showLoading(true);
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  AppClass().showLoading(false);
  if (image != null) {
    final String path = image.path;
    appRouter.push(AddProductInfoRoute(path: '$path'));
  } else {
    appRouter.maybePop();
    print('No image selected.');
  }
}
