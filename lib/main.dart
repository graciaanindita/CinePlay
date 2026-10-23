import 'package:flutter/material.dart';

void main() {
  runApp(const CinePlayApp());
}

class CinePlayApp extends StatelessWidget {
  const CinePlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CinePlay App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainNavigationPage(),
      },
    );
  }
}

// ==========================================
// MODEL DATA & GLOBAL STATE STORAGE
// ==========================================
class MovieModel {
  final String judul;
  final String genre;
  final String sinopsis;
  final String imageUrl;

  const MovieModel({
    required this.judul,
    required this.genre,
    required this.sinopsis,
    required this.imageUrl,
  });
}

class TicketModel {
  final String film;
  final String studio;
  final String waktu;

  TicketModel({required this.film, required this.studio, required this.waktu});
}

List<TicketModel> globalRiwayatPemesanan = [];

// ==========================================
// 1. HALAMAN LOGIN
// ==========================================
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.movie_filter, color: Colors.redAccent, size: 80),
              const SizedBox(height: 16),
              const Text(
                'CinePlay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bioskop Dalam Genggaman Anda',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN UTAMA (BOTTOM NAVIGATION)
// ==========================================
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MovieListPage(),
    const JadwalBioskopPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Film'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Jadwal'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ==========================================
// 3. TAB FILM
// ==========================================
class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  final List<MovieModel> dummyMovies = const [
    MovieModel(
      judul: 'Avatar 3',
      genre: 'Sci-Fi / Adventure',
      sinopsis: 'Melanjutkan perjalanan bangsa Na\'vi di planet Pandora dengan ancaman dan klan baru yang misterius.',
      imageUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=500',
    ),
    MovieModel(
      judul: 'Spider-Man',
      genre: 'Action / Superhero',
      sinopsis: 'Petualangan baru Peter Parker menghadapi musuh lintas semesta yang mengancam keselamatan kota.',
      imageUrl: 'https://images.unsplash.com/photo-1635805737707-575885ab0820?w=500',
    ),
    MovieModel(
      judul: 'Inception',
      genre: 'Sci-Fi / Thriller',
      sinopsis: 'Pencuri yang mencuri rahasia perusahaan melalui penggunaan teknologi berbagi mimpi.',
      imageUrl: 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500',
    ),
    MovieModel(
      judul: 'Resident Evil',
      genre: 'Action / Horror',
      sinopsis: 'Perjuangan bertahan hidup melawan wabah zombi global akibat eksperimen Umbrella Corporation.',
      imageUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Tayang', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: dummyMovies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final movie = dummyMovies[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailMoviePage(movie: movie),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          movie.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.judul,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            movie.genre,
                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// 4. HALAMAN DETAIL FILM (Dilengkapi Tombol Pesan Tiket / Jadwal)
// ==========================================
class DetailMoviePage extends StatelessWidget {
  final MovieModel movie;

  const DetailMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.judul),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              movie.imageUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.judul,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(movie.genre),
                    backgroundColor: Colors.red[50],
                    labelStyle: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sinopsis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.sinopsis,
                    style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  
                  // Tombol Pesan Tiket (Masuk ke pemilihan jadwal berdasarkan film ini)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PilihJadwalFilmPage(selectedMovie: movie),
                          ),
                        );
                      },
                      child: const Text('Pesan Tiket / Lihat Jadwal', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Kembali', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. HALAMAN PEMILIHAN JADWAL BERDASARKAN FILM YANG DIPILIH
// ==========================================
class PilihJadwalFilmPage extends StatelessWidget {
  final MovieModel selectedMovie;

  const PilihJadwalFilmPage({super.key, required this.selectedMovie});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> studios = const [
      {'nama': 'Studio Regular', 'deskripsi': 'Standar audio jernih dan kursi nyaman.'},
      {'nama': 'Studio IMAX 3D', 'deskripsi': 'Layar raksasa melengkung imersif.'},
      {'nama': 'Velvet VIP', 'deskripsi': 'Kursi sofa mewah recliner + selimut.'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal: ${selectedMovie.judul}'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: studios.length,
        itemBuilder: (context, index) {
          final studio = studios[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.theaters, color: Colors.red, size: 40),
              title: Text(studio['nama']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(studio['deskripsi']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PilihJamTayangPage(
                      movieTitle: selectedMovie.judul,
                      studioName: studio['nama']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Halaman Pilih Jam Tayang & Masuk ke Riwayat
class PilihJamTayangPage extends StatelessWidget {
  final String movieTitle;
  final String studioName;

  const PilihJamTayangPage({super.key, required this.movieTitle, required this.studioName});

  @override
  Widget build(BuildContext context) {
    final List<String> jamTayang = ['12:30 WIB', '15:15 WIB', '18:00 WIB', '20:45 WIB'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Jam Tayang'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: jamTayang.length,
          itemBuilder: (context, index) {
            final jam = jamTayang[index];
            return Card(
              child: ListTile(
                title: Text('Jam: $jam', style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Text('Konfirmasi', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                onTap: () {
                  // 1. Masukkan data ke riwayat pemesanan global
                  globalRiwayatPemesanan.add(
                    TicketModel(
                      film: movieTitle,
                      studio: studioName,
                      waktu: 'Hari ini, $jam',
                    ),
                  );

                  // 2. Berikan notifikasi berhasil dan kembali ke menu utama / root halaman film
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Berhasil memesan tiket $movieTitle di $studioName!')),
                  );

                  // Kembali langsung ke halaman utama (MainNavigationPage)
                  Navigator.popUntil(context, ModalRoute.withName('/main'));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Tab Jadwal Bioskop Umum (Menu Bawah Tab 1)
class JadwalBioskopPage extends StatelessWidget {
  const JadwalBioskopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Bioskop', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Silakan pilih film terlebih dahulu di tab "Film" untuk melihat jadwal dan melakukan pemesanan tiket.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 6. HALAMAN PROFILE (Riwayat Dinamis & Logout Reset Riwayat)
// ==========================================
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Akun', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://picsum.photos/seed/userprofile/200/200'),
            ),
            const SizedBox(height: 12),
            const Text(
              'Gracia Anindita',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'gracia@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Pemesanan Tiket',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            
            globalRiwayatPemesanan.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Belum ada riwayat pemesanan tiket.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: globalRiwayatPemesanan.length,
                    itemBuilder: (context, index) {
                      final riwayat = globalRiwayatPemesanan[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.receipt_long, color: Colors.red),
                          title: Text(riwayat.film, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${riwayat.studio} • ${riwayat.waktu}'),
                        ),
                      );
                    },
                  ),
            const SizedBox(height: 24),

            // Tombol Logout
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Reset riwayat ketika logout
                  globalRiwayatPemesanan.clear();

                  // Kembali ke halaman login dan hapus seluruh stack
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}