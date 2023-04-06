import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = "unknown";
  double weight = 0;
  double height = 0;
  double bmi = 0;

  Color? statusColor = Colors.black;

  final weightController = TextEditingController();
  final heightController = TextEditingController();

  void calculateBmi() {
    weight = double.parse(weightController.text);
    height = double.parse(heightController.text);

    double heightInMeter = height / 100;

    bmi = weight / (heightInMeter * heightInMeter);

    if (bmi < 17) {
      status = "Kurus";
      statusColor = Colors.teal;
    } else if (bmi >= 17 && bmi <= 18.4) {
      status = "Kurus";
      statusColor = Colors.orange;
    } else if (bmi >= 18.5 && bmi <= 25) {
      status = "Normal";
      statusColor = Colors.green;
    } else if (bmi >= 25.1 && bmi <= 27) {
      status = "Gemuk";
      statusColor = Colors.red;
    } else {
      status = "Obesitas";
      statusColor = Colors.red[900];
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator IMT"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 24,
                  color: statusColor,
                ),
              ),
              Text("IMT: $bmi")
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: TextField(
              controller: weightController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter weight (kg)",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: TextField(
              controller: heightController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter height (cm)",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                calculateBmi();
              });
            },
            child: const Text("Calculate"),
          )
        ],
      ),
    );
  }
}
