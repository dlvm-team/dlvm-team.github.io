---
layout: default
title: DLVM
exclude: true
---

# Introduction

Deep learning software demands reliability and performance.
However, many of the existing deep learning frameworks are software libraries
that act as an unsafe DSL in Python and a computation graph interpreter.

We present DLVM, a design and implementation of a compiler infrastructure
with a linear algebra intermediate representation, algorithmic differentiation
by adjoint code generation, domain-specific optimizations, and a code generator
targeting GPU via LLVM.

Designed as a modern compiler IR inspired by LLVM and SIL, DLVM IR is more modular
and more generic than existing deep learning compiler IRs, and supports deep learning
DSLs with high expressivity.
With our prototypical deep learning DSLs embedded in Swift, we argue that the DLVM
system enables a form of modular, safe and performant toolkits for deep learning.

---

DLVM started as a research project at University of Illinois at
Urbana-Champaign, and is now driven by a
[small community](http://dlvm.org/people) of researchers and developers. Most
projects will be open-source later this year.

# Publications

- "A modern compiler framework for neural network DSLs"
  - Richard Wei, Vikram Adve, and Lane Schwartz
  - Accepted to [ML Systems Workshop at NIPS 2017](http://learningsys.org/nips17/)
- "A modern compiler infrastructure for deep learning systems with adjoint code generation in a domain-specific IR"
  - Richard Wei, Vikram Adve, and Lane Schwartz
  - Accepted to [Autodiff Workshop at NIPS 2017](https://autodiff-workshop.github.io/)
- ["DLVM: A modern compiler infrastructure for deep learning systems"](https://arxiv.org/pdf/1711.03016)
  - Richard Wei, Vikram Adve, and Lane Schwartz
  - Pre-print

# Projects

All projects are written in [Swift](https://swift.org/about).

- [CoreTensor](https://github.com/dlvm-team/CoreTensor)
  - A tensor library providing shaping, storage, indexing, slicing, linear algebra
    shape transformation, broadcasting, and collection behavior

- [DLVM Core](https://github.com/dlvm-team/DLVM)
  - The core compiler infrastructure: IR, analyses, automatic differentiator,
    optimization passes, and back-end code generator
  - *Open-sourcing in progress*

- [NNKit](https://github.com/dlvm-team/NNKit)
  - A "tagless-final" neural network DSL embedded in Swift, representing a form
    of deep learning toolkits with a focus on safety and developer experience
  - *Open-sourcing in progress*

- The Tensor Expression Language (TEL)
  - A standalone DSL for declaratively building neural network computation
    graphs, with a compiler that emits DLVM IR and generates a Swift interface

