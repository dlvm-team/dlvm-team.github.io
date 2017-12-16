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

## Demos

NNKit is a staged DSL embedded in Swift. It:
 - features a natural expression for tensor computations
 - is type-safe, leveraging Swift's static type system
 - uses lightweight modular staging to perform JIT compilation to DLVM IR

```swift
// Staged function representing f(x, w, b) = dot(x, w) + b
let f: Rep<(Float2D, Float2D, Float1D) -> Float2D> =
    lambda { x, w, b in x • w + b }

// Staged function ’g’, type-inferred from ’f’
let g = lambda { x, w, b in
    let linear = f[x, w, b] // staged function application
    return tanh(linear)
}

// Gradient of ’g’ with respect to arguments ’w’ and ’b’
let dg = gradient(of: g, withRespectTo: (1, 2), keeping: 0)
// ’dg’ has type:
// Rep<(Float2D, Float2D, Float1D) -> (Float2D, Float2D, Float2D)>

// Call staged function on input data ’x’, ’w’ and ’b’
let (dg_dw, dg_db, result) = dg[x, w, b]
// At runtime, ’dg’ gets just-in-time compiled though DLVM,
// and computes ( dg/dw, dg/db, g(x, w, b) )
```

The DLVM Intermediate Representation (IR) is the core language of the DLVM system. It:
 - uses static single assignment (SSA) form
 - has high-level types, including a first-class tensor type
 - features linear algebra operators, along with a general-purpose instruction set
 - supports many domain-specific transformations (e.g. reverse-mode AD, algebra simplification)

The Swift code above is JIT compiled by NNKit to the following DLVM IR:

```dlvm
// Shape specialized for x: <1 x 784>, w: <784 x 10>, b: <1 x 10>

// f(x, w, b) = dot(x, w) + b
func @f: (<1 x 784 x f32>, <784 x 10 x f32>, <1 x 10 x f32>) -> <1 x 10 x f32> {
'entry(%x: <1 x 784 x f32>, %w: <784 x 10 x f32>, %b: <1 x 10 x f32>):
    %0.0 = dot %x: <1 x 784 x f32>, %w: <784 x 10 x f32>
    %0.1 = add %0.0: <1 x 10 x f32>, %b: <1 x 10 x f32>
    return %0.1: <1 x 10 x f32>
}

// Gradient declaration: [gradient @f wrt 1, 2 seedable]
// Seedable: able to take back-propagated gradient as a seed for AD
// df(x, w, b, seed) = ( df/dw, df/db )
func @df: (<1 x 784 x f32>, <784 x 10 x f32>, <1 x 10 x f32>, <1 x 10 x f32>)
         -> (<784 x 10 x f32>, <1 x 10 x f32>) {
'entry(%x: <1 x 784 x f32>, %w: <784 x 10 x f32>, %b: <1 x 10 x f32>, %seed: <1 x 10 x f32>):
    // Backward pass: df/dw = dot(x^T, seed), df/db = seed
    %0.0 = transpose %x: <1 x 784 x f32>
    %0.1 = dot %0.0: <784 x 1 x f32>, %seed: <1 x 10 x f32>
    %0.2 = literal (%0.1: <784 x 10 x f32>, %seed: <1 x 10 x f32>):
                   (<784 x 10 x f32>, <1 x 10 x f32>)
    return %0.2: (<784 x 10 x f32>, <1 x 10 x f32>)
}

... // @g and @dg omitted here for brevity
```

<!-- Dimension-erased version, in-progress -->
<!--
```dlvm
// f(x, w, b) = dot(x, w) + b
func @f: (<_ x _ x f32>, <_ x _ x f32>, <_ x f32>) -> <_ x _ x f32> {
'entry(%x: <_ x _ x f32>, %w: <_ x _ x f32>, %b: <_ x f32>):
    %0.0 = dot %x: <_ x _ x f32>, %w: <_ x _ x f32>
    %0.1 = rankLift %b: <_ x f32>
    %0.2 = add %0.0: <_ x _ x f32>, %0.1: <1 x _ x f32>
    return %0.1: <_ x _ x f32>
}

// Gradient declaration in DLVM IR: [gradient @f wrt 1, 2 seedable]
// Seedable: able to take back-propagated gradient as a seed for AD
// df(x, w, b, seed) = ( df/dw, df/db )
func @df: (<_ x _ x f32>, <_ x _ x f32>, <_ x f32>, <_ x _ x f32>)
         -> (<_ x _ x f32>, <1 x _ x f32>) {
'entry(%x: <_ x _ x f32>, %w: <_ x _ x f32>, %b: <_ x f32>, %seed: <1 x _ x f32>):
    // Backward pass
    // df/dw = dot(x^T, seed)
    %0.0 = transpose %x: <_ x _ x f32>
    %0.1 = dot %0.1: <_ x _ x f32>, %seed: <_ x _ x f32>
    // df/db = rankLift(sum(seed, axis=0))
    %0.2 = reduce %seed: <_ x _ x f32> by add along 0
    %0.3 = rankLift %0.2: <_ x f32>
    // Return ( df/dw, df/db )
    %0.4 = literal (%0.1: <_ x _ x f32>, %0.3: <1 x _ x f32>)
                   (<_ x _ x f32>, <1 x _ x f32>)
    return %0.4: (<_ x _ x f32>, <1 x _ x f32>)
}

... // @g and @dg omitted here for brevity
```
-->

More information about NNKit and DLVM IR will be published soon.

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

<sup>†: *open sourcing in progress*</sup>
