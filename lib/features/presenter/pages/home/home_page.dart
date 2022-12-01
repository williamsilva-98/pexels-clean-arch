import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:pexels_clean_arch/core/erros/failures.dart';
import 'package:pexels_clean_arch/features/domain/entities/photo_entity.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_binding.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_store.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setUpHomeBinding();
    getIt<HomeStore>().getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Pexels Clean Arch',
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          child: Image.asset('assets/pexels_logo.png'),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SearchBar(),
          Expanded(
            child: ScopedBuilder(
              store: getIt<HomeStore>(),
              onLoading: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              onError: (context, error) {
                if (error is EmptyParamFailure) {
                  return Center(
                    child: Text(
                      'Você precisa digitar alguma coisa na pesquisa!',
                    ),
                  );
                }
                return Center(
                  child: Text('Something went wrong: $error'),
                );
              },
              onState: (context, List<PhotoEntity> state) => ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                padding: const EdgeInsets.all(16),
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final item = state[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: SizedBox(
                      width: double.infinity,
                      height: 275,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: item.photoUrl,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    subtitle: Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.photographer,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.alt,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
