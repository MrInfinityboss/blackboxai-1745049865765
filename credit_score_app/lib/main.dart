import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(CreditScoreApp());
}

class CreditScoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Score Builder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  void navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Score Builder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: FaIcon(FontAwesomeIcons.wallet),
              label: Text('Build Credit Score'),
              onPressed: () => navigateTo(context, BuildCreditScoreScreen()),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: FaIcon(FontAwesomeIcons.chartLine),
              label: Text('Improve Credit Score'),
              onPressed: () => navigateTo(context, ImproveCreditScoreScreen()),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCreditScoreScreen extends StatefulWidget {
  @override
  _BuildCreditScoreScreenState createState() => _BuildCreditScoreScreenState();
}

class _BuildCreditScoreScreenState extends State<BuildCreditScoreScreen> {
  double creditScore = 300;
  double paymentAmount = 10;

  void makePayment() {
    setState(() {
      // Simulate credit score increase with each payment
      creditScore = (creditScore + paymentAmount * 0.5).clamp(300, 850);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment of \$${paymentAmount.toStringAsFixed(2)} made!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Credit Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Current Credit Score: ${creditScore.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: paymentAmount,
              min: 1,
              max: 50,
              divisions: 49,
              label: '\$${paymentAmount.toStringAsFixed(0)}',
              onChanged: (value) {
                setState(() {
                  paymentAmount = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: makePayment,
              child: Text('Make Payment'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImproveCreditScoreScreen extends StatelessWidget {
  final List<String> tips = [
    'Pay your bills on time.',
    'Keep credit card balances low.',
    'Avoid opening too many new accounts.',
    'Check your credit report regularly.',
    'Don’t close old credit accounts.',
    'Diversify your credit mix.',
    'Limit hard inquiries on your credit report.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Improve Credit Score'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: tips.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: FaIcon(FontAwesomeIcons.lightbulb),
              title: Text(tips[index]),
            );
          },
        ),
      ),
    );
  }
}
