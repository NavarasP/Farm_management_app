import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cluck_connect/services/api/authentication_api.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({Key? key}) : super(key: key);

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;
  late String _area;
  late String _state;
  late String _phoneNumber;
  late String _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Area'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your area';
                  }
                  return null;
                },
                onSaved: (value) => _area = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
                onSaved: (value) => _state = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => _phoneNumber = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
                onSaved: (value) => _gender = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      final Map<String, dynamic> updatedProfile = {
                        'name': _name,
                        'area': _area,
                        'state': _state,
                        'phoneNumber': int.parse(_phoneNumber),
                        'gender': _gender,
                      };
                      final jsonString = jsonEncode(updatedProfile);
                      await AuthenticationApi.updateMyUser(jsonString);
                      Navigator.of(context).pop();
                    } catch (e) {
                      debugPrint('Failed to update profile: $e');
                    }
                  }
                },
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
