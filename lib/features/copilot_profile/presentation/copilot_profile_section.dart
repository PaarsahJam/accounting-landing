import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../../l10n/app_localizations_en.dart';
import '../../guidance/domain/concept_definitions.dart';
import '../../workflows/domain/workflow_definitions.dart';
import '../copilot_profile_provider.dart';
import '../domain/copilot_profile.dart';

/// Settings section to view and reset the personalized copilot profile.
///
/// Shows the current business type and skill level (editable) plus the
/// completed learning steps and frequently used workflows the copilot has
/// observed. A reset button clears the whole profile back to defaults.
class CopilotProfileSection extends ConsumerWidget {
  const CopilotProfileSection({super.key});

  AppLocalizations _l10n(BuildContext context) =>
      AppLocalizations.of(context) ?? AppLocalizationsEn('en');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = _l10n(context);
    final profile = ref.watch(copilotProfileProvider);
    final notifier = ref.read(copilotProfileProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_pin_circle_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.copilotProfileSectionTitle,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.copilotProfileSectionSubtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.copilotProfileBusinessTypeLabel),
              trailing: DropdownButton<BusinessType>(
                value: profile.businessType,
                underline: const SizedBox(),
                items: [
                  for (final type in BusinessType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Text(_businessLabel(type, l10n)),
                    ),
                ],
                onChanged: (type) {
                  if (type != null) notifier.setBusinessType(type);
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.copilotProfileSkillLevelLabel),
              trailing: DropdownButton<UserSkillLevel>(
                value: profile.skillLevel,
                underline: const SizedBox(),
                items: [
                  for (final level in UserSkillLevel.values)
                    DropdownMenuItem(
                      value: level,
                      child: Text(_skillLabel(level, l10n)),
                    ),
                ],
                onChanged: (level) {
                  if (level != null) notifier.setSkillLevel(level);
                },
              ),
            ),
            const Divider(height: 24),
            Text(
              l10n.copilotProfileLearningStepsLabel,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            _ProfileTags(
              tags: _learningStepLabels(context, profile.completedLearningSteps),
              emptyLabel: l10n.copilotProfileLearningStepsEmpty,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.copilotProfileFrequentWorkflowsLabel,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 4),
            _ProfileTags(
              tags: _workflowLabels(context, profile.frequentlyUsedWorkflows),
              emptyLabel: l10n.copilotProfileFrequentWorkflowsEmpty,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () => _confirmReset(context, notifier),
                icon: const Icon(Icons.restart_alt),
                label: Text(l10n.copilotProfileReset),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmReset(
    BuildContext context,
    CopilotProfileNotifier notifier,
  ) async {
    final l10n = _l10n(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.copilotProfileResetConfirmTitle),
        content: Text(l10n.copilotProfileResetConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.copilotProfileReset),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    await notifier.reset();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.copilotProfileResetDone)),
    );
  }

  String _businessLabel(BusinessType type, AppLocalizations l10n) =>
      switch (type) {
        BusinessType.general => l10n.copilotProfileBusinessGeneral,
        BusinessType.retail => l10n.copilotProfileBusinessRetail,
        BusinessType.wholesale => l10n.copilotProfileBusinessWholesale,
        BusinessType.services => l10n.copilotProfileBusinessServices,
        BusinessType.manufacturing => l10n.copilotProfileBusinessManufacturing,
        BusinessType.restaurant => l10n.copilotProfileBusinessRestaurant,
      };

  String _skillLabel(UserSkillLevel level, AppLocalizations l10n) =>
      switch (level) {
        UserSkillLevel.beginner => l10n.copilotProfileSkillBeginner,
        UserSkillLevel.intermediate => l10n.copilotProfileSkillIntermediate,
        UserSkillLevel.advanced => l10n.copilotProfileSkillAdvanced,
      };

  List<String> _learningStepLabels(
    BuildContext context,
    Set<String> stepIds,
  ) {
    final l10n = _l10n(context);
    final concepts = buildConceptHelp(l10n);
    return stepIds.map((id) {
      final concept = concepts.where((c) => c.id == id).toList();
      return concept.isEmpty ? id : concept.first.title;
    }).toList();
  }

  List<String> _workflowLabels(BuildContext context, Set<String> workflowIds) {
    final l10n = _l10n(context);
    final tasks = buildWorkflowTasks(l10n);
    return workflowIds.map((id) {
      final task = tasks.where((t) => t.id == id).toList();
      return task.isEmpty ? id : task.first.title;
    }).toList();
  }
}

class _ProfileTags extends StatelessWidget {
  const _ProfileTags({required this.tags, required this.emptyLabel});

  final List<String> tags;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return Text(
        emptyLabel,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final tag in tags)
          Chip(
            label: Text(tag),
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}
