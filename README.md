
# Tugas 7: Elemen Dasar Flutter

## 1. Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.
- **Stateless Widget** adalah widget yang tidak memiliki state atau kondisi yang dapat berubah setelah widget tersebut dibuat. Widget ini cocok digunakan untuk elemen UI yang tidak memerlukan perubahan, seperti tampilan teks atau gambar yang statis. Stateless widgets diimplementasikan dengan menurunkan kelas dari `StatelessWidget`.
- **Stateful Widget** adalah widget yang memiliki state atau kondisi yang bisa berubah selama siklus hidup aplikasi. Stateful widgets cocok untuk elemen UI yang berubah, misalnya saat ada interaksi pengguna. Implementasinya menggunakan kelas `StatefulWidget`, yang berpasangan dengan kelas `State` untuk mengelola perubahan state.

   **Perbedaan utama**: Stateless widgets tidak dapat berubah setelah dibuat, sedangkan stateful widgets bisa berubah seiring berjalannya aplikasi.

## 2. Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.
- **MaterialApp**: Sebagai root dari aplikasi Flutter yang menyediakan material design.
- **Scaffold**: Struktur dasar halaman yang mencakup app bar, body, dan floating action button (jika diperlukan).
- **AppBar**: Header yang menampilkan judul aplikasi.
- **Padding**: Memberi jarak antara elemen-elemen widget.
- **Row**: Menyusun widget secara horizontal.
- **Column**: Menyusun widget secara vertikal.
- **Card**: Menyediakan tampilan seperti kartu dengan bayangan yang sesuai untuk menampilkan informasi.
- **GridView.count**: Menampilkan item dalam bentuk grid dengan jumlah kolom yang ditentukan.
- **Material**: Menyediakan tampilan material pada widget, yang digunakan sebagai latar belakang item dalam grid.
- **InkWell**: Menangani efek sentuhan pada widget dan memunculkan aksi saat widget diklik.
- **SnackBar**: Menampilkan pesan sementara di bagian bawah layar saat pengguna berinteraksi dengan widget tertentu.
- **Icon**: Menampilkan ikon sebagai representasi visual dari tombol.
- **Text**: Menampilkan teks pada aplikasi.

## 3. Apa fungsi dari setState()? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.
- **setState()** adalah fungsi yang digunakan untuk memberi tahu Flutter bahwa ada perubahan pada data yang digunakan oleh widget, dan widget harus diperbarui. Fungsi ini umumnya digunakan di dalam kelas `State` pada `StatefulWidget` untuk merender ulang widget saat ada perubahan nilai pada variabel-variabel tertentu.
- Variabel yang dapat terdampak dengan **setState()** adalah variabel yang berada di dalam kelas `State` dan digunakan dalam membangun widget. Dengan `setState()`, Flutter mengetahui bagian mana dari UI yang perlu diperbarui.

## 4. Jelaskan perbedaan antara const dengan final.
- **const** digunakan untuk mendeklarasikan nilai yang bersifat konstan dan tetap sepanjang siklus hidup aplikasi. `const` harus diinisialisasi dengan nilai konstan yang sudah diketahui pada waktu kompilasi.
- **final** juga digunakan untuk membuat variabel yang tidak bisa diubah setelah diinisialisasi, tetapi nilainya bisa ditentukan pada runtime, bukan pada waktu kompilasi.
  
   **Perbedaan utama**: `const` membuat nilai konstan pada waktu kompilasi, sementara `final` memungkinkan nilai konstan pada waktu runtime.

## 5. Jelaskan bagaimana cara kamu mengimplementasikan checklist-checklist di atas.

### 1. Membuat Proyek Baru
- **Langkah-langkah**:
  - Di terminal atau command prompt, buat proyek baru dengan menggunakan perintah berikut:
    ```bash
    flutter create suikashop
    ```
  - Masuk ke direktori `suikashop`:
    ```bash
    cd suikashop
    ```
  - Jalankan proyek menggunakan perintah:
    ```bash
    flutter run
    ```

### 2. Merapikan Struktur Proyek
- **Langkah-langkah**:
  - File `menu.dart` dibuat di dalam folder `lib` untuk memisahkan logika dari halaman utama (`MyHomePage`).
  - Kode yang berkaitan dengan `MyHomePage` dipindahkan ke file `menu.dart` untuk menjaga `main.dart` tetap sederhana dan modular.
  - Di `main.dart`, import file `menu.dart` agar `MyHomePage` dapat diakses:
    ```dart
    import 'package:suikashop/menu.dart';
    ```

### 3. Mengubah Tema Warna Aplikasi
- Di dalam `main.dart`, tema aplikasi diubah untuk memberi tampilan yang lebih menarik dengan kode berikut:
  ```dart
  colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.deepPurple,
  ).copyWith(secondary: Colors.deepPurple[400]),
  ```
- Skema warna ini menetapkan warna utama menjadi ungu (`deepPurple`).

### 4. Membuat Widget dan Struktur Halaman
- **Mengubah `MyHomePage` menjadi Stateless**:
  - Mengubah `MyHomePage` dari stateful menjadi stateless, menghapus fungsi `createState`, dan komponen lain yang tidak diperlukan.
  - Membuat widget `MyHomePage` di `menu.dart` untuk mengelompokkan komponen visual dan struktur halaman.
- **Menyusun Layout Halaman**:
  - `Scaffold` digunakan di dalam `MyHomePage` untuk menambahkan `AppBar` dan mengelola konten utama aplikasi di `body`.
  - Gunakan `Column` dan `GridView.count` untuk menampilkan tombol dalam layout grid tiga kolom.

### 5. Membuat Button Card Sederhana dengan Ikon
- **Menggunakan `ItemHomepage` untuk Data Tombol**:
  - `ItemHomepage` dibuat untuk menyimpan data terkait tombol, termasuk nama, ikon, dan warna.
  - Daftar tombol diinisialisasi dalam `MyHomePage`:
    ```dart
    final List<ItemHomepage> items = [
      ItemHomepage("Lihat Daftar Produk", Icons.list, Colors.blue),
      ItemHomepage("Tambah Produk", Icons.add, Colors.green),
      ItemHomepage("Logout", Icons.logout, Colors.red),
    ];
    ```
- **Membuat Class `ItemCard`**:
  - Class `ItemCard` dibuat sebagai widget stateless untuk setiap tombol, dengan properti `item` dari `ItemHomepage`.
  - Menggunakan `InkWell` untuk menambahkan efek klik pada tombol, yang memicu `SnackBar` dengan pesan sesuai tombol yang ditekan:
    ```dart
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
    ```

### 6. Mengintegrasikan InfoCard dan ItemCard ke dalam MyHomePage
- Di dalam `MyHomePage`, `Scaffold` digunakan untuk struktur halaman, dengan `AppBar` untuk judul aplikasi.
- Menambahkan `ItemCard` dalam `GridView.count` untuk menyusun tombol dalam tata letak grid tiga kolom:
  ```dart
  GridView.count(
    primary: true,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    shrinkWrap: true,
    children: items.map((ItemHomepage item) {
      return ItemCard(item);
    }).toList(),
  ),
  ```

### 7. Analisis dan Clean-up Kode
- **Perintah untuk Menganalisis Kode**:
    ```bash
    flutter analyze
    ```
- **Memperbaiki Masalah yang Muncul**: