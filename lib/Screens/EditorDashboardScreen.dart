import 'package:flutter/material.dart';
class EditorDashboardScreen extends StatefulWidget {
  const EditorDashboardScreen({super.key});

  @override
  State<EditorDashboardScreen> createState() => _EditorDashboardScreenState();
}

class _EditorDashboardScreenState extends State<EditorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: const Text('Dashboard',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
      backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
           const Text('Top Rated Writers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
           ElevatedButton(
        
               style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
               onPressed: (){}, child: const Text('See All',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),))
         ],),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Column(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person,size: 30,),
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text('Amman',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                      ],
                    ),
                  ],),
                ),
              ),const SizedBox(width: 5,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,width: 120,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Column(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person,size: 30,),
                      ),
                    ),
                    SizedBox(height: 2,),
                    Text('Ahmed',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                      ],
                    ),
                  ],),
                ),
              ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Column(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person,size: 30,),
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Faizan',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                        ],
                      ),
                    ],),
                  ),
                ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Column(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person,size: 30,),
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Ukasha',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                        ],
                      ),
                    ],),
                  ),
                ),const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: const Column(children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person,size: 30,),
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Usama',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 10,
                          ),
                        ],
                      ),
                    ],),
                  ),
                ),
        
            ],),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Top Rated Movies',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ElevatedButton(
        
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                  onPressed: (){}, child: const Text('See All',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),))
            ],),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Image.asset('Images/parwaz2.jpg',fit: BoxFit.cover),
                ),
              ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/Dukhtar1.png',fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/waar1.jpg',fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/actorinlaw1.jpg',fit: BoxFit.cover),
                  ),
                )
            ],),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Top Rated Darama',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ElevatedButton(
        
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black,),
                  onPressed: (){}, child: const Text('See All',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),))
            ],),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/snge2.jpg',fit: BoxFit.fill,
                    height: 50,
                    width: 60,),
                  ),
                ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/dyar1.jpg',fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/ahdewafa2.jpg',fit: BoxFit.fill),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Image.asset('Images/manm2.jpg',fit: BoxFit.fill),
                  ),
                )
              ],),
          ),
        
        ],),
      ),
    );
  }
}
