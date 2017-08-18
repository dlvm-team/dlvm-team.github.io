---
layout: default
title: DLVM
exclude: true
---

# Introduction

The umbrella project **DLVM** introduces an end-to-end system from safe neural
network DSLs to heterogeneous parallel code generation, demonstrating a new
infrastructure for modern deep learning software.

DLVM Core is a design and implementation of a compiler infrastructure that
consists of linear algebra operators, automatic differentiation, domain-specific
optimizations and a code generator targeting heterogeneous parallel hardware.
DLVM is designed to support the development of neural network DSLs, with both
AOT and JIT compilation.

**DLVM** started as a research project at University of Illinois at
Urbana-Champaign, and is now driven by a small community of researchers and
developers. Most projects will be open-source later this year.

# Projects

All projects are written in [Swift](https://swift.org/about).

- [CoreTensor](https://github.com/dlvm-team/CoreTensor):
  - A library for tensor shaping, storage, indexing, slicing, linear algebra
    shape transformation and collection behavior
  - *Open-sourcing in progress*

- [DLVM Core](https://github.com/dlvm-team/DLVM)
  - The core compiler infrastructure: IR, analyses, automatic differentiator,
    optimization passes & back-end code generator
  - *Open-sourcing in progress*

- [NNKit](https://github.com/dlvm-team/NNKit):
  - A "tagless-final" neural network DSL embedded in Swift, representing a form of deep learning toolkits with a focus on safety and developer experience

- The Tensor Expression Language (TEL):
  - A standalone DSL for declaratively building neural network computation
    graphs, with a compiler that emits DLVM IR and generates a Swift interface

