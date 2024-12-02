import 'package:flutter/material.dart';

class ActivitiesSelector extends StatefulWidget {
  final String title; // Parámetro para el texto de la tarjeta

  const ActivitiesSelector({
    Key? key,
    required this.title, // Requerimos el texto personalizado como parámetro
  }) : super(key: key);

  @override
  _ActivitiesSelectorState createState() => _ActivitiesSelectorState();
}

class _ActivitiesSelectorState extends State<ActivitiesSelector> {
  int? _selectedContainerIndex;

  void _onContainerTap(int index) {
    setState(() {
      _selectedContainerIndex = index; // Actualiza el índice del contenedor seleccionado
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
          Text(widget.title), // Usa el texto personalizado aquí
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                GestureDetector(
                  onTap: () => _onContainerTap(i),
                  child: Opacity(
                    opacity: _selectedContainerIndex == i ? 1.0 : 0.5,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle, // Contenedor circular
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 4; i < 8; i++)
                GestureDetector(
                  onTap: () => _onContainerTap(i),
                  child: Opacity(
                    opacity: _selectedContainerIndex == i ? 1.0 : 0.5,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle, // Contenedor circular
                      ),
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
