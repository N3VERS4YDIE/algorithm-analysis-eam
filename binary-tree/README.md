# Binary Tree

## Most important features provided in this project

- Support for binary trees with artihmetic, algebraic, logical and bitwise expressions
- Binary trees traversal in pre-order, in-order, and post-order
- Evaluate and obtain the result of almost any formed expression from a binary tree
- Output binary trees with a hierarchical human-readable format

---

> [!Note]
> The following sections are solved problems about binary trees and their traversals, as well as algebraic expressions converted to binary trees and vice versa.

## Design a binary tree and traverse it

Numerical sequence:
`14, 15, 4, 9, 7, 18, 3, 5, 16, 4, 20, 17`.

Tree:

```julia
                                     14
                    ┌─────────────────┴─────────────────┐
                   15                                    4
          ┌─────────┴────────┐                    ┌──────┴──────┐
         9                   7                   18             3
     ┌────┴───┐          ┌────┴───┐          ┌────┴
    5         16        4         20        17
```

Inorder Traversal:
`5, 9, 16, 15, 4, 7, 20, 14, 17, 18, 4, 3`

Preorder Traversal:
`14, 15, 9, 5, 16, 7, 4, 20, 4, 18, 17, 3`

Postorder Traversal:
`5, 16, 9, 4, 20, 7, 15, 17, 18, 3, 4, 14`

## Same as above but with reversed numerical sequence

Reversed numerical sequence:
`17, 20, 4, 16, 5, 3, 18, 7, 9, 4, 15, 14`

Tree:

```julia
                                     17
                    ┌─────────────────┴─────────────────┐
                   20                                    4
          ┌─────────┴────────┐                    ┌──────┴──────┐
         16                  5                   3              18
     ┌────┴───┐          ┌────┴───┐          ┌────┴
    7         9         4         15        14
```

Inorder Traversal:
`7, 16, 9, 20, 4, 5, 15, 17, 14, 3, 4, 18`

Preorder Traversal:
`17, 20, 16, 7, 9, 5, 4, 15, 4, 3, 14, 18`

Postorder Traversal:
`7, 9, 16, 4, 15, 5, 20, 14, 3, 18, 4, 17`

## Algebraic expressions to binary trees

Expression:

```math
Y * X / (A + B) * C
```

Tree:

```julia
                  /
     ┌────────────┴────────────┐
    *                           *
┌────┴───┐               ┌──────┴──────┐
Y         X              +              C
                    ┌────┴───┐
                   A         B
```

---

Expression:

```math
X * Y / A + B * C
```

Tree:

```julia
                          +
               ┌──────────┴──────────┐
               /                     *
        ┌──────┴──────┐         ┌────┴───┐
        *              A       B         C
   ┌────┴───┐
   X         Y
```

## Binary trees to algebraic expressions (in-order)

Tree:

```julia
                   +
         ┌─────────┴────────┐
        *                   /
    ┌────┴───┐          ┌────┴───┐
   a         b         c         d
```

Expression:

```math
(a * b) + (c / d) = a*b + c/d
```

---

Tree:

```julia
                        +
               ┌────────┴───────┐
               +                d
        ┌──────┴──────┐
       +              c
   ┌────┴───┐
  a         b
```

Expression:

```math
((a + b) + c) + d = a + b + c + d
```

---

Tree:

```julia
                                /
            ┌───────────────────┴──────────────────┐
           +                                       *
  ┌─────────┴────────┐                    ┌─────────┴────────┐
 -                   +                   +                   *
 ┴───┐          ┌────┴───┐               ┴───┐          ┌────┴───┐
      a         x         y                   b         c         d
```

Expression:

```math
( - a) + (x + y) / ( + b) * (c * d) = (-a + x + y) / b * c * d
```
