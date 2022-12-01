import 'package:flutter/material.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_binding.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_store.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            offset: const Offset(1, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        onFieldSubmitted: (value) {
          query = value;
          getIt<HomeStore>().getPhotos(query: value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Pesquise aqui',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              getIt<HomeStore>().getPhotos(query: query);
            },
            icon: const Icon(PhosphorIcons.magnifyingGlass),
          ),
        ),
      ),
    );
  }
}
