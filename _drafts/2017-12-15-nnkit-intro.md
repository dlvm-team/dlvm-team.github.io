---
layout: post
title:  "NNKit: A Staged, Type-Safe Neural Network DSL"
date:   2017-12-15 20:01:49 -0400
categories: lms tagless-final swift nnkit
---

*work in-progress*

Most modern neural network DSLs are embedded in dynamically-typed scripting
languages, such as Python or Lua.

```python
x = tf.placeholder(tf.float32, shape=[None, 200])
W = tf.Variable(tf.zeros([100, 50]))
b = tf.Variable(tf.zeros([50]))
y = tf.matmul(x, W) + b
```

<pre class="error">
ValueError: Dimensions must be equal, but are
200 and 100 for 'MatMul' (op: 'MatMul') with
input shapes: [?,200], [100,50].
</pre>
