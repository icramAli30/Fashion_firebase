import 'package:flutter/material.dart';

import '../const/all_colors.dart';

class OrderScreens extends StatefulWidget {
  const OrderScreens({super.key});

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {

  String paymentMethod = "bkash";
  String city = "Dhaka";
  String? upazila;

  Map<String, List<String>> upazilas = {
    "Dhaka": [
      "Dhamrai",
      "Dohar",
      "Keraniganj",
      "Nawabganj",
      "Savar",
    ],
    "Gazipur": [
      "Gazipur Sadar",
      "Kaliakair",
      "Kaliganj",
      "Kapasia",
      "Sreepur",
    ],
  };

  List<String> selectedUpazilas = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.whiteColors,

      appBar: AppBar(
        backgroundColor: AllColors.whiteColors,
        title: Text("Checkout"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            /// Shipping Information
            Card(
              color:AllColors.whiteColors,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     Text(
                      "Shipping Information",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: [

                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              labelStyle:  TextStyle(
                                color: AllColors.secondaryColors,
                                fontSize: 16,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.broderColors,
                                  width: 1.5,
                                ),
                              ),

                              floatingLabelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                                fontWeight: FontWeight.bold,
                              ),


                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.primaryColors,
                                  width: 2,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                         SizedBox(width: 15),

                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Phone Number",

                              labelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                              ),

                              floatingLabelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                                fontWeight: FontWeight.bold,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.broderColors,
                                  width: 1.5,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.primaryColors,
                                  width: 2,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 15),

                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Delivery Address",
                        labelStyle: TextStyle(
                          color: AllColors.secondaryColors.withValues(alpha:0.8),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: AllColors.secondaryColors.withValues(alpha:0.8),
                          fontWeight: FontWeight.bold,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AllColors.broderColors,
                            width: 1.5,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AllColors.primaryColors,
                            width: 2,
                          ),
                        ),

                        border: OutlineInputBorder( borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),),
                      ),
                    ),

                    SizedBox(height: 15),

                    Row(
                      children: [

                        Expanded(
                          child: DropdownButtonFormField(
                            value: city,
                            decoration: InputDecoration(
                              labelText: "City",
                              labelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                                fontWeight: FontWeight.bold,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.broderColors,
                                  width: 1.5,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.primaryColors,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder( borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),),
                            ),
                            items:  [

                              DropdownMenuItem(value: "Bagerhat", child: Text("Bagerhat")),
                              DropdownMenuItem(value: "Bandarban", child: Text("Bandarban")),
                              DropdownMenuItem(value: "Barguna", child: Text("Barguna")),
                              DropdownMenuItem(value: "Barishal", child: Text("Barishal")),
                              DropdownMenuItem(value: "Bhola", child: Text("Bhola")),
                              DropdownMenuItem(value: "Bogura", child: Text("Bogura")),
                              DropdownMenuItem(value: "Brahmanbaria", child: Text("Brahmanbaria")),
                              DropdownMenuItem(value: "Chandpur", child: Text("Chandpur")),
                              DropdownMenuItem(value: "Chattogram", child: Text("Chattogram")),
                              DropdownMenuItem(value: "Chuadanga", child: Text("Chuadanga")),
                              DropdownMenuItem(value: "Cumilla", child: Text("Cumilla")),
                              DropdownMenuItem(value: "Cox's Bazar", child: Text("Cox's Bazar")),
                              DropdownMenuItem(value: "Dhaka", child: Text("Dhaka")),
                              DropdownMenuItem(value: "Dinajpur", child: Text("Dinajpur")),
                              DropdownMenuItem(value: "Faridpur", child: Text("Faridpur")),
                              DropdownMenuItem(value: "Feni", child: Text("Feni")),
                              DropdownMenuItem(value: "Gaibandha", child: Text("Gaibandha")),
                              DropdownMenuItem(value: "Gazipur", child: Text("Gazipur")),
                              DropdownMenuItem(value: "Gopalganj", child: Text("Gopalganj")),
                              DropdownMenuItem(value: "Habiganj", child: Text("Habiganj")),
                              DropdownMenuItem(value: "Jamalpur", child: Text("Jamalpur")),
                              DropdownMenuItem(value: "Jashore", child: Text("Jashore")),
                              DropdownMenuItem(value: "Jhalokati", child: Text("Jhalokati")),
                              DropdownMenuItem(value: "Jhenaidah", child: Text("Jhenaidah")),
                              DropdownMenuItem(value: "Joypurhat", child: Text("Joypurhat")),
                              DropdownMenuItem(value: "Khagrachhari", child: Text("Khagrachhari")),
                              DropdownMenuItem(value: "Khulna", child: Text("Khulna")),
                              DropdownMenuItem(value: "Kishoreganj", child: Text("Kishoreganj")),
                              DropdownMenuItem(value: "Kurigram", child: Text("Kurigram")),
                              DropdownMenuItem(value: "Kushtia", child: Text("Kushtia")),
                              DropdownMenuItem(value: "Lakshmipur", child: Text("Lakshmipur")),
                              DropdownMenuItem(value: "Lalmonirhat", child: Text("Lalmonirhat")),
                              DropdownMenuItem(value: "Madaripur", child: Text("Madaripur")),
                              DropdownMenuItem(value: "Magura", child: Text("Magura")),
                              DropdownMenuItem(value: "Manikganj", child: Text("Manikganj")),
                              DropdownMenuItem(value: "Meherpur", child: Text("Meherpur")),
                              DropdownMenuItem(value: "Moulvibazar", child: Text("Moulvibazar")),
                              DropdownMenuItem(value: "Munshiganj", child: Text("Munshiganj")),
                              DropdownMenuItem(value: "Mymensingh", child: Text("Mymensingh")),
                              DropdownMenuItem(value: "Naogaon", child: Text("Naogaon")),
                              DropdownMenuItem(value: "Narail", child: Text("Narail")),
                              DropdownMenuItem(value: "Narayanganj", child: Text("Narayanganj")),
                              DropdownMenuItem(value: "Narsingdi", child: Text("Narsingdi")),
                              DropdownMenuItem(value: "Natore", child: Text("Natore")),
                              DropdownMenuItem(value: "Netrokona", child: Text("Netrokona")),
                              DropdownMenuItem(value: "Nilphamari", child: Text("Nilphamari")),
                              DropdownMenuItem(value: "Noakhali", child: Text("Noakhali")),
                              DropdownMenuItem(value: "Pabna", child: Text("Pabna")),
                              DropdownMenuItem(value: "Panchagarh", child: Text("Panchagarh")),
                              DropdownMenuItem(value: "Patuakhali", child: Text("Patuakhali")),
                              DropdownMenuItem(value: "Pirojpur", child: Text("Pirojpur")),
                              DropdownMenuItem(value: "Rajbari", child: Text("Rajbari")),
                              DropdownMenuItem(value: "Rajshahi", child: Text("Rajshahi")),
                              DropdownMenuItem(value: "Rangamati", child: Text("Rangamati")),
                              DropdownMenuItem(value: "Rangpur", child: Text("Rangpur")),
                              DropdownMenuItem(value: "Satkhira", child: Text("Satkhira")),
                              DropdownMenuItem(value: "Shariatpur", child: Text("Shariatpur")),
                              DropdownMenuItem(value: "Sherpur", child: Text("Sherpur")),
                              DropdownMenuItem(value: "Sirajganj", child: Text("Sirajganj")),
                              DropdownMenuItem(value: "Sunamganj", child: Text("Sunamganj")),
                              DropdownMenuItem(value: "Sylhet", child: Text("Sylhet")),
                              DropdownMenuItem(value: "Tangail", child: Text("Tangail")),
                              DropdownMenuItem(value: "Thakurgaon", child: Text("Thakurgaon")),
                            ],
                            onChanged: (value) {
                              setState(() {
                                city = value!;
                                selectedUpazilas = upazilas[city] ?? [];
                                upazila = null;
                              });
                            },
                          ),
                        ), //**********************************************

                         SizedBox(width: 15),

                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: upazila,
                            decoration: InputDecoration(
                              labelText: "Upazila",
                              labelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                                fontWeight: FontWeight.bold,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.primaryColors,
                                  width: 2,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: selectedUpazilas.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                upazila = value;
                              });
                            },
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [

                        Expanded(
                            child: TextFormField(

                              decoration:  InputDecoration(
                                labelText: "Post Office",
                                labelStyle: TextStyle(
                                  color: AllColors.secondaryColors.withValues(alpha:0.8),
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: AllColors.secondaryColors.withValues(alpha:0.8),
                                  fontWeight: FontWeight.bold,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AllColors.broderColors,
                                    width: 1.5,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AllColors.primaryColors,
                                    width: 2,
                                  ),
                                ),
                                border: OutlineInputBorder( borderRadius: BorderRadius.all(
                                  Radius.circular(12),


                                ),

                                ),
                              ),
                            ),
                        ),
                        SizedBox(width:15),
                        Expanded(
                          child: TextFormField(

                            decoration:  InputDecoration(
                              labelText: "Postal Code",
                              labelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: AllColors.secondaryColors.withValues(alpha:0.8),
                                fontWeight: FontWeight.bold,
                              ),

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.broderColors,
                                  width: 1.5,
                                ),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AllColors.primaryColors,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder( borderRadius: BorderRadius.all(
                                Radius.circular(12),


                              ),

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            /// Payment Method
            Card(
              color: AllColors.whiteColors,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding:  EdgeInsets.all(16),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(

                      children: [

                        Expanded(
                          child: paymentCard(
                            title: "bKash / Nagad",
                            icon: Icons.account_balance_wallet,
                            value: "bkash",
                          ),
                        ),

                       SizedBox(width: 10),

                        Expanded(
                          child: paymentCard(
                            title: "Cash On Delivery",
                            icon: Icons.payments,
                            value: "cod",
                          ),
                        ),

                         SizedBox(width: 10),

                        Expanded(
                          child: paymentCard(
                            title: "Card Payment",
                            icon: Icons.credit_card,
                            value: "card",
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AllColors.primaryColors,
                ),
                onPressed: () {},
                child: Text(
                  "Place Order",
                  style: TextStyle(fontSize: 18,color: AllColors.whiteColors),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget paymentCard({
    required String title,
    required IconData icon,
    required String value,
  }) {
    bool selected = paymentMethod == value;

    return InkWell(
      onTap: () {
        setState(() {
          paymentMethod = value;
        });
      },
      child: Container(
        padding:  EdgeInsets.all(12),
        height: 120,
        decoration: BoxDecoration(
          color: selected
              ? AllColors.primaryColors.withOpacity(.08)
              : AllColors.whiteColors,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AllColors.primaryColors
                : Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Align(
              alignment: Alignment.topRight,
              child: Radio(
                value: value,
                groupValue: paymentMethod,
                activeColor: AllColors.primaryColors,
                onChanged: (v) {
                  setState(() {
                    paymentMethod = v!;
                  });
                },
              ),
            ),

            Icon(
              icon,
              color: AllColors.primaryColors,
              size: 32,
            ),

            Text(
              title,
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )

          ],
        ),
      ),
    );
  }
}