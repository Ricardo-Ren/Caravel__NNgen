# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

# Tensor calculation using NNgen
This project uses NNgen https://github.com/NNgen/nngen to generate a simple tensor calculation. Code is as follows

a = ng.placeholder(ng.int8, shape=(1), name='a')

b = ng.placeholder(ng.int8, shape=(1), name='b')

c = ng.add(a, b, dtype=ng.int8,  name='c')  

rtl = ng.to_verilog([c], 'Basic', silent=False)
