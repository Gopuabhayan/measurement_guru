import 'package:flutter/material.dart';

class PerimeterCalculator extends StatefulWidget {
  const PerimeterCalculator({super.key});

  @override
  State<PerimeterCalculator> createState() => _PerimeterCalculatorState();
}

class _PerimeterCalculatorState extends State<PerimeterCalculator> {
  String _selectedShape = 'Rectangle';
  final Map<String, TextEditingController> _controllers = {
    'length': TextEditingController(),
    'width': TextEditingController(),
    'side': TextEditingController(),
    'radius': TextEditingController(),
    'side1': TextEditingController(),
    'side2': TextEditingController(),
    'side3': TextEditingController(),
  };
  
  String _result = '';

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _calculatePerimeter() {
    setState(() {
      try {
        double perimeter = 0;
        
        switch (_selectedShape) {
          case 'Rectangle':
            double length = double.parse(_controllers['length']!.text);
            double width = double.parse(_controllers['width']!.text);
            perimeter = 2 * (length + width);
            _result = 'Perimeter: ${perimeter.toStringAsFixed(2)} units';
            break;
            
          case 'Square':
            double side = double.parse(_controllers['side']!.text);
            perimeter = 4 * side;
            _result = 'Perimeter: ${perimeter.toStringAsFixed(2)} units';
            break;
            
          case 'Circle':
            double radius = double.parse(_controllers['radius']!.text);
            perimeter = 2 * 3.14159 * radius;
            _result = 'Circumference: ${perimeter.toStringAsFixed(2)} units';
            break;
            
          case 'Triangle':
            double side1 = double.parse(_controllers['side1']!.text);
            double side2 = double.parse(_controllers['side2']!.text);
            double side3 = double.parse(_controllers['side3']!.text);
            perimeter = side1 + side2 + side3;
            _result = 'Perimeter: ${perimeter.toStringAsFixed(2)} units';
            break;
        }
      } catch (e) {
        _result = 'Please enter valid numbers';
      }
    });
  }

  void _clearFields() {
    setState(() {
      _controllers.values.forEach((controller) => controller.clear());
      _result = '';
    });
  }

  Widget _buildInputField(String label, String controllerKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _controllers[controllerKey],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.straighten, color: Colors.blue[400]),
        ),
      ),
    );
  }

  Widget _buildShapeInputs() {
    switch (_selectedShape) {
      case 'Rectangle':
        return Column(
          children: [
            _buildInputField('Length', 'length'),
            _buildInputField('Width', 'width'),
          ],
        );
        
      case 'Square':
        return _buildInputField('Side Length', 'side');
        
      case 'Circle':
        return _buildInputField('Radius', 'radius');
        
      case 'Triangle':
        return Column(
          children: [
            _buildInputField('Side 1', 'side1'),
            _buildInputField('Side 2', 'side2'),
            _buildInputField('Side 3', 'side3'),
          ],
        );
        
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Shape',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Rectangle', 'Square', 'Circle', 'Triangle']
                        .map((shape) => ChoiceChip(
                              label: Text(shape),
                              selected: _selectedShape == shape,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedShape = shape;
                                    _clearFields();
                                  });
                                }
                              },
                              selectedColor: Colors.blue[400],
                              labelStyle: TextStyle(
                                color: _selectedShape == shape
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Measurements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildShapeInputs(),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _calculatePerimeter,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[500],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _clearFields,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          if (_result.isNotEmpty)
            Card(
              elevation: 4,
              color: Colors.blue[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[600],
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: 20),
          
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[600]),
                      const SizedBox(width: 8),
                      Text(
                        'Formulas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFormulaItem('Rectangle', '2 × (Length + Width)'),
                  _buildFormulaItem('Square', '4 × Side'),
                  _buildFormulaItem('Circle', '2 × π × Radius'),
                  _buildFormulaItem('Triangle', 'Side1 + Side2 + Side3'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaItem(String shape, String formula) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$shape: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Text(
            formula,
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}


class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  String _selectedShape = 'Rectangle';
  final Map<String, TextEditingController> _controllers = {
    'length': TextEditingController(),
    'width': TextEditingController(),
    'side': TextEditingController(),
    'radius': TextEditingController(),
    'base': TextEditingController(),
    'height': TextEditingController(),
  };
  
  String _result = '';

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _calculateArea() {
    setState(() {
      try {
        double area = 0;
        
        switch (_selectedShape) {
          case 'Rectangle':
            double length = double.parse(_controllers['length']!.text);
            double width = double.parse(_controllers['width']!.text);
            area = length * width;
            _result = 'Area: ${area.toStringAsFixed(2)} sq units';
            break;
            
          case 'Square':
            double side = double.parse(_controllers['side']!.text);
            area = side * side;
            _result = 'Area: ${area.toStringAsFixed(2)} sq units';
            break;
            
          case 'Circle':
            double radius = double.parse(_controllers['radius']!.text);
            area = 3.14159 * radius * radius;
            _result = 'Area: ${area.toStringAsFixed(2)} sq units';
            break;
            
          case 'Triangle':
            double base = double.parse(_controllers['base']!.text);
            double height = double.parse(_controllers['height']!.text);
            area = 0.5 * base * height;
            _result = 'Area: ${area.toStringAsFixed(2)} sq units';
            break;
        }
      } catch (e) {
        _result = 'Please enter valid numbers';
      }
    });
  }

  void _clearFields() {
    setState(() {
      _controllers.values.forEach((controller) => controller.clear());
      _result = '';
    });
  }

  Widget _buildInputField(String label, String controllerKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _controllers[controllerKey],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.crop_square, color: Colors.green[400]),
        ),
      ),
    );
  }

  Widget _buildShapeInputs() {
    switch (_selectedShape) {
      case 'Rectangle':
        return Column(
          children: [
            _buildInputField('Length', 'length'),
            _buildInputField('Width', 'width'),
          ],
        );
        
      case 'Square':
        return _buildInputField('Side Length', 'side');
        
      case 'Circle':
        return _buildInputField('Radius', 'radius');
        
      case 'Triangle':
        return Column(
          children: [
            _buildInputField('Base', 'base'),
            _buildInputField('Height', 'height'),
          ],
        );
        
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Shape',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Rectangle', 'Square', 'Circle', 'Triangle']
                        .map((shape) => ChoiceChip(
                              label: Text(shape),
                              selected: _selectedShape == shape,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedShape = shape;
                                    _clearFields();
                                  });
                                }
                              },
                              selectedColor: Colors.blue[400],
                              labelStyle: TextStyle(
                                color: _selectedShape == shape
                                    ? Colors.white
                                    : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Measurements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildShapeInputs(),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _calculateArea,
                  icon: const Icon(Icons.calculate),
                  label: const Text('Calculate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[500],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _clearFields,
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          if (_result.isNotEmpty)
            Card(
              elevation: 4,
              color: Colors.green[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue[600],
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          
          const SizedBox(height: 20),
          
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.green[600]),
                      const SizedBox(width: 8),
                      Text(
                        'Formulas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFormulaItem('Rectangle', 'Length × Width'),
                  _buildFormulaItem('Square', 'Side × Side'),
                  _buildFormulaItem('Circle', 'π × Radius²'),
                  _buildFormulaItem('Triangle', '½ × Base × Height'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaItem(String shape, String formula) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$shape: ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Text(
            formula,
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}