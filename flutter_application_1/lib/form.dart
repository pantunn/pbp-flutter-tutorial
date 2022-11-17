import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart' as data;
import 'package:flutter/services.dart';

class BudgetForm extends StatefulWidget {
  const BudgetForm({super.key});

  @override
  State<StatefulWidget> createState() => _BudgetFormState();
}


class _BudgetFormState extends State<BudgetForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _listType = ["Pemasukan", "Pengeluaran"];
  String? _title;
  int? _nominal;
  String? _type;
  DateTime _dateTime = DateTime.now();
  final _titleController = TextEditingController();
  final _nominalController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Budget'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Title
                Padding(
                  // Using padding of 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Beli baso",
                      labelText: "Judul",
                      // Added a circular border to make it neater
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Added behavior when name is typed
                    onChanged: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    // Added behavior when data is saved
                    onSaved: (String? value) {
                      setState(() {
                        _title = value!;
                      });
                    },
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi judul!';
                      }
                      return null;
                    },
                  ),
                ),

                // Nominal
                Padding(
                  // Using padding of 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nominalController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "111111",
                      labelText: "Nominal",
                      prefix: const Text("Rp"),
                      // Added a circular border to make it neater
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Added behavior when name is typed
                    onChanged: (String? value) {
                      setState(() {
                        _nominal = int.parse(value!);
                      });
                    },
                    // Added behavior when data is saved
                    onSaved: (String? value) {
                      setState(() {
                        _nominal = int.parse(value!);
                      });
                    },
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi nominal!';
                      }
                      return null;
                    },
                  ),
                ),

                // Date
                Padding(
                  // Using padding of 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: _dateController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.calendar_today),
                      labelText: "Date",
                      // Added a circular border to make it neater
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      ).then((date) {
                        setState(() {
                          _dateTime = date!;
                          _dateController.text = "${_dateTime.year.toString()}-${_dateTime.month.toString().padLeft(2,'0')}-${_dateTime.day.toString().padLeft(2,'0')}";
                        });
                      });
                    },
                  ),
                ),

                // Dropdown
                Padding(
                  // Using padding of 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: _type,
                    elevation: 16,
                    hint: const Text("Pilih Jenis"),
                    onChanged: (String? value){
                      setState(() {
                        _type = value!;
                      });
                    },
                    items: _listType.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    // Validator as form validation
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Mohon isi jenis budget!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            data.listBudget.add(
                data.Budget(
                    title: _title!,
                    nominal: _nominal!,
                    type: _type!,
                    date: _dateTime,
                )
            );
            _titleController.clear();
            _nominalController.clear();
            final successBar = SnackBar(
                content: const Text("Budget berhasil disimpan!"),
                action: SnackBarAction(
                  label: 'Hide',
                  onPressed: () {

                  },
                ),
            );
            ScaffoldMessenger.of(context).showSnackBar(successBar);
          }
        },
        child:
          const Text(
            "Simpan",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
      ),
    );
  }
}