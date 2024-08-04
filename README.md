# FAN Integrasi Teknologi Teknikal Test

Project ini merupakan aplikasi chat dengan authentikasi firebase dan verifikasi menggunakan email.

## Fitur

- Authentikasi Firebase (Login, Registrasi, Email Verifikasi, Reset Password)
- Chat (email verify mandatory)

## Tools yang digunakan

Berikut merupakan tools yang digunakan dalam membuat project ini :

- [Flutter](https://flutter.dev/docs/get-started/install) (versi 3.22.2)
- [VS Code](https://code.visualstudio.com/)
- [Firebase](https://firebase.google.com/)

## Package yang digunakan
```dart
firebase_core: ^3.3.0
firebase_auth: ^5.1.3
cloud_firestore: ^5.2.0
flutter_spinkit: ^5.2.1
flutter_easyloading: ^3.0.5
flutter_bloc: ^8.1.6
get: ^4.6.6
```

Penjelasan alasan penggunaan package tambahan :<br>
1\. **flutter_spinkit** dan **flutter_easyloading** : package untuk menampilkan loading, untuk easyloading merupakan widget tanpa context, yang mana kita dapat memanggil loading bahkan diluar widget tree sekalipun.<br>
2\. **flutter_bloc** : package yang digunakan untuk memanggil state (error, loading, success) tanpa dalam widget tree.<br>
3\. **get** : package yang digunakan untuk perpindahan screen.


## Cara menjalankan project

Sebelum memulai, jalankan perintah berikut pada terminal, pastikan terminal Anda berada pada project :
```terminal
flutter pub get
```
<br>
Kemudian untuk menjalankan projectnya terdapat beberapa cara :

### 1\. menggunakan Terminal

Dengan menjalankan perintah berikut :
```terminal
flutter run
```

### 2\. menggunakan VS Code

\- cara pertama<br>
Klik kanan file main.dart, lalu klik ```Start Debugging```

\- cara kedua<br>
Buka file main.dart, kemudian pada pojok kanan atas, klik ```Run or Debug``` icon, lalu klik ```Start Debugging```