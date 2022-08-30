# CPython WebAssembly nightly tests & unofficial builds

Test CPython WebAssembly builds with Emscripten SDK and WASI SDK. Build
artifacts are available from latest scheduled *Emscripten nightly tests* and
*WASI SDK nightly tests*.

The project also provides [unofficial builds](https://github.com/tiran/cpython-wasm-test/releases)
of CPython for Emscripten and WASI.

See [availability notes](https://docs.python.org/3.11/library/intro.html) and
[WASM README.md](https://github.com/python/cpython/blob/main/Tools/wasm/README.md)
for platform limitations.

## Emscripten build artifacts

[Emscripten nightly tests](https://github.com/tiran/cpython-wasm-test/actions/workflows/emsdk.yml?query=event%3Aschedule)

The `emsdk-tot-upstream` builds are using Emscripte tip-of-tree (nightlies).

### Emscripten browser target

- `Python-3.11dev-wasm32-emscripten-3.1.19-browser`: Python 3.11 branch, Emscripten SDK 3.1.19
- `Python-3.11dev-wasm32-emscripten-3.1.19-browser-debug`: Python 3.11 branch,
  Emscripten SDK 3.1.19, debug build with additional symbols and fewer
  optimizations
- `Python-3.11dev-wasm32-emscripten-3.1.19-browser`: Python main branch (3.12), Emscripten SDK 3.1.19

The files must be served from a web server. You can use the
`./wasm_webserver.py` script to run a local web server and
access the browser REPL from http://localhost:8000/python.html

### Emscripte NodeJS target

- `Python-3.11dev-wasm32-emscripten-3.1.19-node-dl`: WASM dynamic linking, Python
  3.11 branch, Emscripten SDK 3.1.19
- `Python-3.11dev-wasm32-emscripten-3.1.19-node-dl-debug`: WASM dynamic linking, Python
  3.11 branch, Emscripten SDK 3.1.19, debug build with additional debug symbols and fewer
  optimizations
- `Python-3.12dev-wasm32-emscripten-3.1.19-node-dl`: WASM dynamic linking, Python
  main branch (3.12), Emscripten SDK 3.1.19
- `Python-3.11dev-wasm32-emscripten-3.1.19-node-pthreads`: WASM pthreads emulation,
  Python 3.11 branch, Emscripten SDK 3.1.19
- `Python-3.12dev-wasm32-emscripten-3.1.19-node-pthreads`: WASM pthreads emulation,
  Python main branch (3.12), Emscripten SDK 3.1.19
- `Python-3.12dev-wasm64-emscripten-tot-upstream-node`: wasm64-emscripten (MEMORY64),
  Python main branch (3.12), Emscripten SDK tip-of-tree.

Run:

```shell
node python.js
```

You may have to specify `--experimental-wasm-bigint` for older Node versions and
`--experimental-wasm-threads --experimental-wasm-bulk-memory` for pthread builds.

**NOTE** `wasm64-emscripten` is experimental and requires Node >= 16 and
`--wasm-experimental-memory64` options.

## WASI build artifacts

[WASI nightly tests](https://github.com/tiran/cpython-wasm-test/actions/workflows/wasi.yml?query=event%3Aschedule)

- `Python-3.11dev-wasm32-wasi-16`: Python 3.11 with WASI-SDK 16
- `Python-3.12dev-wasm32-wasi-16`: Python main branch (3.12-dev) with WASI-SDK 16

Run:

```shell
wasmtime run --dir . -- python.wasm
```

Needs a recent version of [wasmtime](https://wasmtime.dev/).


## Known issues

- Emscripten 3.1.14: no main argv with PROXY_TO_PTHREAD [#17338](https://github.com/emscripten-core/emscripten/issues/17338)
- Emscripten 3.1.16: 64 bit time_t broke utime(), [#17393](https://github.com/emscripten-core/emscripten/issues/17393)
- Emscripten 3.1.20: argv handling broken [#17720](https://github.com/emscripten-core/emscripten/issues/17720)
