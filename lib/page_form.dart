import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController civilStatusController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {
    if (nameController.text.trim().isEmpty ||
        ageController.text.trim().isEmpty ||
        birthdayController.text.trim().isEmpty ||
        genderController.text.trim().isEmpty ||
        civilStatusController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await firestore.collection('students').add({
      'name': nameController.text.trim(),
      'age': ageController.text.trim(),
      'birthday': birthdayController.text.trim(),
      'gender': genderController.text.trim(),
      'civilStatus': civilStatusController.text.trim(),
      'address': addressController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'course': courseController.text.trim(),
      'section': sectionController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data saved successfully')));

    nameController.clear();
    ageController.clear();
    birthdayController.clear();
    genderController.clear();
    civilStatusController.clear();
    addressController.clear();
    phoneController.clear();
    emailController.clear();
    courseController.clear();
    sectionController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    birthdayController.dispose();
    genderController.dispose();
    civilStatusController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    courseController.dispose();
    sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Biodata Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Personal Information',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Age',
                prefixIcon: const Icon(Icons.cake),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: birthdayController,
              decoration: InputDecoration(
                labelText: 'Birthday',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: civilStatusController,
              decoration: InputDecoration(
                labelText: 'Civil Status',
                prefixIcon: const Icon(Icons.favorite),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: addressController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: const Icon(Icons.home),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: courseController,
              decoration: InputDecoration(
                labelText: 'Course',
                prefixIcon: const Icon(Icons.school),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: sectionController,
              decoration: InputDecoration(
                labelText: 'Section',
                prefixIcon: const Icon(Icons.class_),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: saveData,
                icon: const Icon(Icons.save),
                label: const Text(
                  'Save to Firebase',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
