import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../shared/widgets/app_loading_state.dart';
import '../../../shared/widgets/app_error_state.dart';
import '../domain/crm_task.dart';
import '../domain/crm_tasks_controller.dart';

class CrmTasksPage extends ConsumerWidget {
  const CrmTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tasksAsync = ref.watch(crmTasksControllerProvider());

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tasks)),
      body: tasksAsync.when(
        loading: () => const AppLoadingState(),
        error: (e, _) => AppErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(crmTasksControllerProvider()),
        ),
        data: (tasks) => _TasksListView(tasks: tasks),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateTaskDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final dueDateController = TextEditingController();
    TaskPriority priority = TaskPriority.medium;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(l10n.newTask),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: l10n.title),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  decoration:
                      InputDecoration(labelText: l10n.description),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dueDateController,
                  decoration:
                      InputDecoration(labelText: l10n.dueDate),
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: ctx,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      dueDateController.text =
                          DateFormat('yyyy-MM-dd').format(date);
                    }
                  },
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<TaskPriority>(
                  initialValue: priority,
                  decoration:
                      InputDecoration(labelText: l10n.priority),
                  items: TaskPriority.values
                      .map((p) => DropdownMenuItem(
                            value: p,
                            child: Text(p.name),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => priority = v);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                final task = CrmTask(
                  id: 'TSK-${DateTime.now().millisecondsSinceEpoch}',
                  customerId: 'CUST-1001',
                  title: titleController.text,
                  description: descriptionController.text,
                  status: TaskStatus.notStarted,
                  priority: priority,
                  dueDate: DateFormat('yyyy-MM-dd')
                      .parse(dueDateController.text),
                  assignedTo: 'current_user',
                  createdAt: DateTime.now(),
                );
                ref
                    .read(crmTasksControllerProvider().notifier)
                    .createTask(task);
                Navigator.of(ctx).pop();
              },
              child: Text(l10n.create),
            ),
          ],
        ),
      ),
    );
  }
}

class _TasksListView extends StatelessWidget {
  final List<CrmTask> tasks;

  const _TasksListView({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (tasks.isEmpty) {
      return Center(child: Text(l10n.noTasks));
    }
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) => _TaskCard(task: tasks[index]),
    );
  }
}

class _TaskCard extends ConsumerWidget {
  final CrmTask task;

  const _TaskCard({required this.task});

  Color _statusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.notStarted:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
      case TaskStatus.cancelled:
        return Colors.red;
    }
  }

  Color _priorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.grey;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.deepOrange;
      case TaskPriority.urgent:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final isOverdue = task.status != TaskStatus.completed &&
        task.status != TaskStatus.cancelled &&
        task.dueDate.isBefore(DateTime.now());
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildChip(task.status.name, _statusColor(task.status)),
                const SizedBox(width: 8),
                _buildChip(task.priority.name, _priorityColor(task.priority)),
                const SizedBox(width: 8),
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: isOverdue ? Colors.red : Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  dateFormat.format(task.dueDate),
                  style: TextStyle(
                    fontSize: 12,
                    color: isOverdue ? Colors.red : null,
                    fontWeight: isOverdue ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'complete') {
              await ref
                  .read(crmTasksControllerProvider().notifier)
                  .updateTask(task.copyWith(
                status: TaskStatus.completed,
                completedAt: DateTime.now(),
              ));
            } else if (value == 'delete') {
              await ref
                  .read(crmTasksControllerProvider().notifier)
                  .deleteTask(task.id);
            }
          },
          itemBuilder: (context) => [
            if (task.status != TaskStatus.completed)
              const PopupMenuItem(
                value: 'complete',
                child: Text('Mark Complete'),
              ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
        onTap: () => _showTaskDetail(context, task),
      ),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha((0.2 * 255).round()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color),
      ),
    );
  }

  void _showTaskDetail(BuildContext context, CrmTask task) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(task.description),
            const SizedBox(height: 16),
            Text('Status: ${task.status.name}'),
            Text('Priority: ${task.priority.name}'),
            Text('Due: ${DateFormat('yyyy-MM-dd').format(task.dueDate)}'),
            Text('Assigned to: ${task.assignedTo}'),
          ],
        ),
      ),
    );
  }
}
