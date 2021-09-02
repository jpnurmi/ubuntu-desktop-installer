import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// @internal
typedef Setenv = int Function(Pointer<Int8>, Pointer<Int8>, int);

/// @internal
typedef SetenvC = Int32 Function(Pointer<Int8>, Pointer<Int8>, Int8);

/// Sets the value of an environment variable.
bool setenv(String name, String value, {bool overwrite = true}) {
  final stdlib = DynamicLibrary.process();
  final _setenv = stdlib.lookupFunction<SetenvC, Setenv>('setenv');
  final cname = name.toNativeUtf8();
  final cvalue = value.toNativeUtf8();
  final result = _setenv(cname.cast(), cvalue.cast(), overwrite ? 1 : 0);
  malloc.free(cname);
  malloc.free(cvalue);
  return result == 0;
}

/// @internal
typedef Unsetenv = int Function(Pointer<Int8>);

/// @internal
typedef UnsetenvC = Int32 Function(Pointer<Int8>);

/// Resets the value of an environment variable.
bool unsetenv(String name) {
  final stdlib = DynamicLibrary.process();
  final _unsetenv = stdlib.lookupFunction<UnsetenvC, Unsetenv>('unsetenv');
  final cname = name.toNativeUtf8();
  final result = _unsetenv(cname.cast());
  malloc.free(cname);
  return result == 0;
}
