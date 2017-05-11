function [C] = try_catch(A,B);
try 
    C = A*B;
catch
    C = A.*B;
end