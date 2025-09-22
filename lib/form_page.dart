import 'package:flutter/material.dart';
import 'rdf_generator.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final identifierController = TextEditingController();
  final themeController = TextEditingController();
  final themeURIController = TextEditingController();
  final keywordsController = TextEditingController();
  final issuedController = TextEditingController();
  final modifiedController = TextEditingController();
  final temporalStartController = TextEditingController();
  final temporalEndController = TextEditingController();
  final spatialController = TextEditingController();
  final frequencyController = TextEditingController();
  final languageController = TextEditingController();

  // Editor
  final publisherNameController = TextEditingController();
  final publisherTypeController = TextEditingController();
  final publisherEmailController = TextEditingController();

  // Distribution
  final distTitleController = TextEditingController();
  final formatController = TextEditingController(text: 'CSV');
  final downloadURLController = TextEditingController();
  final licenseController = TextEditingController();
  final sizeController = TextEditingController();

  String format = 'CSV';
  String rdfOutput = '';

  void generateRDF() {
    final rdf = generateRdfFile(
      title: titleController.text,
      description: descriptionController.text,
      identifier: identifierController.text,
      theme: themeController.text,
      themeURI: themeURIController.text,
      keywords: keywordsController.text.split(','),
      issued: issuedController.text,
      modified: modifiedController.text,
      temporalStart: temporalStartController.text,
      temporalEnd: temporalEndController.text,
      spatial: spatialController.text,
      frequency: frequencyController.text,
      language: languageController.text,
      publisherName: publisherNameController.text,
      publisherType: publisherTypeController.text,
      publisherEmail: publisherEmailController.text,
      distTitle: distTitleController.text,
      format: format,
      downloadURL: downloadURLController.text,
      license: licenseController.text,
      size: sizeController.text,
    );
    setState(() {
      rdfOutput = rdf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generador DCAT-AP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Título')),
            TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción')),
            TextFormField(
                controller: identifierController,
                decoration:
                    const InputDecoration(labelText: 'Identificador (URI)')),
            TextFormField(
                controller: themeController,
                decoration: const InputDecoration(labelText: 'Tema')),
            TextFormField(
                controller: themeURIController,
                decoration: const InputDecoration(labelText: 'Tema (URI)')),
            TextFormField(
                controller: keywordsController,
                decoration: const InputDecoration(
                    labelText: 'Palabras clave (separadas por coma)')),
            TextFormField(
                controller: issuedController,
                decoration: const InputDecoration(
                    labelText: 'Fecha de publicación (YYYY-MM-DD)')),
            TextFormField(
                controller: modifiedController,
                decoration: const InputDecoration(
                    labelText: 'Fecha de modificación (YYYY-MM-DD)')),
            TextFormField(
                controller: temporalStartController,
                decoration: const InputDecoration(
                    labelText: 'Cobertura temporal - inicio (YYYY-MM-DD)')),
            TextFormField(
                controller: temporalEndController,
                decoration: const InputDecoration(
                    labelText: 'Cobertura temporal - fin (YYYY-MM-DD)')),
            TextFormField(
                controller: spatialController,
                decoration:
                    const InputDecoration(labelText: 'Cobertura espacial')),
            TextFormField(
                controller: frequencyController,
                decoration: const InputDecoration(
                    labelText: 'Frecuencia de actualización')),
            TextFormField(
                controller: languageController,
                decoration: const InputDecoration(labelText: 'Idioma')),
            const SizedBox(height: 20),
            const Text('Datos del Editor',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
                controller: publisherNameController,
                decoration: const InputDecoration(labelText: 'Nombre')),
            TextFormField(
                controller: publisherTypeController,
                decoration: const InputDecoration(labelText: 'Tipo')),
            TextFormField(
                controller: publisherEmailController,
                decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 20),
            const Text('Datos de la Distribución',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
                controller: distTitleController,
                decoration: const InputDecoration(labelText: 'Título')),
            DropdownButtonFormField<String>(
              value: format,
              items: ['CSV', 'JSON', 'XML']
                  .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                  .toList(),
              onChanged: (val) => setState(() => format = val!),
              decoration: const InputDecoration(labelText: 'Formato'),
            ),
            TextFormField(
                controller: downloadURLController,
                decoration: const InputDecoration(labelText: 'URL de acceso')),
            TextFormField(
                controller: licenseController,
                decoration: const InputDecoration(labelText: 'Licencia')),
            TextFormField(
                controller: sizeController,
                decoration: const InputDecoration(labelText: 'Tamaño')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: generateRDF, child: const Text('Generar RDF')),
            const SizedBox(height: 20),
            const Text('RDF generado:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SelectableText(rdfOutput),
          ]),
        ),
      ),
    );
  }
}
