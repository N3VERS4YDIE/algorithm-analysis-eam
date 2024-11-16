# Binary Tree

## Problem

1. Design:

   - The binary tree for the following numerical sequence: `14, 15, 4, 9, 7, 18, 3, 5, 16, 4, 20, 17`.
   - Pre-order traversal of the resulting tree.
   - In-order traversal of the resulting tree.
   - Post-order traversal of the resulting tree.

1. Do the same for the Reversed numerical sequence: `17, 20, 4, 16, 5, 3, 18, 7, 9, 4, 15, 14`.

## Solution

1. **Binary Tree**

Nodes

```julia
[14, 15, 4, 9, 7, 18, 3, 5, 16, 4, 20, 17]
```

Tree

```julia
         14
       /    \
     15       4
    /  \     /  \
   9    7   18   3
  / \  / \    \
 5  16 4  20   17
```

Preorder traversal

```julia
[14, 15, 9, 5, 16, 7, 4, 20, 4, 18, 17, 3]
```

Inorder traversal

```julia
[5, 9, 16, 15, 4, 7, 20, 14, 17, 18, 4, 3]
```

Postorder traversal

```julia
[5, 16, 9, 4, 20, 7, 15, 17, 18, 3, 4, 14]
```

1. **Inverted Binary Tree**

Nodes

```julia
[17, 20, 4, 16, 5, 3, 18, 7, 9, 4, 15, 14]
```

Tree

```julia
         17
       /    \
     20       4
    /  \     /  \
  16    5   3    18
 /  \  / \    \
7    9 4  15   14
```

Preorder traversal

```julia
[17, 20, 16, 7, 9, 5, 4, 15, 4, 3, 14, 18]
```

Inorder traversal

```julia
[7, 16, 9, 20, 4, 5, 15, 17, 14, 3, 4, 18]
```

Postorder traversal

```julia
[7, 9, 16, 4, 15, 5, 20, 14, 3, 18, 4, 17]
```
