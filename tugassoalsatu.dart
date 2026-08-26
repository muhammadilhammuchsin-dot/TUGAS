void main() {
  Map<String, dynamic> mahasiswa = {
    "Muhammad Ilham Muchsin": {
      "nilai": [90, 85, 90, 88, 78],
      "absensi": 3,
    },

    "Muhammad Arkan": {
      "nilai": [83, 67, 70, 82, 78],
      "absensi": 3,
    },

    "Muhammad Adrian": {
      "nilai": [90, 95, 70, 40, 44],
      "absensi": 3,
    },

    "Raidinda": {
      "nilai": [92, 85, 70, 86, 78],
      "absensi": 3,
    },

    "Silvi": {
      "nilai": [40, 85, 20, 56, 78],
      "absensi": 3,
    },
  };

  List<double> semuaRataRata = [];
  List<int> semuaNilai = [];

  print("=== LAPORAN NILAI MAHASISWA ===\n");

  mahasiswa.forEach((nama, data) {
    List<int> nilai = data["nilai"];
    int absensi = data["absensi"];

    double rataRata = hitungRataRata(nilai);
    String grade = tentukanGrade(rataRata);

    bool status = cekKelulusan(rataRata: rataRata, absensi: absensi);

    semuaRataRata.add(rataRata);
    semuaNilai.addAll(nilai);

    print("Nama : $nama");
    print("Nilai : $nilai");
    print("Rata-Rata : ${rataRata.toStringAsFixed(1)}");
    print("Grade : $grade");
    print("Status : ${status ? "LULUS" : "TIDAK LULUS"}");
    print("");
  });

  double rataRataKelas =
      semuaRataRata.reduce((a, b) => a + b) / semuaRataRata.length;

  int nilaiTertinggi = semuaNilai.reduce((a, b) => a > b ? a : b);
  int nilaiTerendah = semuaNilai.reduce((a, b) => a < b ? a : b);

  print("===STATISTIKA KELAS===");
  print("Nilai Tertinggi : $nilaiTertinggi");
  print("Nilai Terendah : $nilaiTerendah");
  print("Rata-Rata kelas : ${rataRataKelas.toStringAsFixed(1)}");
}

double hitungRataRata(List<int> nilai) {
  int total = 0;

  for (int angka in nilai) {
    total += angka;
  }
  return total / nilai.length;
}

String tentukanGrade(double rataRata) {
  if (rataRata >= 85) {
    return "A";
  } else if (rataRata >= 70) {
    return "B";
  } else if (rataRata >= 60) {
    return "C";
  } else if (rataRata >= 50) {
    return "D";
  } else {
    return "E";
  }
}

bool cekKelulusan({required double rataRata, required int absensi}) {
  return rataRata >= 60 && absensi <= 3;
}
