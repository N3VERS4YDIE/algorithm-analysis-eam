# Exercise 2

Determine the "time complexity T(n)"

```plaintext
READ(n)
s = 0
FOR k = 1; k <= n; k = k + 1
    j = n
    WHILE (j > 0)
        s = s + 1
        j = j / 2
    END_WHILE
END_FOR
PRINT(s)
```
