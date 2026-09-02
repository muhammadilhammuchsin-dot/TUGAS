import 'package:flutter/material.dart';

void main(){
  runApp(const App());
}

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme:ThemeData(
        primarySwatch:Colors.indigo,
      ),
      home:const HomePage(),
    );
  }
}

String kategoriRating(double rating){
  if(rating>=4.5){
    return "Sangat Baik";
  }else if(rating>=3.5){
    return "Baik";
  }else{
    return "Cukup";
  }
}

String statusBuku(bool tersedia){
  return tersedia?"Tersedia":"Dipinjam";
}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState()=>_HomePageState();
}

class _HomePageState extends State<HomePage>{

  String cari="";

  List<Map<String,dynamic>> buku=[
    {
      "judul":"Laskar Pelangi",
      "pengarang":"Andrea Hirata",
      "tahunTerbit":2005,
      "rating":4.8,
      "tersedia":true,
      "genre":"Novel",
      "catatanPeminjam":null
    },
    {
      "judul":"Bumi Manusia",
      "pengarang":"Pramoedya Ananta Toer",
      "tahunTerbit":1980,
      "rating":4.6,
      "tersedia":false,
      "genre":"Sejarah",
      "catatanPeminjam":"Dikembalikan minggu depan"
    },
    {
      "judul":"Negeri 5 Menara",
      "pengarang":"Ahmad Fuadi",
      "tahunTerbit":2009,
      "rating":4.5,
      "tersedia":true,
      "genre":"Inspirasi",
      "catatanPeminjam":null
    },
    {
      "judul":"Harry Potter dan Batu Bertuah",
      "pengarang":"J.K. Rowling",
      "tahunTerbit":1997,
      "rating":4.7,
      "tersedia":true,
      "genre":"Fantasi",
      "catatanPeminjam":null
    },
    {
      "judul":"Filosofi Teras",
      "pengarang":"Henry Manampiring",
      "tahunTerbit":2018,
      "rating":4.4,
      "tersedia":false,
      "genre":"Motivasi",
      "catatanPeminjam":"Sedang dipinjam siswa"
    },
    {
      "judul":"Matematika Dasar",
      "pengarang":"Budi Santoso",
      "tahunTerbit":2020,
      "rating":4.2,
      "tersedia":true,
      "genre":"Pendidikan",
      "catatanPeminjam":null
    }
  ];


  @override
  Widget build(BuildContext context){

    Set<String> genre=
    buku.map((e)=>e["genre"].toString()).toSet();


    List<Map<String,dynamic>> hasil=
    buku.where((item){

      return item["judul"]
          .toString()
          .toLowerCase()
          .contains(cari.toLowerCase());

    }).toList();


    return Scaffold(

      appBar:AppBar(
        title:const Text("📚 Katalog Buku Perpustakaan Mini"),
        centerTitle:true,
      ),


      body:Column(

        children:[

          Padding(
            padding:const EdgeInsets.all(10),
            child:Column(

              children:[

                Wrap(
                  spacing:8,
                  children:genre.map((g){
                    return Chip(
                      label:Text(g),
                    );
                  }).toList(),
                ),

                const SizedBox(height:10),

                TextField(

                  decoration:const InputDecoration(
                    hintText:"Cari judul buku",
                    border:OutlineInputBorder(),
                    prefixIcon:Icon(Icons.search),
                  ),

                  onChanged:(value){

                    setState((){

                      cari=value;

                    });

                  },

                ),

              ],

            ),

          ),


          Expanded(

            child:ListView.builder(

              itemCount:hasil.length,

              itemBuilder:(context,index){

                var data=hasil[index];

                return Card(

                  margin:const EdgeInsets.all(8),

                  elevation:4,

                  child:ListTile(

                    title:Text(

                      data["judul"],

                      style:const TextStyle(
                        fontWeight:FontWeight.bold,
                      ),

                    ),

                    subtitle:Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children:[

                        Text(
                          "Pengarang : ${data["pengarang"]}",
                        ),

                        Text(
                          "Tahun Terbit : ${data["tahunTerbit"]}",
                        ),

                        Text(
                          "Rating : ${data["rating"]}",
                        ),

                        Text(
                          "Kategori : ${kategoriRating(data["rating"])}",
                        ),

                        Text(
                          "Genre : ${data["genre"]}",
                        ),

                        Text(

                          statusBuku(data["tersedia"]),

                          style:TextStyle(

                            color:data["tersedia"]
                                ?Colors.green
                                :Colors.red,

                            fontWeight:
                            FontWeight.bold,

                          ),

                        )

                      ],

                    ),


                    onTap:(){

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder:(context)=>

                              DetailPage(

                                buku:data,

                              ),

                        ),

                      );

                    },


                  ),

                );

              },

            ),

          )

        ],

      ),

    );

  }

}



class DetailPage extends StatefulWidget{

  final Map<String,dynamic> buku;

  const DetailPage({

    super.key,

    required this.buku,

  });


  @override
  State<DetailPage> createState()
  =>_DetailPageState();

}


class _DetailPageState extends State<DetailPage>{

  String? catatanPeminjam;


  @override
  void initState(){

    super.initState();

    catatanPeminjam=
    widget.buku["catatanPeminjam"];

  }


  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar:AppBar(
        title:const Text("Detail Buku"),
      ),

      body:Padding(

        padding:const EdgeInsets.all(20),

        child:Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children:[

            Text(

              widget.buku["judul"],

              style:const TextStyle(

                fontSize:24,

                fontWeight:
                FontWeight.bold,

              ),

            ),

            const SizedBox(height:15),

            Text(
              "Pengarang : ${widget.buku["pengarang"]}",
            ),

            Text(
              "Tahun Terbit : ${widget.buku["tahunTerbit"]}",
            ),

            Text(
              "Rating : ${widget.buku["rating"]}",
            ),

            Text(
              "Kategori : ${kategoriRating(widget.buku["rating"])}",
            ),

            Text(
              "Genre : ${widget.buku["genre"]}",
            ),

            const SizedBox(height:10),

            Text(

              "Catatan Peminjam : "
                  "${catatanPeminjam ?? "Tidak ada catatan"}",

            ),

          ],

        ),

      ),

    );

  }

}