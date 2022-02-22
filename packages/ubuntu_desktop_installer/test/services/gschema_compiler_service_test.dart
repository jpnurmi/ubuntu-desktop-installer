import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ubuntu_desktop_installer/services.dart';

import 'gschema_compiler_service_test.mocks.dart';

@GenerateMocks([ProcessRunner])
void main() {
  test('live-run', () async {
    const testArgs = [
      '--targetdir',
      '/tmp/bar/gschemas',
      '/usr/share/foo/gschemas',
    ];

    final processRunner = MockProcessRunner();
    when(processRunner.run(kGlibCompileSchemas, testArgs))
        .thenAnswer((_) async => ProcessResult(123, 0, 'stdout', 'stderr'));

    final service = GSchemaCompilerService(processRunner: processRunner);

    await service.compile(
      source: '/usr/share/foo/gschemas',
      target: '/tmp/bar/gschemas',
    );
    verify(processRunner.run(kGlibCompileSchemas, testArgs)).called(1);
  });

  test('dry-run', () async {
    const testArgs = [
      '--targetdir',
      '/tmp/bar/gschemas',
      '--dry-run',
      '/usr/share/foo/gschemas',
    ];

    final processRunner = MockProcessRunner();
    when(processRunner.run(kGlibCompileSchemas, testArgs))
        .thenAnswer((_) async => ProcessResult(123, 0, 'stdout', 'stderr'));

    final service = GSchemaCompilerService(
      dryRun: true,
      processRunner: processRunner,
    );

    await service.compile(
      source: '/usr/share/foo/gschemas',
      target: '/tmp/bar/gschemas',
    );
    verify(processRunner.run(kGlibCompileSchemas, testArgs)).called(1);
  });
}
