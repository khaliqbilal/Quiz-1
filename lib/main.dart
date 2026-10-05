import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Registration Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const RegistrationFormScreen(),
    );
  }
}

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  // TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regController = TextEditingController();

  // 4. Radio Button - Gender
  String _selectedGender = 'Male';

  // 5. Checkboxes - Hobbies
  bool _readingChecked = false;
  bool _sportsChecked = false;

  // 6. Option List
  String _selectedOption = 'Option A';
  final List<String> _optionList = ['Option A', 'Option B', 'Option C'];

  // 7. Selection List (multi-select)
  final List<bool> _selectionListChecked = [false, false, false];
  final List<String> _selectionItems = ['Item 1', 'Item 2', 'Item 3'];

  // 8. Dropdown - Department
  String _selectedDepartment = 'CS';
  final List<String> _departments = ['CS', 'IT', 'SE', 'AI'];

  // Submit result message
  String _submitMessage = '';

  @override
  void dispose() {
    _nameController.dispose();
    _regController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final name = _nameController.text.trim();
    final reg = _regController.text.trim();
    final hobbies = <String>[];
    if (_readingChecked) hobbies.add('Reading');
    if (_sportsChecked) hobbies.add('Sports');
    final selectedItems = <String>[];
    for (int i = 0; i < _selectionItems.length; i++) {
      if (_selectionListChecked[i]) selectedItems.add(_selectionItems[i]);
    }
    setState(() {
      _submitMessage = 'Submitted!\n'
          'Name: $name\n'
          'Reg No: $reg\n'
          'Gender: $_selectedGender\n'
          'Hobbies: ${hobbies.isEmpty ? "None" : hobbies.join(", ")}\n'
          'Option: $_selectedOption\n'
          'Selected Items: ${selectedItems.isEmpty ? "None" : selectedItems.join(", ")}\n'
          'Department: $_selectedDepartment';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form Submitted! Name: $name, Reg: $reg'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSC303 - Quiz 1'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Text - Heading
              const Text(
                'Student Registration Form',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // 2. TextField - Student Name
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. TextField - Registration Number
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _regController,
                  decoration: const InputDecoration(
                    labelText: 'Registration Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Radio Button - Gender (using RadioGroup + RadioListTile)
              const Text(
                'Select Gender:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioGroup<String>(
                groupValue: _selectedGender,
                onChanged: (value) {
                  if (value != null) setState(() => _selectedGender = value);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    RadioListTile<String>(
                      value: 'Male',
                      title: Text('Male'),
                      dense: true,
                    ),
                    RadioListTile<String>(
                      value: 'Female',
                      title: Text('Female'),
                      dense: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 5. Checkboxes - Hobbies
              const Text(
                'Select Hobbies:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _readingChecked,
                    onChanged: (value) => setState(() => _readingChecked = value!),
                  ),
                  const Text('Reading'),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: _sportsChecked,
                    onChanged: (value) => setState(() => _sportsChecked = value!),
                  ),
                  const Text('Sports'),
                ],
              ),
              const SizedBox(height: 16),

              // 6. Option List (RadioGroup + RadioListTile)
              const Text(
                'Option List:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              RadioGroup<String>(
                groupValue: _selectedOption,
                onChanged: (value) {
                  if (value != null) setState(() => _selectedOption = value);
                },
                child: Column(
                  children: _optionList
                      .map((opt) => RadioListTile<String>(
                            value: opt,
                            title: Text(opt),
                            dense: true,
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),

              // 7. Selection List (multi-select checkboxes)
              const Text(
                'Selection List:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children: List.generate(_selectionItems.length, (index) {
                  return CheckboxListTile(
                    title: Text(_selectionItems[index]),
                    value: _selectionListChecked[index],
                    onChanged: (value) =>
                        setState(() => _selectionListChecked[index] = value!),
                    controlAffinity: ListTileControlAffinity.leading,
                    dense: true,
                  );
                }),
              ),
              const SizedBox(height: 16),

              // 8. Dropdown - Department
              const Text(
                'Select Department:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedDepartment,
                items: _departments
                    .map((dept) => DropdownMenuItem<String>(value: dept, child: Text(dept)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDepartment = value!),
              ),
              const SizedBox(height: 20),

              // 9. Button
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Button Pressed!')),
                  );
                },
                child: const Text('Click Me'),
              ),
              const SizedBox(height: 10),

              // 10. Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: _onSubmit,
                child: const Text('Submit', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),

              // Result display
              if (_submitMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _submitMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
