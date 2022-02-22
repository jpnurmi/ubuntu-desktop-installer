import 'dart:io';

/// Runs a process in a way that it can be mocked for testing.
class ProcessRunner {
  /// Creates a process runner.
  const ProcessRunner();

  /// Runs a process. See [Process.run].
  Future<ProcessResult> run(String executable, List<String> arguments) {
    return Process.run(executable, arguments);
  }
}
