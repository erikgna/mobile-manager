// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.blue,
            ),
            padding: EdgeInsets.only(top: 64),
            height: 264,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Erik Gabriel Na',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Monday, 17 jan 2022',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              '08',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Categories\n registred',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '08',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Categories\n registred',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 204),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 156,
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.access_time_filled),
                                SizedBox(height: 16),
                                Text(
                                  'New Category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Create new categories',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 24),
                          Container(
                            width: 156,
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.access_time_filled),
                                SizedBox(height: 16),
                                Text(
                                  'New Password',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Create new password',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 156,
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.access_time_filled),
                                SizedBox(height: 16),
                                Text(
                                  'List Category',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'See your categories',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 24),
                          Container(
                            width: 156,
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.access_time_filled),
                                SizedBox(height: 16),
                                Text(
                                  'List Password',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'See your passwords',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 64),
                      Center(
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 32,
                            child: ElevatedButton(
                                child: Text('Deslogar Usuário',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
