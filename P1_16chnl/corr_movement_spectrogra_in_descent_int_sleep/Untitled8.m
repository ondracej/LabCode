
clc
x=[1 0 2];
for k=x
    try
        x(k)
    catch
        disp(num2str((k)))
    end
end