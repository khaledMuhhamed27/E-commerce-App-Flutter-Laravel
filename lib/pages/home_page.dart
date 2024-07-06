import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/pages/categories_product.dart';
import 'package:flutter_application_10/pages/items_page.dart';
import 'package:flutter_application_10/pages/search_page.dart';
import 'package:flutter_application_10/providers/home_provider.dart';
import 'package:flutter_application_10/widgets/app_bar_widget.dart';
import 'package:flutter_application_10/widgets/categories_widget.dart';
import 'package:flutter_application_10/widgets/my_drawer_widget.dart';
import 'package:flutter_application_10/widgets/newest_item_widget.dart';
import 'package:flutter_application_10/widgets/popular_item_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: homeProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                AppBarWidget(),
                buildSearchBar(context),
                buildCategorySection(homeProvider),
                buildPopularSection(homeProvider),
                buildNewestSection(homeProvider),
              ],
            ),
      drawer: MYyDrawerWidget(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(
                        searchResults: _searchController.text,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Icon(CupertinoIcons.search, color: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'What would you like to have?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategorySection(HomeProvider homeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeProvider.categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryProductScreen(homeProvider.categories[index]),
                    ),
                  );
                },
                child: CategoriesWidget(
                  CategoriesNameProduct: homeProvider.categories[index]['name'],
                  CategoriesProdCpount: homeProvider.categories[index]
                          ['products_count']
                      .toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildPopularSection(HomeProvider homeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Popular",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeProvider.products.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemsPage(
                        currentAddress: homeProvider.products[index],
                      ),
                    ),
                  );
                  print("object");
                },
                child: PopularItemWidget(
                  ImageSrc:
                      buildProductImage(homeProvider.products[index]['image']),
                  descProd: homeProvider.products[index]['description'],
                  nameProd: homeProvider.products[index]['name'],
                  priceProd: homeProvider.products[index]['price'].toString(),
                  yourIcon: Icons.favorite_border,
                  onTap: () => homeProvider
                      .addToWishlist(homeProvider.products[index]['id']),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildNewestSection(HomeProvider homeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Text(
            "Newest",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            itemCount: homeProvider.products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemsPage(
                          currentAddress: homeProvider.products[index],
                        ),
                      ),
                    );
                  },
                  child: NewestItemWidget(
                    ImageSrc: buildProductImage(
                        homeProvider.products[index]['image']),
                    descProd: homeProvider.products[index]['description'],
                    nameProd: homeProvider.products[index]['name'],
                    priceProd: homeProvider.products[index]['price'].toString(),
                    yourIcon: Icons.favorite_border,
                    onTap: () => homeProvider
                        .addToWishlist(homeProvider.products[index]['id']),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildProductImage(String? imageUrl) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: imageUrl != null
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.error,
                size: 100,
                color: Colors.red,
              ),
            )
          : Icon(
              Icons.image,
              size: 200,
              color: Colors.grey,
            ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, 'myorders');
        },
        child: Icon(
          CupertinoIcons.cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
