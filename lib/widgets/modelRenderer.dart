import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const ModelRenderer());
}

class ModelRenderer extends StatelessWidget {
  const ModelRenderer({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('3D Model')),
        body: const ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: 'lib/assets/3dmodels/volvoS90.glb',
          alt: 'Ein 3D Modell eines Autos',
          ar: false,
          autoRotate: false,
          disableZoom: false,
        ),
      );
  }
}
