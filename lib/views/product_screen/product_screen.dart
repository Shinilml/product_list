import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:product_list/controller/productscreencontroller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Productscreencontroller>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controllerobj = Provider.of<Productscreencontroller>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: appbarsection(),
      body: Builder(
        builder: (context) {
          if (controllerobj.isLoadingProducts) {
            return const Center(child: CircularProgressIndicator());
          } else if (controllerobj.resobj == null ||
              controllerobj.resobj!.isEmpty) {
            return const Center(child: Text("No products available."));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Products",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.swap_vert,
                                color: Colors.black),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.filter_alt_outlined,
                                color: Colors.black),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  productsection(controllerobj),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Expanded productsection(Productscreencontroller controllerobj) {
    return Expanded(
      child: GridView.builder(
        itemCount: controllerobj.resobj!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          final product = controllerobj.resobj![index];
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(product.images?.first ?? ''),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  product.title ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "\$${product.price?.toString() ?? ''}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    5,
                    (i) => Icon(
                      i < (product.rating?.floor() ?? 0)
                          ? Icons.star
                          : Icons.star_border,
                      size: 14,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar appbarsection() {
    return AppBar(
      backgroundColor: Colors.grey.shade300,
      elevation: 0,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search products',
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
        ),
      ),
      leading: const Icon(Icons.menu, color: Colors.black),
    );
  }
}
