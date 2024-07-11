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
        src: '../3dmodels/gtrrsas.glb',
        alt: 'Ein 3D Modell eines Autos',
        ar: false,
        autoRotate: true,
        disableZoom: false,
      ),
    );
  }
}
