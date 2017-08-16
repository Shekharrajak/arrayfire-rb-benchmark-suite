# arrayfire-rb-benchmark-suite

Benchmark arrayfire on local machine.

The current benchmarks correspond to:
* CUDA backend
* Double floating point numbers

# Install repos
```bash
git submodule init
git submodule update
```

# Invoke rvm
```bash
source ~/.rvm/scripts/rvm
```

# Build libraries and benchmark.

```bash
rvm use ruby
cd ext/nmatrix/
rake compile
rake compile plugins=nmatrix-lapacke
cd ../../ # root directory
ruby bin/nmatrix-ruby.rb > public/nmatrix-ruby.json
ruby bin/nmatrix-lapacke.rb > public/nmatrix-lapacke.json

cd ext/arrayfire-rb
rake compile
cd ../../ # root directory
ruby bin/arrayfire.rb > public/arrayfire.json
ruby bin/arrayfire-lapacke.rb > public/arrayfire-lapacke.json

rvm use jruby
cd ext/nmatrix
wget https://www.apache.org/dist/commons/math/binaries/commons-math3-3.6.1-bin.tar.gz
tar zxvf commons-math3-3.6.1-bin.tar.gz
mkdir ext/nmatrix_java/vendor/
cp commons-math3-3.6.1/commons-math3-3.6.1.jar ext/nmatrix_java/vendor/

mkdir -p ext/nmatrix_java/build/class
mkdir ext/nmatrix_java/target

rake jruby

cd ../../
ruby bin/nmatrix-jruby.rb > public/nmatrix-jruby.json
```

# Run server

```bash
rvm use ruby
ruby bin/server.rb
```
Goto http://localhost:4567/

# LICENSE

This software is distributed under the [BSD 3-Clause License](LICENSE).

Copyright © 2017, Prasun Anand
