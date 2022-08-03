# CPython WebAssembly tests

Test CPython WebAssembly builds with Emscripten SDK and WASI SDK. Build
artifacts are available from latest scheduled *Emscripten nightly tests* and
*WASI SDK nightly tests*. The WASM files include debug symbols.


## Emscripten build artifacts

[Emscripten nightly tests](https://github.com/tiran/cpython-wasm-test/actions/workflows/emsdk.yml?query=event%3Aschedule)

The `emsdk-tot-upstream` builds are using Emscripte tip-of-tree (nightlies).

### Emscripten browser target

- `Python-3.11dev-wasm32-emscripten-3.1.18-browser`: Python 3.11 branch, Emscripten SDK 3.1.18
- `Python-3.11dev-wasm32-emscripten-3.1.18-browser`: Python main branch (3.12), Emscripten SDK 3.1.18

The files must be served from a web server. You can use the
`./wasm_webserver.py` script to run a local web server and
access the browser REPL from http://localhost:8000/python.html

### Emscripte NodeJS target

- `Python-3.11dev-wasm32-emscripten-3.1.18-node-dl`: WASM dynamic linking, Python
  3.11 branch, Emscripten SDK 3.1.18
- `Python-3.12dev-wasm32-emscripten-3.1.18-node-dl`: WASM dynamic linking, Python
  main branch (3.12), Emscripten SDK 3.1.18
- `Python-3.11dev-wasm32-emscripten-3.1.18-node-pthreads`: WASM pthreads emulation,
  Python 3.11 branch, Emscripten SDK 3.1.18
- `Python-3.12dev-wasm32-emscripten-3.1.18-node-pthreads`: WASM pthreads emulation,
  Python main branch (3.12), Emscripten SDK 3.1.18

Run:

```shell
node python.js
```

You may have to specify `--experimental-wasm-bigint` for older Node versions and
`--experimental-wasm-threads --experimental-wasm-bulk-memory` for pthread builds.


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
