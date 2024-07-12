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
        src:
            'https://sketchfab.com/3d-models/gtr-dcc83e99b0bf429ea04e87604388ce2b',
        alt: 'Ein 3D Modell eines Autos',
        ar: false,
        autoRotate: true,
        disableZoom: false,
      ),
    );
  }
}
