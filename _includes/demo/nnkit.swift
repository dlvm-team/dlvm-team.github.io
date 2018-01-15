// Staged function representing f(x, w, b) = dot(x, w) + b
let f: Rep<(Float2D, Float2D, Float1D) -> Float2D> =
    lambda { x, w, b in x • w + b.rankLifted() }

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
