import 'package:flutter/material.dart';
import 'package:qintrix/features/about/widgets/about_content_cards.dart';
import 'package:qintrix/features/about/widgets/about_hero_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 1040;

        return ListView(
          children: [
            AboutHeroCard(isCompact: isCompact),
            const SizedBox(height: 20),
            if (isCompact) ...[
              const AboutStoryCard(),
              const SizedBox(height: 20),
              const AboutWorkflowCard(),
            ] else
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: AboutStoryCard()),
                  SizedBox(width: 20),
                  Expanded(flex: 5, child: AboutWorkflowCard()),
                ],
              ),
            const SizedBox(height: 20),
            AboutModulesCard(isCompact: isCompact),
            const SizedBox(height: 20),
            if (isCompact) ...[
              const AboutHighlightsCard(),
              const SizedBox(height: 20),
              const AboutVersionCard(),
            ] else
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 7, child: AboutHighlightsCard()),
                  SizedBox(width: 20),
                  Expanded(flex: 4, child: AboutVersionCard()),
                ],
              ),
          ],
        );
      },
    );
  }
}
