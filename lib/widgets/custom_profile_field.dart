import 'package:flutter/material.dart';

profileCustomField({context, icon, title, onTap}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(icon),
          ),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium,),
              ],
            ),
          )
        ],
      ),
    ),
  );
}