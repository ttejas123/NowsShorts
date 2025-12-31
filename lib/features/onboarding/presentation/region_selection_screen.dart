import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../settings/provider.dart';

class Region {
  final String name;
  final String svg;

  Region({required this.name, required this.svg});
}

class RegionSelectionScreen extends ConsumerWidget {
  const RegionSelectionScreen({super.key});

  static List<Region> regions = [
    Region(name: 'Finland', svg: 'assets/finland.svg'),
    Region(name: 'Europe', svg: 'assets/europe.svg'),
    Region(name: 'Africa', svg: 'assets/africa.svg'),
    Region(name: 'India', svg: 'assets/india.svg'),
    Region(name: 'Pakistan', svg: 'assets/pakistan.svg'),
    Region(name: 'Philippines', svg: 'assets/philippines.svg'),
    Region(name: 'South America', svg: 'assets/southAmerica.svg'),
    Region(name: 'North America', svg: 'assets/northAmerica.svg'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsControllerProvider.notifier);
    final state = ref.watch(settingsControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// Back
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
              ),
            ),

            /// Title
            Text(
              'Select Regions',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'In addition to GCC and world news which other regions would you be interested in localized news from?',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: regions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (_, index) {
                  final region = regions[index];
                  final selected = state.selectedRegions.contains(region.name);

                  return GestureDetector(
                    onTap: () => controller.toggleRegion(region.name),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: selected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            region.svg,
                            width: 80,
                            height: 80,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          // Icon(
                          //   Icons.public,
                          //   size: 64,
                          //   color: theme.colorScheme.primary,
                          // ),
                          const SizedBox(height: 12),
                          Text(
                            region.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Next
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                width: 220,
                height: 52,
                child: ElevatedButton(
                  onPressed: state.selectedRegions.isEmpty
                      ? null
                      : () {
                          context.go('/home');
                        },
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
