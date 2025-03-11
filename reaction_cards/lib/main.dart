import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tepki Kartları',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple[800],
        hintColor: Colors.deepPurple[300],
        scaffoldBackgroundColor: Colors.deepPurple[900],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.deepPurple[600],
          textTheme: ButtonTextTheme.primary,
        ),
        cardColor: Colors.deepPurple[800],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple[600],
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      home: const LobbyPage(),
    );
  }
}

class LobbyPage extends StatefulWidget {
  const LobbyPage({super.key});

  @override
  State<LobbyPage> createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  final TextEditingController _roomCodeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _createRoom() async {
    String roomCode = (Random().nextInt(9000) + 1000).toString();
    await _firestore.collection('rooms').doc(roomCode).set({
      'currentSituation': '',
      'players': [],
      'isGameStarted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(roomCode: roomCode, isHost: true),
        ),
      );
    }
  }

  void _joinRoom() async {
    String roomCode = _roomCodeController.text.trim();
    DocumentSnapshot room =
        await _firestore.collection('rooms').doc(roomCode).get();

    if (room.exists) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GamePage(roomCode: roomCode, isHost: false),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Oda bulunamadı!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tepki Kartları - Lobi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _createRoom,
                child: const Text('Yeni Oda Oluştur'),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _roomCodeController,
                decoration: const InputDecoration(
                  labelText: 'Oda Kodu',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _joinRoom,
                child: const Text('Odaya Katıl'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final String roomCode;
  final bool isHost;

  const GamePage({super.key, required this.roomCode, required this.isHost});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final List<String> situations = [
    'Derse geç kalan arkadaş.',
    'Kafeye davet edip ödeyecekmiş gibi davranan ama ödemeyen arkadaş.',
    'En sevdiğin yemeği yerken biri çatalla tabağından almaya çalışıyor.',
    'Öğrenci sunum yaparken projeksiyon bozuluyor.',
    'Çok ciddi bir konuşmanın ortasında midenin guruldaması.',
    'Sen tam duşa girmişken kapının çalması.',
    'Toplantıya hazırlanırken internetin kesilmesi.',
    'Yeni alınan kıyafeti hemen birinin lekelemesi.',
    'Arkadaş grubunda herkesin WhatsApp profil resmini aynı yapması.',
    'Tatildeyken patronun araması.',
    'İki saat hazırlanıp dışarı çıktığında yağmurun başlaması.',
    'Dersin son 5 dakikasında hocanın ek sınavdan bahsetmesi.',
    'Cuma günü sınav yapılacağını perşembe gecesi öğrenmek.',
    'Uykunun en tatlı yerinde telefonun acı acı çalması.',
    'Online ders esnasında mikrofonun açık unutulması.',
  ];

  final List<String> cards = [
    '1.jpg',
    '2.jpg',
    '3.jpg',
    '4.jpg',
    '5.jpg',
    '6.jpg',
    '10.jpg',
    '11.jpg',
    '12.jpg',
    '16.jpg',
    '17.jpg',
    '18.jpg',
    '19.jpg',
    '20.jpg',
    '21.jpg',
    '22.jpg',
    '23.jpg',
    '24.jpg',
    '25.jpg',
    '26.jpg',
    '27.jpg',
    '28.jpg',
    '29.jpg',
    '30.jpg',
    '31.jpg',
    '32.jpg',
    '34.jpg',
    '35.jpg',
    '36.jpg',
    '37.jpg',
    '38.jpg',
    '39.jpg',
    '40.jpg',
    '41.jpg',
    '42.jpg',
    '43.jpg',
    '45.jpg',
    '46.jpg',
    '47.jpg',
    '49.jpg',
    '50.jpg',
    '51.jpg',
    '52.jpg',
    '53.jpg',
    '54.jpg',
    '55.jpg',
    '56.jpg',
    '57.jpg',
    '58.jpg',
    '59.jpg',
    '60.jpg',
    '61.jpg',
    '62.jpg',
    '66.jpg',
    '67.jpg',
    '68.jpg',
    '69.jpg',
    '70.jpg',
    '71.jpg',
    '72.jpg',
    '73.jpg',
    '74.jpg',
    '75.jpg',
    '76.jpg',
    '77.jpg',
    '78.jpg',
    '79.jpg',
    '80.jpg'
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentSituation = '';
  List<String> playerCards = [];
  bool showingCards = false;
  List<String> playedCards = [];
  String? selectedCard;
  int currentRound = 1;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() async {
    if (widget.isHost) {
      _newRound();
    }
    _dealCards();
    _listenToGameChanges();
  }

  void _listenToGameChanges() {
    _firestore
        .collection('rooms')
        .doc(widget.roomCode)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        setState(() {
          currentSituation = snapshot.get('currentSituation') ?? '';
          playedCards = List<String>.from(snapshot.get('playedCards') ?? []);
          if (playedCards.isEmpty) {
            showingCards = false;
            selectedCard = null;
          }
        });
      }
    });
  }

  void _dealCards() {
    List<String> shuffledCards = List.from(cards)..shuffle();
    playerCards = shuffledCards.take(6).toList(); // Her oyuncuya 6 kart dağıt
  }

  void _newRound() async {
    if (currentRound > 6) {
      // Oyun bitti
      setState(() {
        currentSituation = 'Oyun Bitti!';
      });
      return;
    }

    String newSituation = situations[Random().nextInt(situations.length)];
    await _firestore.collection('rooms').doc(widget.roomCode).update({
      'currentSituation': newSituation,
      'playedCards': [],
    });
    setState(() {
      showingCards = false;
      selectedCard = null;
    });
  }

  void _playCard(String card) async {
    if (selectedCard != null) return;

    setState(() {
      selectedCard = card;
      showingCards = false;
      playerCards.remove(card);
    });

    await _firestore.collection('rooms').doc(widget.roomCode).update({
      'playedCards': FieldValue.arrayUnion([card]),
    });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/$card',
                fit: BoxFit.contain,
              ),
            ),
            if (widget.isHost)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _newRound();
                        setState(() {
                          selectedCard = null;
                          currentRound++;
                        });
                      },
                      child: const Text('Yeni Tur'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showCardInDialog(String card) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/$card',
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tepki Kartları - Oda: ${widget.roomCode}'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                color: Colors.deepPurple[700],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'DURUM:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentSituation,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tur: $currentRound / 6',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (playedCards.isNotEmpty)
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: playedCards.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showCardInDialog(playedCards[index]);
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 5,
                          color: Colors.deepPurple[800],
                          child: Image.asset(
                            'assets/images/${playedCards[index]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 20),
              if (!showingCards && selectedCard == null)
                ElevatedButton(
                  onPressed: () => setState(() => showingCards = true),
                  child: const Text('Kartlarımı Göster'),
                )
              else if (selectedCard == null)
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: playerCards.length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        color: Colors.deepPurple[800],
                        child: InkWell(
                          onTap: () => _playCard(playerCards[index]),
                          child: Image.asset(
                            'assets/images/${playerCards[index]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.isHost
          ? FloatingActionButton(
              onPressed: _newRound,
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }
}
