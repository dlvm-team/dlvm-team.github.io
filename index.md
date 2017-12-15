---
layout: home
title: The DLVM Compiler Infrastructure for Deep Learning Systems
exclude: true
---

# DLVM {#home-title}

## Modern Compiler Infrastructure for Deep Learning Systems {#home-subtitle}

## Introduction

Deep learning software demands reliability and performance.
However, many of the existing deep learning frameworks are software libraries
that act as an unsafe DSL in Python and a computation graph interpreter.

We present DLVM, a design and implementation of a compiler infrastructure
with a linear algebra intermediate representation, algorithmic differentiation
by adjoint code generation, domain-specific optimizations, and a code generator
targeting GPU via LLVM.

Designed as a modern compiler infrastructure inspired by LLVM, DLVM is more modular
and more generic than existing deep learning compiler frameworks, and supports
tensor DSLs with high expressivity. With our prototypical staged DSL embedded in Swift,
we argue that the DLVM system enables a form of modular, safe, and performant frameworks
for deep learning.

---

DLVM started as a research project at University of Illinois at
Urbana-Champaign, and is now driven by a [small community](http://dlvm.org/people)
of researchers and developers.

## Publications

- [**"A modern compiler framework for neural network DSLs"**](http://learningsys.org/nips17/assets/papers/paper_23.pdf)
  - Richard Wei, Lane Schwartz and Vikram Adve
  - [ML Systems Workshop at NIPS 2017](http://learningsys.org/nips17/) - [slides](http://learningsys.org/nips17/assets/slides/dlvm-nips17.pdf)
- [**"A modern compiler infrastructure for deep learning systems with adjoint code generation in a domain-specific IR"**](https://openreview.net/forum?id=SJo1PLzCW)
  - Richard Wei, Lane Schwartz and Vikram Adve
  - [Autodiff Workshop at NIPS 2017](https://autodiff-workshop.github.io/)
- [**"DLVM: A modern compiler infrastructure for deep learning systems"**](https://arxiv.org/abs/1711.03016)
  - Richard Wei, Lane Schwartz and Vikram Adve
  - Pre-print

## Projects

All projects are written in [Swift](https://swift.org/about).

- [**DLVM Core**](https://github.com/dlvm-team/DLVM)†
  - The core compiler infrastructure: IR, analyses, automatic differentiation,
    optimization passes, and back-end code generator

- [**NNKit**](https://github.com/dlvm-team/NNKit)†
  - A "tagless-final" neural network DSL embedded in Swift, representing a form
    of deep learning toolkits focusing on safety and developer experience

- **The Tensor Expression Language (TEL)**
  - A standalone DSL for declaratively building neural network computation
    graphs, with a compiler that emits DLVM IR and generates a Swift interface

†: *open sourcing in progress*
