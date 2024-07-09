# Travel App

![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Deskripsi Singkat
Travel App adalah aplikasi perjalanan yang memungkinkan pengguna untuk mencari destinasi perjalanan dan mendapatkan informasi terkait. Aplikasi ini dibangun menggunakan bahasa Dart dan mengikuti prinsip clean architecture untuk meningkatkan skalabilitas dan maintainability.

![Airplane](./assets/images/cargo-freight-forwarder-services.gif)

## Daftar Isi
- [Fitur](#fitur)
- [Arsitektur](#arsitektur)
- [Instalasi](#instalasi)
- [Penggunaan](#penggunaan)
- [Kontribusi](#kontribusi)
- [Lisensi](#lisensi)
- [Kontak](#kontak)

## Fitur
- Mencari destinasi perjalanan.
- Mendapatkan informasi detail tentang destinasi perjalanan.

## Arsitektur
Aplikasi ini mengikuti prinsip clean architecture. Struktur utama terdiri dari:
- **Data Layer**: Berisi implementasi sumber data seperti API dan database lokal.
- **Domain Layer**: Berisi use case dan repository interface.
- **Presentation Layer**: Berisi ViewModel dan UI (Activity, Fragment).

### Modul
- **app**: Modul utama yang mengikat semua modul lainnya.
- **core**: Berisi logika bisnis dan utilitas bersama.
  - **navigation**: Modul untuk navigasi antar layar.
  - **designsystem**: Berisi komponen UI bersama.
  - **domain**: Berisi use case dan entitas domain.
- **feature**: Berisi fitur-fitur utama aplikasi seperti pencarian dan informasi destinasi.

## Instalasi
### Prasyarat
- Flutter SDK versi terbaru
- Dart SDK versi terbaru

### Langkah-langkah
1. Clone repositori:
    ```sh
    git clone https://github.com/mzhanif16/travel_app_clean_architecture.git
    cd travel-app
    ```
2. Instal dependensi:
    ```sh
    flutter pub get
    ```
3. Jalankan aplikasi:
    ```sh
    flutter run
    ```

## Penggunaan
### Menjalankan Aplikasi
Setelah instalasi, jalankan aplikasi di Flutter dengan memilih perangkat emulator atau perangkat fisik.

### Fitur Utama
1. **Mencari Destinasi**:
   - Buka aplikasi dan masukkan nama destinasi di kolom pencarian.
   - Tekan tombol cari untuk melihat hasilnya.

2. **Melihat Informasi Destinasi**:
   - Klik pada hasil pencarian untuk melihat detail informasi destinasi.

## Kontribusi
Kami menyambut kontribusi dari komunitas. Untuk berkontribusi:
1. Fork repositori ini.
2. Buat branch fitur baru (`git checkout -b fitur-anda`).
3. Commit perubahan Anda (`git commit -am 'Menambahkan fitur'`).
4. Push ke branch (`git push origin fitur-anda`).
5. Buat Pull Request.

Baca panduan kontribusi lebih lanjut di [CONTRIBUTING.md](CONTRIBUTING.md).

## Lisensi
Proyek ini dilisensikan di bawah lisensi MIT. Lihat file [LICENSE](LICENSE) untuk informasi lebih lanjut.

## Kontak
Untuk pertanyaan lebih lanjut, hubungi saya di [email@example.com](mailto:email@example.com).

---

Terima kasih telah menggunakan Travel App!
