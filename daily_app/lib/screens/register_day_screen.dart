import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../widgets/select_emotions.dart'; // Asegúrate de que esta sea la ruta correcta para el widget

class RegisterDayScreen extends StatefulWidget {
  const RegisterDayScreen({Key? key}) : super(key: key);

  @override
  State<RegisterDayScreen> createState() => _RegisterDayScreenState();
}

class _RegisterDayScreenState extends State<RegisterDayScreen> {
  String? _username = "";
  final TextEditingController _textController = TextEditingController();
  int _characterLimit = 180;
  bool _allowMultipleImages = false;
  List<File?> _selectedImages = [];
  bool _isPro = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadText();
    _loadImages();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    bool isPro = prefs.getBool('isPro') ?? false;
    print("Estado Pro desde SharedPreferences: $isPro");

    setState(() {
      _username = name;
      _isPro = isPro;
      _applyProSettings();
    });
  }

  void _applyProSettings() {
    if (_isPro) {
      _characterLimit = 500;
      _allowMultipleImages = true;
      print("Ajustes aplicados: Pro activado - Límite de caracteres: $_characterLimit, Múltiples imágenes permitidas: $_allowMultipleImages");
    } else {
      _characterLimit = 180;
      _allowMultipleImages = false;
      print("Ajustes aplicados: Pro desactivado - Límite de caracteres: $_characterLimit, Múltiples imágenes permitidas: $_allowMultipleImages");
    }
  }

  Future _saveText() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('dailyText', _textController.text);
  }

  Future _loadText() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textController.text = prefs.getString('dailyText') ?? '';
    });
  }

  Future _loadImages() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedImages = prefs.getStringList('selectedImages');
    if (savedImages != null) {
      setState(() {
        _selectedImages = savedImages.map((path) => File(path)).toList();
      });
    }
  }

  Future _saveImages() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> imagePaths = _selectedImages.whereType<File>().map((file) => file.path).toList();
    await prefs.setStringList('selectedImages', imagePaths);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [AndroidUiSettings(toolbarTitle: 'Recorta tu imagen')],
      );

      if (croppedFile != null) {
        setState(() {
          _allowMultipleImages ? _selectedImages.add(File(croppedFile.path)) : _selectedImages = [File(croppedFile.path)];
        });
        _saveImages();
      }
    }
  }

  void _showImageSourceSelection() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Tomar una foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Seleccionar de la galería'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registra tu día $_username'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
           // Agregado el selector de emociones
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextFormField(
              controller: _textController,
              maxLength: _characterLimit,
              decoration: InputDecoration(
                labelText: 'Describe tu día',
                border: OutlineInputBorder(),
                counterText: '${_textController.text.length}/$_characterLimit caracteres',
              ),
              maxLines: 5,
              onChanged: (text) => _saveText(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var image in _selectedImages)
                  if (image != null)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
              onPressed: _selectedImages.length < (_allowMultipleImages ? 3 : 1) ? _showImageSourceSelection : null,
              child: Text('Seleccionar Imagen'),
            ),
          ),
        ],
      ),
    );
  }
}
