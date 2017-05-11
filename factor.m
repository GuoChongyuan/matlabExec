function result = factor(n)
if n <= 1
    result = 1;
else
    result = factor(n - 1) * n;
end
