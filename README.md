# CPython WebAssembly tests

Test CPython WebAssembly builds with Emscripten SDK and WASI SDK. Build
artifacts are available from latest scheduled *Emscripten nightly tests* and
*WASI SDK nightly tests*. The WASM files include debug symbols.

**NOTE** Due to limitation in GitHub's `actions/upload-artifact`, the zip
files don't have a root directory. You can use `unzip -d` to extract the
files into a subdirectory, e.g.
`unzip emscripten-browser-py_3.11-emsdk_latest.zip -d emscripten-browser-py_3.11-emsdk_latest`.


## Emscripten build artifacts

(Emscripten nightly tests)[https://github.com/tiran/cpython-wasm-test/actions/workflows/emsdk.yml]

The `emsdk-tot-upstream` builds are using Emscripte tip-of-tree (nightlies).

### Emscripten browser target

- `emscripten-browser_py3.11_emsdk-latest`: Python 3.11 branch, latest Emscripten SDK
- `emscripten-browser_py3.12-dev_emsdk-latest`: Python main branch (3.12-dev), latest Emscripten SDK

The files must be served from a web server. You can use the
`wasm_webserver.py` script to run a local web server and
access the browser REPL from http://localhost:8000/python.html

### Emscripte NodeJS target

- `emscripten-node-dl_py3.12-dev_emsdk-latest`: WASM dynamic linking, Python
  main branch (3.12-dev), latest Emscripten SDK
- `emscripten-node-dl_py3.11_emsdk-latest`: WASM dynamic linking, Python
  3.11 branch, latest Emscripten SDK
- `emscripten-node-pthreads_py3.12-dev_emsdk-latest`: WASM pthreads emulation,
  Python main branch (3.12-dev), latest Emscripten SDK
- `emscripten-node-pthreads_py3.11_emsdk-latest`: WASM pthreads emulation,
  Python 3.11 branch, latest Emscripten SDK

Run: `node python.js`

You may have to specify `--experimental-wasm-bigint` for older Node versions and
`--experimental-wasm-threads --experimental-wasm-bulk-memory` for pthread builds.


## WASI build artifacts

(WASI nightly tests)[https://github.com/tiran/cpython-wasm-test/actions/workflows/wasi.yml]

- `wasi_py3.11_wasisdk-16`: Python 3.11 with WASI-SDK 16
- `wasi_py3.12-dev_wasisdk-16`: Python main branch (3.12-dev) with WASI-SDK 16

Run: `wasmtime run --dir . -- python.wasm`

Needs a recent version of [wasmtime](https://wasmtime.dev/).


## Known issues

- Emscripten 3.1.14: no main argv with PROXY_TO_PTHREAD [#17338](https://github.com/emscripten-core/emscripten/issues/17338)
- Emscripten 3.1.16: 64 bit time_t broke utime(), [#17393](https://github.com/emscripten-core/emscripten/issues/17393)
