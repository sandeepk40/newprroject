import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haggle/forms/profile_form.dart';
import 'package:haggle/provider/category_provider.dart';
import 'package:haggle/screens/product_list.dart';
import 'package:haggle/services/firebase_services.dart';
import 'package:haggle/widgets/banner_widget.dart';
import 'package:haggle/widgets/carousel_images.dart';
import 'package:haggle/widgets/category_widget.dart';
import 'package:haggle/widgets/custom_appbar.dart';
import 'package:haggle/widgets/scrollcontroller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';


  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = 'India';
  FirebaseService _service = FirebaseService();
  ScrollController myController = ScrollController();


  @override
  Widget build(BuildContext context) {
    var _catProvider = Provider.of<CategoryProvider>(context);
    ScrollController _scrollController =  ScrollController();
  bool goToTop = false;
  bool isLast = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        goToTop = _scrollController.offset > 100 ? true : false;
        isLast = _scrollController.offset >
                _scrollController.position.maxScrollExtent
            ? true
            : false;
      });
    });
  }
  
   @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

    _catProvider.clearSelectedCat();

    return RefreshIndicator(
      onRefresh: ()async{
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: SafeArea(
              child: CustomAppBar(),
            ),
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            physics: const ScrollPhysics(),
            child: Stack(
              children: [
                
            buildBTT(_scrollController, goToTop),
            buildText(isLast),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: Column(
                          children: const [
                            CarouselImages(),
                            CategoryWidget(),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    const ProductList(
                      proScreen: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //    setState(() {
        //       myController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeIn);
        //    });
        //   },
        //   backgroundColor: Colors.black,
        //   child: const Icon(Icons.arrow_upward_sharp),
        // ),
      ),
    );
  }
}
