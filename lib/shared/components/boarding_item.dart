import 'package:e_commerce/models/on_board_model.dart';
import 'package:flutter/material.dart';

Widget buildBoardingItem(OnBoardModel boardItem) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(boardItem.image),
        ),
        Text(
          boardItem.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          boardItem.desc,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
