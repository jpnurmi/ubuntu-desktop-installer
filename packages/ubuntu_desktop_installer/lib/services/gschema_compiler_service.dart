import 'package:meta/meta.dart';

import 'process_runner.dart';

const kGlibCompileSchemas = 'glib-compile-schemas';

class GSchemaCompilerService {
  const GSchemaCompilerService({
    this.dryRun = false,
    @visibleForTesting this.processRunner = const ProcessRunner(),
  });

  final bool dryRun;
  final ProcessRunner processRunner;

  Future<void> compile({
    required String source,
    required String target,
  }) {
    return processRunner.run(kGlibCompileSchemas, [
      '--targetdir',
      target,
      if (dryRun) '--dry-run',
      source,
    ]);
  }
}
