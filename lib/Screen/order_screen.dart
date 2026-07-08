import 'package:flutter/material.dart';

class OrderScreens extends StatefulWidget {
  const OrderScreens({super.key});

  @override
  State<OrderScreens> createState() => _OrderScreensState();
}

class _OrderScreensState extends State<OrderScreens> {

  String paymentMethod = "bkash";
  String city = "Dhaka";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),

      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// Shipping Information
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Shipping Information",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Delivery Address",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [

                        Expanded(
                          child: DropdownButtonFormField(
                            value: city,
                            decoration: const InputDecoration(
                              labelText: "City",
                              border: OutlineInputBorder(),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: "Dhaka",
                                child: Text("Dhaka"),
                              ),
                              DropdownMenuItem(
                                value: "Chittagong",
                                child: Text("Chittagong"),
                              ),
                              DropdownMenuItem(
                                value: "Rajshahi",
                                child: Text("Rajshahi"),
                              ),
                            ],
                            onChanged: (value){
                              setState(() {
                                city=value!;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Postal Code",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        )

                      ],
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Payment Method
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(

                      children: [

                        Expanded(
                          child: paymentCard(
                            title: "bKash / Nagad",
                            icon: Icons.account_balance_wallet,
                            value: "bkash",
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: paymentCard(
                            title: "Cash On Delivery",
                            icon: Icons.payments,
                            value: "cod",
                          ),
                        ),

                        const SizedBox(width: 10),

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

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Place Order",
                  style: TextStyle(fontSize: 18),
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
        padding: const EdgeInsets.all(12),
        height: 120,
        decoration: BoxDecoration(
          color: selected
              ? Colors.blue.withOpacity(.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Colors.blue
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
                onChanged: (v){
                  setState(() {
                    paymentMethod=value;
                  });
                },
              ),
            ),

            Icon(
              icon,
              color: Colors.blue,
              size: 32,
            ),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )

          ],
        ),
      ),
    );
  }
}