# project

Project description.

## API

```cpp
#include "include/lib.hpp"

int main() {
  lib::hello("Dave");
  lib::goodbye("Dave");
}
```

## Build

```console
$ mkdir build
$ cd build
$ cmake -DCOMPILER=clang -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=VCPKG_TOOLCHAIN_FILE ..
$ cmake --build .
```

## References

- [Wikipedia][wikipedia]

## License

[MIT License][license]

[wikipedia]: https://en.wikipedia.org/wiki/Main_Page
[license]: LICENSE
