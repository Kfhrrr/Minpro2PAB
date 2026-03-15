# Minpro-2 PAB

# 1. Deskripsi Aplikasi
Aplikasi ini merupakan sistem manajemen asrama berbasis mobile yang dibuat menggunakan Flutter, dengan tujuan mempermudah pengelolaan data penghuni, kamar, dan keuangan asrama. Aplikasi ini terdiri dari beberapa modul utama, yaitu Penghuni, Kamar, dan Keuangan/Tagihan, yang terintegrasi dalam satu halaman utama menggunakan BottomNavigationBar untuk navigasi sehingga pengguna dapat berpindah antar fitur dengan mudah.

Pada modul Penghuni, pengguna dapat menambahkan, mengedit, dan menghapus data penghuni secara dinamis. Setiap penghuni memiliki atribut penting seperti nama, NIM, NIK, nomor HP, kamar, dan universitas. Fitur validasi memastikan NIK unik, nomor HP minimal 11 digit, dan NIK tepat 16 digit. Untuk meningkatkan pengalaman pengguna, interaksi penting seperti tambah, edit, dan hapus menampilkan dialog konfirmasi serta SnackBar berwarna yang muncul dari bawah layar sebagai notifikasi keberhasilan atau kesalahan.

Modul Kamar menampilkan daftar kamar beserta jumlah penghuni dan kapasitas yang tersisa. Status kamar ditampilkan menggunakan Chip berwarna merah jika kamar penuh dan hijau jika masih tersedia, sehingga pengguna dapat dengan cepat memantau kondisi setiap kamar. Sementara itu, modul Keuangan/Tagihan berfungsi untuk menghitung tunggakan iuran bulanan berdasarkan data pembayaran terakhir penghuni, dengan status pembayaran ditampilkan sebagai LUNAS atau MENUNGGAK.

Aplikasi ini juga telah terintegrasi dengan Supabase sebagai layanan backend untuk penyimpanan dan pengelolaan data secara online. Dengan integrasi ini, data penghuni, kamar, dan tagihan dapat tersimpan secara terpusat dalam database sehingga lebih aman, terstruktur, dan dapat diakses secara real-time oleh aplikasi.

Selain itu, aplikasi memanfaatkan Supabase Authentication (Auth) untuk mengelola proses registrasi dan login pengguna. Pengguna diwajibkan membuat akun dan melakukan login sebelum dapat mengakses sistem, sehingga keamanan aplikasi lebih terjaga. Aplikasi juga menyediakan fitur Dark Mode dan Light Mode yang memungkinkan pengguna memilih tampilan sesuai preferensi, sehingga penggunaan aplikasi menjadi lebih nyaman dalam berbagai kondisi pencahayaan.

# 2. Fitur Aplikasi Minpro-2
## A. Halaman Penghuni
Pada halaman ini memuat dan menampilkan daftar penghuni. pada page ini juga terdapat beberapa fitur seperti tambah data penghuni baru, edit data penghuni dan hapus data penghuni
<img width="773" height="909" alt="Image" src="https://github.com/user-attachments/assets/9087789a-2e7d-486c-875b-815c66fa3dd2" />

### a. Tambah Data Penghuni 
<img width="778" height="911" alt="Image" src="https://github.com/user-attachments/assets/7bc2d249-81e6-404d-85e2-cb41955bbb60" />

<img width="780" height="913" alt="Image" src="https://github.com/user-attachments/assets/9a349e00-8cc7-476d-9258-06831aa19bc2" />

<img width="782" height="910" alt="Image" src="https://github.com/user-attachments/assets/f5d0b803-b59a-4af3-a520-b377d2f180a6" />

<img width="685" height="907" alt="image" src="https://github.com/user-attachments/assets/814743d1-cac1-44ae-937c-93a5786fb1fb" />

- Fitur yang pertama yanitu tambah data penghuni, untuk menggunakan fitur ini terdapat floating button dengan ikon ( + ) pada bagian kanan bawah halaman dan tekan untuk masuk ke fitur tambah penghuni.

<img width="775" height="912" alt="Image" src="https://github.com/user-attachments/assets/fdac36b5-b067-494d-aecb-9db8dd2151de" />


- Setelah menekan button di page data penghuni otomatis akan berpindah ke form page untuk menambah data penghuni baru. Terdapat kolom informasi data penghuni yang dapat di isi seperti nama, nim, no hp, nik, kampus, dan memilih kamar.


<img width="776" height="907" alt="Image" src="https://github.com/user-attachments/assets/98f7929e-37f6-49be-8725-26721197b7f6" />


- Bagian pemilihan kamar berbentuk dropdown no kamar A1 - B3 dan terdapat informasi jumlah penghuni di kamar-kamar tersebut.


<img width="778" height="912" alt="Image" src="https://github.com/user-attachments/assets/50f61645-1913-4c79-9ec8-51b7990ba1e2" />

<img width="778" height="908" alt="Image" src="https://github.com/user-attachments/assets/795a951f-69a3-4083-9632-f1d0223c7a3f" />

- Terdapat validator inpoutan dengan kriteria yang berbeda disetiap kolom formnya seperti nim yang wajib berupa angka, nomor hp minimal 11 digit, dan nik wajib 16 digit.
  
<img width="685" height="910" alt="image" src="https://github.com/user-attachments/assets/18aa29a1-d45c-4758-8653-483ae0a6389c" />

- Untuk nik terdapat validator inputan yang membatasi setiap nik dari penghuni tidak boleh sama dan jika tidak sesuai dengan kriteria validator maka data tidak akan bisa disimpan dan muncul pesan sementara berwarna merah pada bagian bawah halaman.


<img width="682" height="907" alt="image" src="https://github.com/user-attachments/assets/b8e6a2d0-f155-47e9-8b80-0349d2b89a33" />

- Pada bagian kamar juga terdapat validator yang membatasi satu kamar hanya dapat diisi oleh 2 orang dan tidak boleh lebih, jika melebihi wajib memilih kamar yang lain.

<img width="683" height="904" alt="image" src="https://github.com/user-attachments/assets/e52695e2-a816-488a-8a25-6b83ad5171d3" />
  
- Setelah semua form inputan telah diisi dengan benar, tekan tombol simpan dan akan muncul pop up message sebagai validasi terakhir sebelum menambahkan data penghuni baru, jika menekan batal maka proses akan dihentikan dan jika menekan tombol tambah maka data penghuni baru akan ditambahkan.


<img width="684" height="907" alt="image" src="https://github.com/user-attachments/assets/666f2bd1-cae6-46e0-af1a-a078f63b481f" />

- gambar di bawah ini adalah tampilan setelah berhasil melakukan penambahan data penghuni yang baru, akan muncul widgett pesan sementara berwarna hijau yang menandakan proses penambahan penghuni baru telah berhasil.

### b. Edit Data Penghuni

<img width="770" height="162" alt="Image" src="https://github.com/user-attachments/assets/ef45ad24-b9a2-49e3-878b-9a763341fa7f" />

<img width="782" height="915" alt="Image" src="https://github.com/user-attachments/assets/1536fe3c-4f9f-485b-8c58-bc322094a32f" />

<img width="780" height="910" alt="Image" src="https://github.com/user-attachments/assets/88062fac-e8f2-4d4e-b0df-3355f9caa762" />

<img width="781" height="914" alt="Image" src="https://github.com/user-attachments/assets/786363d7-6df4-42e6-b800-02d5bd7489c5" />
<img width="682" height="213" alt="image" src="https://github.com/user-attachments/assets/4e91779a-a0d8-4b53-aa0a-4cbe5a40ac53" />

- Selanjutnya ada fitur edit data penghuni yang dapat dilakukan dengan menekan tombol bergambarkan pensil seperti pada gambar di bawah ini.


<img width="685" height="909" alt="image" src="https://github.com/user-attachments/assets/d098db80-17b2-43e0-a89a-c875083d064d" />

- Setelah menekan ikon bergambarkan pensil pengguna otomatis akan masuk ke fotur edit data pengguna yang tampilannya sama seperti saat menambahkan pengguna baru.


<img width="684" height="907" alt="image" src="https://github.com/user-attachments/assets/ed954e21-e199-406a-b7fc-fe67200301be" />

- Fitur edit ini juga memiliki validator inputan yang sama seperti saat menambah data baru, jadi isi dengan benar untuk melakukan perubahan.


<img width="684" height="910" alt="image" src="https://github.com/user-attachments/assets/4c75f7a4-692d-4fbd-a247-a6e1fc4033cb" />

- Jika semua data sudah benar akan muncul pop up message sebagai validator terakhir sebelum melakukan perubahan data, tekan tombol batal unutk membatalkan dan tekan tombol edit untuk melakukan perubahan.

<img width="682" height="911" alt="image" src="https://github.com/user-attachments/assets/e7913213-7d11-4f9e-be29-8a2571f66c9c" />

- Setelah berhasil melakukan perubahan data pengguna akan beralih kembali ke halaman data penghuni. Dapat dilihat data penghuni yang sbeelumnya di edit telah mengalami perubahan.


### c. Hapus Data Penghuni
<img width="777" height="162" alt="Image" src="https://github.com/user-attachments/assets/59ee41bc-b048-436b-9729-595d51e4cadb" />

<img width="782" height="915" alt="Image" src="https://github.com/user-attachments/assets/67d01e86-2202-41ea-ab43-5c0131eb2543" />

<img width="781" height="904" alt="Image" src="https://github.com/user-attachments/assets/d88683ee-fc21-407f-8b7f-fbe0ac12754e" />


<img width="680" height="146" alt="image" src="https://github.com/user-attachments/assets/e5cbd45d-1008-4283-8e19-c0da2fc50b2e" />

- Selanjutnya ada fitur hapus data penghuni, untuk menjalankan fitur ini pengguna cukup menekan tombol dengan ikon tong sampah disebelah tombol untuk melakukan fitur edit.


<img width="686" height="909" alt="image" src="https://github.com/user-attachments/assets/3470dd0f-a6d2-46f4-b82d-f08ad26b750c" />

- Setelah menekan tombol muncul pop up message sebagai validator apakah pengguna benar-benar ingin menghapus data penghuni atau tidak, jika ingin menghapus data penghuni tekan tombol hapus dan jika tidak tekan tombol batal.


<img width="683" height="911" alt="image" src="https://github.com/user-attachments/assets/f7a1e042-ec7c-4471-aece-72b7f10d3bb7" />

- Gambar dibawha ini adlaah tampilan setelah menjalankan fitur hapus data penghuni, dapat dilihat data penghuni yang ingin dihapus sebelumnya telah menghilang ditandai dengan menculnya scaffoldmessanger pada bagian bawah halaman yang menandakan proses penghapusan berhasil.

## B. Halaman Kamar
Pada halaman ini terdapat informasi mengenai kamar yang ada di asrama, informasinya meliputi nama kamar, jumlah penghuni disetiap kamarnya, kamar yang tersedia memiliki chip berwarna hijau  dan chip berwarna merah jika kamar penuh.

<img width="773" height="907" alt="Image" src="https://github.com/user-attachments/assets/7709170a-7872-4d12-84f9-1cef32ff1873" />

<img width="777" height="909" alt="Image" src="https://github.com/user-attachments/assets/c0419b35-38ef-4ab7-88b8-a6ebe7f17547" />

<img width="774" height="904" alt="Image" src="https://github.com/user-attachments/assets/edc4ed7b-9311-47bf-a04f-f5ec8fdbff13" />

<img width="776" height="912" alt="Image" src="https://github.com/user-attachments/assets/d705a363-6647-4964-8e06-1ff1d73b94bc" />

<img width="775" height="914" alt="Image" src="https://github.com/user-attachments/assets/e1bfe1f3-c1a1-4eb5-a1a0-17f4a84e7e19" />

<img width="774" height="913" alt="Image" src="https://github.com/user-attachments/assets/89b428e9-2afa-41d7-8f4c-537a50e4a6cb" />

<img width="776" height="911" alt="Image" src="https://github.com/user-attachments/assets/0e5b4a8f-fe9d-4c81-b7e4-070528062cc6" />

<img width="774" height="906" alt="Image" src="https://github.com/user-attachments/assets/0cb0bfff-b71e-4279-88f5-21716be4a974" />


## C. Halaman Keuangan
Pada halaman keuangan terdapat data penghuni asrama seperti nama, nomor kamar, bulan terakhir membauar spp, jumlah tunggakan, dan status pembayarannya. Tunggakan dihitung berdasarkan tahun dan bulan terakhir si penghuni ini melakukan pembayaran dan tagihan perbulannya adalah Rp150.000. Pengguna dapat memperbarui waktu pembayaran terakhir penghuni dengan menekan tombol ber-ikon pensi berwarna hijau.

<img width="773" height="911" alt="Image" src="https://github.com/user-attachments/assets/b8958fd9-5290-49d2-92d0-6b0e37a8bb72" />

<img width="778" height="127" alt="Image" src="https://github.com/user-attachments/assets/ba9b0ae8-c44d-4751-a818-5407e27b0d0d" />

<img width="782" height="905" alt="Image" src="https://github.com/user-attachments/assets/ef13a5bb-bb5d-459a-937f-d8a7c20c840a" />

<img width="784" height="912" alt="Image" src="https://github.com/user-attachments/assets/35b5c16f-a7c6-4aae-87a0-0721e2077d8b" />

<img width="778" height="911" alt="Image" src="https://github.com/user-attachments/assets/be9965bf-0737-498f-874f-8600159a0b2a" />

<img width="779" height="906" alt="Image" src="https://github.com/user-attachments/assets/ac6010a5-2ffb-4a36-8e95-99fe161b69bd" />

### a. Update Pembayaran Penghuni
<img width="682" height="219" alt="image" src="https://github.com/user-attachments/assets/3120546e-4aca-4e46-912d-8718c5e12c97" />

- Terdapat tombol dengan ikon pensil berwarna hijau pada card setiap penghuni, pilih penghuni yang ingin diperbarui waktu pembayarannya dengan menekan tombol tersebut.

<img width="684" height="912" alt="image" src="https://github.com/user-attachments/assets/e229aa09-ed11-45c9-b50b-550bb181f48b" />

- Setelah ditekan pengguna dapat memperbarui waktu pembayaran dengan memilih bulan dan tahun penghuni melakukan pembayaran, jika sudah selesai memlih bulan dan tahun teka simpan untuk melakukan perbaruan waktu pembayaran.

<img width="682" height="218" alt="image" src="https://github.com/user-attachments/assets/df39fadc-7027-4627-b152-5202ef88248f" />

- Tunggakan dan status pembayaran akan berubah jika si penghuni sudah tidak memiliki tagihan yang belum terbayar.

## D. Halaman Login
<img width="776" height="913" alt="Image" src="https://github.com/user-attachments/assets/29cb2574-cd7a-4ec6-94bd-053c55662f07" />

<img width="776" height="914" alt="Image" src="https://github.com/user-attachments/assets/7532eba5-a463-4b55-af04-b76cd7dd6a05" />

<img width="775" height="912" alt="Image" src="https://github.com/user-attachments/assets/ceea1131-9e19-4610-b5be-50e6cdf6b5a6" />

<img width="776" height="914" alt="Image" src="https://github.com/user-attachments/assets/9e9c738e-744e-4011-9316-2984e5ba7f7d" />

## E.  Halaman Registrasi
<img width="775" height="910" alt="Image" src="https://github.com/user-attachments/assets/2f572b3b-86ef-4abd-b30f-e4d604065c7c" />

<img width="775" height="912" alt="Image" src="https://github.com/user-attachments/assets/22a26a87-0a25-4492-ad0e-84c0497e3700" />

<img width="774" height="907" alt="Image" src="https://github.com/user-attachments/assets/944ccdbb-317f-48a5-a927-bbe5a32f8d74" />

<img width="777" height="908" alt="Image" src="https://github.com/user-attachments/assets/4da9f0b1-7790-42a4-a60c-36df7d6e96e3" />

<img width="778" height="914" alt="Image" src="https://github.com/user-attachments/assets/15aaf33b-b0b9-4b40-a348-5469c6d2e542" />

## F. Darkmode & Lightmode
<img width="777" height="910" alt="Image" src="https://github.com/user-attachments/assets/735a0520-4dd0-4b9b-a6da-ec1a6e547bed" />

<img width="783" height="914" alt="Image" src="https://github.com/user-attachments/assets/3f584b27-b224-4d28-8700-9ab049e6541e" />

<img width="778" height="913" alt="Image" src="https://github.com/user-attachments/assets/3a7c52b0-3103-48e3-a899-248371fc303e" />

# 3. Penggunaan Widget
## A. Widget Halaman Penghuni
### a. Scaffold
<img width="377" height="120" alt="image" src="https://github.com/user-attachments/assets/1d78ccda-0363-4cec-a773-57b21b2a6db3" />

Scaffold disini berfungsi sebagai kerangka halaman yang menjadi struktur dasar dan didalamnya menyediakan layout standar halaman seperti AppBar, body, dan floatingActionButton.

### b. AppBar
<img width="367" height="83" alt="image" src="https://github.com/user-attachments/assets/8745d527-89c1-4650-9c98-ecd12eb1649c" />

AppBar bentuknya adalah sebuah bar di atas halaman yang biasanya berisi judul halaman atau tombol aksi yang berfungsi untuk menampilkan judul "Data Penghuni" dan memberi warna biru muda menggunakan backgroundColor.

### c. ListView.builder
<img width="460" height="612" alt="image" src="https://github.com/user-attachments/assets/d0a782f9-44fa-4249-8fe1-797bd884b451" />

ListView.builder adalah sebuah widget yang dapat di scroll dan bisa menampilkan data panjang secara efisien. Dalam page ini digunakan untuk menampilkan daftar penghuni secara vertikal. 

### d. Center
<img width="342" height="33" alt="image" src="https://github.com/user-attachments/assets/c7d34003-95cd-49eb-96c6-f887bb147113" />

Widget ini akan berfungsi saat list kosong, teks "Belum ada data" akan muncul di tengah halaman.

### e. Card
<img width="423" height="496" alt="image" src="https://github.com/user-attachments/assets/161b9c44-ec48-4611-8b8d-a730b289934b" />

Card adalah widget container dengan efek bayangan dan border radius default. Dalam page ini fungsinya adalah membungkus setiap item penghuni agar tampak seperti kartu terpisah.

### f. ListTile
<img width="405" height="444" alt="image" src="https://github.com/user-attachments/assets/f9380ed8-193e-45a8-b7e9-85b69c3c2252" />

Listile adalah widget siap pakai untuk list item, dengan title, subtitle, dan ikon/action. Kegunaannya adalah untuk menampilkan detail data penghuni (nama, nim, nik, kamar, dan kampus)

### g. Row
<img width="392" height="235" alt="image" src="https://github.com/user-attachments/assets/21417c72-1391-442b-b2af-23fa690595e0" />

Row berfungsi untuk menyusun widget secara horizontal, dalam pae ini kegunannya adalah memposisikan tombol edit dan delete sejajar secara horizontal di akhir ListTile.

### h. IconButton
<img width="376" height="152" alt="image" src="https://github.com/user-attachments/assets/7e9c3131-df3b-42a3-8e48-6e13f3b111eb" />

Widget ini adalah sebuah tombol berbasis ikon, dalam page ini fungsinya sebagai tombol aksi untuk edit dan hapus penghuni.

### i. FloatingActionButton
<img width="439" height="187" alt="image" src="https://github.com/user-attachments/assets/8250d2eb-b4dc-42a7-84b2-ecc724ee0bd9" />

Widget berbentuk tombol mengambang di atas konten, dalam page ini berfungsi sebagai tombol untuk menambah penghuni baru.

### j. SnackBar
<img width="382" height="116" alt="image" src="https://github.com/user-attachments/assets/35bd6613-990d-44a7-beaa-c296dc5d1d7b" />

Bentuknya adalah widget notifikasi sementara yang muncul dari bawah dan berfungsi sebagai feedback ke pengguna setelah berhasil menambah, mengedit, dan menghapus data penghuni.

## B. Widget Halaman Kamar
### a. Scaffold
<img width="342" height="117" alt="image" src="https://github.com/user-attachments/assets/1e6ea6f4-f8a7-4b49-b075-f68cc233dfdf" />

Scaffold adalah widget layout utama untuk membuat struktur halaman standar Flutter. Di KamarPage, fungsinya adalah menyediakan area untuk AppBar dan body, serta mengatur background halaman dengan warna biru muda.

### b. Appbar
<img width="287" height="70" alt="image" src="https://github.com/user-attachments/assets/dc8fd48b-41f0-457d-acad-b45e4969e4db" />

AppBar adalah bar navigasi di atas halaman. Di page ini menampilkan judul "Data Kamar" dan diberi warna latar biru agar konsisten dengan tema aplikasi.

### c. ListView.builder
<img width="452" height="417" alt="image" src="https://github.com/user-attachments/assets/80b5815e-5f34-44ff-835c-6ec6a9810d08" />

ListView.builder adalah widget scrollable yang menampilkan daftar data secara efisien. Di KamarPage, digunakan untuk membuat daftar kamar berdasarkan kamarList secara dinamis.

### d. Card
<img width="434" height="201" alt="image" src="https://github.com/user-attachments/assets/a0bb7447-240c-47b6-8021-594163d2fd75" />

Card adalah widget container dengan efek bayangan dan border radius default. Dalam page ini, Card membungkus setiap item kamar agar tampak seperti kartu terpisah dan lebih mudah dibaca.

### e. ListTile
<img width="419" height="151" alt="image" src="https://github.com/user-attachments/assets/4eb6fcc4-6752-4261-8111-b833a34a4fe3" />

ListTile adalah widget untuk membuat bar daftar dengan layout standar (leading, title, subtitle, trailing). Di page ini digunakan untuk menampilkan detail kamar, jumlah penghuni, dan status kamar.

### f. Icon
<img width="289" height="24" alt="image" src="https://github.com/user-attachments/assets/85107532-8abe-4c68-aa27-a4645f05a41c" />

Icon adalah widget untuk menampilkan ikon. Di KamarPage, digunakan Icons.meeting_room untuk menunjukkan simbol kamar di setiap ListTile.

### g. Chip
<img width="425" height="71" alt="image" src="https://github.com/user-attachments/assets/3404dafe-06c7-4091-83cd-afed99461aff" />

Chip adalah widget untuk menampilkan label kecil berbentuk kapsul. Di sini, digunakan untuk menandai status kamar (Penuh atau Tersedia) dengan warna merah jika penuh dan hijau jika tersedia.

## C. Widget Form Penghuni
### a. Scaffold
<img width="498" height="152" alt="image" src="https://github.com/user-attachments/assets/4dcfd567-a97c-484b-b254-a7664130d7a7" />

Scaffold adalah widget dasar layout halaman yang menyediakan struktur seperti AppBar, body, dan FloatingActionButton. Di halaman ini, Scaffold membungkus seluruh form dan memberikan background biru pucat

### b. Appbar
<img width="494" height="100" alt="image" src="https://github.com/user-attachments/assets/3b5fff90-6a2e-4e25-8e6c-6b8020ee11c6" />

AppBar adalah widget bar horizontal di atas halaman yang menampilkan judul. Di sini, fungsinya menunjukkan apakah pengguna sedang menambah atau mengedit penghuni dengan warna biru.

### c. Padding
<img width="297" height="36" alt="image" src="https://github.com/user-attachments/assets/840e1ba1-9ec9-437f-8301-ee7568e022e8" />

adding adalah widget yang memberikan jarak di sekeliling child-nya. Di page ini, padding 16 digunakan agar form tidak menempel ke tepi layar.

### d. Form
<img width="389" height="49" alt="image" src="https://github.com/user-attachments/assets/5aecd289-c2c4-4d26-847f-f96c73789ffe" />

Form adalah widget container untuk kumpulan input dan validasinya. Di sini, Form membungkus seluruh TextFormField dan DropdownButtonFormField agar bisa divalidasi sebelum disimpan.

### e. Column
<img width="277" height="172" alt="image" src="https://github.com/user-attachments/assets/e812875e-2626-4779-b8f4-6ba33dd56728" />

Column adalah widget layout vertikal yang menampilkan child-child secara berurutan dari atas ke bawah. Di FormPenghuniPage, Column digunakan untuk menyusun semua TextFormField, DropdownButtonFormField, SizedBox, dan tombol “Simpan” secara vertikal.

### f. TextFormField
<img width="366" height="615" alt="image" src="https://github.com/user-attachments/assets/26c5938d-a689-439e-abe4-830f538b1b93" />

TextFormField adalah widget input teks dengan dukungan validasi. Di page ini digunakan untuk memasukkan Nama, NIM, No HP, NIK, dan Kampus penghuni, masing-masing dengan validator khusus.

### g. SizedBox
<img width="265" height="333" alt="image" src="https://github.com/user-attachments/assets/bc49da05-4959-4509-a087-b3933e770117" />

SizedBox adalah widget spacer yang memberikan jarak vertikal antar input atau tombol. Di sini, digunakan untuk memberi jarak 12–20 pixel antar field agar tampilan lebih rapi.

### h. DropdownButtonFormField
<img width="365" height="96" alt="image" src="https://github.com/user-attachments/assets/e7c0e190-b84b-4f32-b7ed-19e04b914a63" />

DropdownButtonFormField adalah widget dropdown yang mendukung validasi form. Fungsinya memilih Nomor Kamar dan menampilkan sisa kapasitas kamar secara otomatis.

### i. DropdownMenuItem
<img width="370" height="70" alt="image" src="https://github.com/user-attachments/assets/f601c477-dbdd-4d5d-bd11-504896c89092" />

DropdownMenuItem adalah item tunggal dalam dropdown. Di page ini, setiap DropdownMenuItem mewakili satu kamar (A1 sampai B3) yang bisa dipilih user saat memilih kamar.

### j. ElevatedButton
<img width="351" height="140" alt="image" src="https://github.com/user-attachments/assets/357a3225-0f96-481b-9b0e-9f0e6be29441" />

ElevatedButton adalah tombol dengan efek mengangkat (raised). Di page ini, tombol “Simpan” memicu fungsi simpan() untuk menambah atau mengedit data penghuni, dengan warna biru menonjol.

### k. GlobalKey<FormState>
<img width="430" height="46" alt="image" src="https://github.com/user-attachments/assets/c747f71b-3b07-4a4d-98a4-a8f15a02ae2a" />

GlobalKey<FormState> adalah kunci unik untuk mengontrol dan mengakses state dari form. Di page ini, _formKey digunakan untuk memicu validasi semua field sekaligus sebelum menyimpan data.

### l. ScaffoldMessenger & SnackBar
<img width="387" height="136" alt="image" src="https://github.com/user-attachments/assets/72ba1eee-eeed-4e41-89e5-281724506ae3" />

ScaffoldMessenger & SnackBar adalah kombinasi widget untuk menampilkan pesan sementara di layar. SnackBar muncul dari bawah untuk memberi feedback, misal ketika data berhasil ditambahkan, diubah, atau terjadi error (misal NIK sudah ada atau kamar penuh), dengan warna hijau untuk sukses dan merah untuk error.

## D. Widget Halaman Keuangan
### a. Scaffold
<img width="391" height="115" alt="image" src="https://github.com/user-attachments/assets/de6838c5-57d3-460c-a8a9-1eae5055a9a0" />

Scaffold adalah widget dasar untuk struktur halaman, menyediakan layout standar seperti AppBar, body, dan FloatingActionButton. Di TagihanPage, Scaffold membungkus seluruh halaman keuangan asrama, termasuk daftar tagihan penghuni.

### b. Appbar
img width="324" height="70" alt="image" src="https://github.com/user-attachments/assets/e3279c61-d5b6-4aaa-9f88-ebf794c232b3" />

AppBar adalah widget bar di bagian atas halaman. Fungsinya di sini menampilkan judul halaman "Menu Keuangan Asrama" dengan warna biru

### c. ListView.builder
<img width="449" height="580" alt="image" src="https://github.com/user-attachments/assets/91f97ce7-25c8-42e9-81a8-ee6cebf0940c" />

ListView.builder adalah widget scrollable yang membuat daftar item secara dinamis. Di page ini digunakan untuk menampilkan setiap penghuni beserta status tunggakan mereka.

### d. Card
<img width="426" height="431" alt="image" src="https://github.com/user-attachments/assets/3da9a93e-fa31-4782-aebc-d15329f99fb3" />

Card adalah container dengan efek bayangan dan border radius default. Di sini membungkus setiap item penghuni agar tampak seperti kartu terpisah.

### e. ListTile
<img width="395" height="312" alt="image" src="https://github.com/user-attachments/assets/c5cdbd5b-36d3-4f3e-a55e-9b63471a75ed" />

ListTile adalah widget standar untuk menampilkan elemen daftar dengan title, subtitle, dan trailing. Di page ini, title menampilkan nama penghuni, subtitle menampilkan kamar, terakhir bayar, tunggakan, dan status, sedangkan trailing berisi tombol edit pembayaran.

### f. IconButton
<img width="380" height="68" alt="image" src="https://github.com/user-attachments/assets/9540eeca-376d-4dae-bde9-a2aea8f51809" />

IconButton adalah tombol berbentuk ikon. Di page ini digunakan untuk memicu fungsi updatePembayaran agar user bisa memperbarui bulan/tahun pembayaran.

### g. AlertDialog
<img width="306" height="76" alt="image" src="https://github.com/user-attachments/assets/5d4321e9-bb3d-4c53-86c6-51c3bded7c2a" />

AlertDialog adalah dialog pop-up untuk interaksi. Di page ini muncul saat update pembayaran, menampilkan form pemilihan bulan dan tahun terakhir bayar.

### h. Column
<img width="348" height="252" alt="image" src="https://github.com/user-attachments/assets/04b4c375-f2ae-4ec7-b7cc-9a288325d4d0" />

Column adalah widget layout vertikal. Digunakan di AlertDialog untuk menampilkan dua dropdown (DropdownButtonFormField) secara vertikal.

### i. DropdownButtonFormField
<img width="410" height="266" alt="image" src="https://github.com/user-attachments/assets/b69e3f53-590c-42db-8e40-62d94b31443d" />

DropdownButtonFormField adalah dropdown dengan validasi form. Di page ini digunakan untuk memilih bulan dan tahun pembayaran terakhir.

### j. SizedBox
<img width="213" height="39" alt="image" src="https://github.com/user-attachments/assets/93b5c851-3b23-460a-9e5d-aefce547ad01" />

SizedBox adalah widget spacer yang digunakan untuk memberi jarak antar widget. Di page ini, SizedBox(height: 10) digunakan di dalam AlertDialog untuk memberi jarak vertikal antara dropdown bulan dan dropdown tahun agar tampilannya rapi dan tidak terlalu mepet.

### k. TextButton & ElevatedButton
<img width="343" height="292" alt="image" src="https://github.com/user-attachments/assets/27e2bdf7-26cf-4b32-bd1d-6c4538d4e408" />


TextButton adalah tombol teks. Di page ini tombol “Batal” menutup dialog tanpa perubahan.
ElevatedButton adalah tombol dengan efek raised. Di page ini tombol “Simpan” menyimpan perubahan pembayaran dan menutup dialog.

## E. Widget Main Page
### a. Scaffold
<img width="500" height="497" alt="image" src="https://github.com/user-attachments/assets/adfab4b1-c6eb-498f-826b-a39abd0ef808" />

Scaffold disini berfungsi sebagai kerangka halaman yang menjadi struktur halaman utama dan didalamnya menyediakan layout standar halaman seperti AppBar, body, dan BottomNavigationBar. Dalam page ini digunakan untuk menampilkan halaman aktif (PenghuniPage, KamarPage, atau TagihanPage).

### b. IndexedStack
<img width="479" height="137" alt="image" src="https://github.com/user-attachments/assets/caaf18b5-70bd-4ab1-8cc0-58b79037e3bd" />

Fungsi dari widget ini adalah menumpuk beberapa widget dan hanya menampilkan widget sesuai index aktif. Dalam page ini digunakan untuk mengatur switching tanpa mereload data dan _currentIndex menentukan halaman mana yang sedang ditampilkan.

### c. BottomNavigationBar
<img width="297" height="116" alt="image" src="https://github.com/user-attachments/assets/16e804f4-b33b-4fd6-a12e-7fe477e2d1a4" />

Widget ini berfungsi untuk menyediakan menu navigasi di bawah layar untuk berpindah antar halaman. kegunaan dalam page ini adalah untuk emberikan akses cepat ke halaman Penghuni, Kamar, dan Keuangan. Kegunaan kedua adalah Saat tombol diklik (onTap), _currentIndex berubah halaman di IndexedStack ikut berubah.

### d. BottomNavigationBarItem
<img width="457" height="151" alt="image" src="https://github.com/user-attachments/assets/94d5d1ba-490f-4ec9-a819-b8d658bf177b" />

Widget ini memiliki fungsi sebagai representasi satu tombol di BottomNavigationBar, dalam page ini berguna untuk memunculkan ikon tombol dan ada label teks yang muncul dibawah ikon.

### f. StatefulWidget
<img width="271" height="39" alt="image" src="https://github.com/user-attachments/assets/765fa806-8cf1-47bd-ae13-8dfaf442e321" />

StatefulWidget adalah widget yang memiliki state bisa berubah yang fungsinya dalam page ini agar ketika user menekan menu di BottomNavigationBar, UI bisa diupdate secara otomatis tanpa reload seluruh halaman.

### g. initState
<img width="255" height="89" alt="image" src="https://github.com/user-attachments/assets/9c37e375-c3db-48e1-92fc-bbb0ea0b9c13" />

Fungsi dari widget ini adalah sebagai lifecycle State untuk inisialisasi state sebelum build. Dalam page ini berguna untuk Membuat data dummy (listPenghuni, listTagihan) saat halaman pertama kali dibuat.

- login


-regis





