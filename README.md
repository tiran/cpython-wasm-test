# CPython WebAssembly tests

Test CPython WebAssembly builds with Emscripten SDK.

## Known issues

- 3.1.14: no main argv with PROXY_TO_PTHREAD [#17338](https://github.com/emscripten-core/emscripten/issues/17338)
- 3.1.16: 64 bit time_t broke utime(), [#17393](https://github.com/emscripten-core/emscripten/issues/17393)
