import 'package:flutter/material.dart';
import 'package:mfb/home/home_screen/searchScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image_profile.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Hi, Shadi',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons
                .notifications_none_outlined), /* color: Theme.of(context).canvasColor,*/
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchScreen()));
              },
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Icon(
                      Icons.tune_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Category',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buildCategoryItem(),
                separatorBuilder: (context, index) => SizedBox(
                  width: 20.0,
                ),
                itemCount: 5,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Popular Players',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        //shrinkWrap: true,
                        //physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildPopularPlayerItem(),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryItem() => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Material(elevation: 10.0, color: Colors.grey),
            Image.asset(
              'assets/images/striker_category.png',
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            Container(
              height: 30,
              width: 100.0,
              color: Theme.of(context).buttonColor,
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                  child: Text(
                'Goal Keeper',
                style: Theme.of(context).textTheme.bodyText2,
              )),
            ),
          ],
        ),
      );

  Widget buildPopularPlayerItem() => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Theme.of(context).cardColor),
        child: Row(
          children: [
            Image.asset('assets/images/player.png'),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ahmed Shadi'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '22 Years old',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Striker',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                          size: 21,
                        ),
                        Expanded(
                          child: Text(
                            'Cairo,Egypt',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.favorite_outline_sharp,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );



}
