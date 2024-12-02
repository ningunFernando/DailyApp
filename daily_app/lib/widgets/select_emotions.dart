import 'package:flutter/material.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({Key? key}) : super(key: key);

  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  int? _selectedImageIndex;

  void _onImageTap(int index) {
    setState(() {
      _selectedImageIndex = index; // Actualiza el índice de la imagen seleccionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('¿Cómo estuvo tu día?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Imagen 1
              GestureDetector(
                onTap: () => _onImageTap(0),
                child: Opacity(
                  opacity: _selectedImageIndex == 0 ? 1.0 : 0.5,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    height: 50,
                    child: Image.asset('images/IconoApp.png'),
                  ),
                ),
              ),
              // Imagen 2
              GestureDetector(
                onTap: () => _onImageTap(1),
                child: Opacity(
                  opacity: _selectedImageIndex == 1 ? 1.0 : 0.5,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    height: 50,
                    child: Image.asset('images/serios.png'),
                  ),
                ),
              ),
              // Imagen 3
              GestureDetector(
                onTap: () => _onImageTap(2),
                child: Opacity(
                  opacity: _selectedImageIndex == 2 ? 1.0 : 0.5,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    height: 50,
                    child: Image.asset('images/meh.png'),
                  ),
                ),
              ),
              // Imagen 4
              GestureDetector(
                onTap: () => _onImageTap(3),
                child: Opacity(
                  opacity: _selectedImageIndex == 3 ? 1.0 : 0.5,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, right: 20),
                    height: 50,
                    child: Image.asset('images/angry.png'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
