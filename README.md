![Image](https://github.com/user-attachments/assets/37648c13-7264-4514-ad91-2ba8b04f0b76) ![Image](https://github.com/user-attachments/assets/7385ad21-1781-4655-8047-eb99986be924)


Tepki Kartları

Tepki Kartları, arkadaşlarınızla birlikte oynayabileceğiniz eğlenceli bir kart oyunudur. Oyunda her turda verilen bir durum karşısında en uygun tepkiyi gösteren kartı seçmeye çalışırsınız. Oyun Firebase ile gerçek zamanlı olarak oynanabilir. Eğlenceli vakite neden olur.

Özellikler;
- Yeni oyun odası oluşturma ve odaya katılma.
- Firebase Firestore kullanarak durumlar ve oynanan kartlar senkronize edilir.
- Her oyuncuya 6 kart dağıtılır.
- Oyun sırasında seçilen kartlar anlık olarak tüm oyunculara gösterilir.
- 6 tur sonunda oyun sona erer.
- Basit ve şık bir arayüz.

Kullanılan Teknolojiler:
- Flutter
- Firebase (Firestore)
- Dart

Kurulum:
1. Bu projeyi bilgisayarınıza klonlayın:

https://github.com/Muhammetalig/tepki-kartlari.git

2. Firebase projesi oluşturun ve `google-services.json` dosyasını `android/app/` klasörüne yerleştirin.
3. Flutter projesinde Firebase'i başlatın:

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

4. Gerekli bağımlılıkları yükleyin:

flutter pub get

5. Uygulamayı çalıştırın:

flutter run


Kullanım
- Uygulamayı başlattıktan sonra yeni bir oda oluşturabilir veya mevcut bir odaya katılabilirsiniz.
- Oyun sırasında verilen durumlara en uygun tepkiyi gösterecek kartı seçin.
- Her turda bir kart seçilir ve oyun 6 tur sonunda biter.

Katkıda Bulunma
Her türlü katkı ve öneri memnuniyetle karşılanır! Lütfen bir pull request gönderin veya bir issue açın.


