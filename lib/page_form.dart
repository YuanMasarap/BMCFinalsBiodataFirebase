import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Subject Enrollment',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController();
  final sectionController = TextEditingController();
  final courseController = TextEditingController();

  void nextPage() {
    if (nameController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectEnrollmentPage(
          name: nameController.text.trim(),
          section: sectionController.text.trim(),
          course: courseController.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Registration'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Student Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: sectionController,
              decoration: const InputDecoration(
                labelText: 'Section',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.class_),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: courseController,
              decoration: const InputDecoration(
                labelText: 'Course',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school),
              ),
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: nextPage,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectEnrollmentPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  const SubjectEnrollmentPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
  });

  @override
  State<SubjectEnrollmentPage> createState() => _SubjectEnrollmentPageState();
}

class _SubjectEnrollmentPageState extends State<SubjectEnrollmentPage> {
  final subject1Controller = TextEditingController();
  final subject2Controller = TextEditingController();

  TimeOfDay? time1;
  TimeOfDay? time2;

  Future<void> selectTime(int subjectNumber) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null && mounted) {
      setState(() {
        if (subjectNumber == 1) {
          time1 = selectedTime;
        } else {
          time2 = selectedTime;
        }
      });
    }
  }

  void nextPage() {
    if (subject1Controller.text.trim().isEmpty ||
        subject2Controller.text.trim().isEmpty ||
        time1 == null ||
        time2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both subjects and their times'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectVerificationPage(
          name: widget.name,
          section: widget.section,
          course: widget.course,
          subject1: subject1Controller.text.trim(),
          time1: time1!.format(context),
          subject2: subject2Controller.text.trim(),
          time2: time2!.format(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    subject1Controller.dispose();
    subject2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Enrollment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'First Subject',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: subject1Controller,
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => selectTime(1),
                icon: const Icon(Icons.access_time),
                label: Text(
                  time1 == null
                      ? 'Select First Subject Time'
                      : 'Time: ${time1!.format(context)}',
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Second Subject',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: subject2Controller,
              decoration: const InputDecoration(
                labelText: 'Subject Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => selectTime(2),
                icon: const Icon(Icons.access_time),
                label: Text(
                  time2 == null
                      ? 'Select Second Subject Time'
                      : 'Time: ${time2!.format(context)}',
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: nextPage,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectVerificationPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;
  final String subject1;
  final String time1;
  final String subject2;
  final String time2;

  const SubjectVerificationPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
    required this.subject1,
    required this.time1,
    required this.subject2,
    required this.time2,
  });

  @override
  State<SubjectVerificationPage> createState() =>
      _SubjectVerificationPageState();
}

class _SubjectVerificationPageState extends State<SubjectVerificationPage> {
  bool isSaving = false;

  Future<void> saveData() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      await FirebaseFirestore.instance.collection('enrollments').add({
        'name': widget.name,
        'section': widget.section,
        'course': widget.course,
        'subject1': widget.subject1,
        'time1': widget.time1,
        'subject2': widget.subject2,
        'time2': widget.time2,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enrollment saved successfully!')),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save enrollment: $e')));
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Widget detail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Verification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.fact_check, size: 60, color: Colors.blue),
            ),
            const SizedBox(height: 15),

            const Center(
              child: Text(
                'Subject Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),

            detail('Name:', widget.name),
            detail('Section:', widget.section),
            detail('Course:', widget.course),

            const Divider(),

            detail('First Subject:', widget.subject1),
            detail('First Subject Time:', widget.time1),

            const Divider(),

            detail('Second Subject:', widget.subject2),
            detail('Second Subject Time:', widget.time2),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: isSaving ? null : saveData,
                icon: const Icon(Icons.save),
                label: Text(
                  isSaving ? 'Please wait...Saving...' : 'Save to Firebase',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
