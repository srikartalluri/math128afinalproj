function [root,info] = modifiedzeroin3036580613(func,Int,params)
    a = Int.a;
    b = Int.b;
    
    root_tol = params.root_tol;
    func_tol = params.func_tol;

    info.flag = 1;
    info.runs = 0;
    if a > b
        root = (a + b) / 2;
        return
    end

    if func(a) * func(b) >= 0
        % error('doesnt have opposite signs');
        root = (a + b) / 2;
        return
    end
    
    x0 = a;
    x1 = b;
    x2 = (a + b) / 2;
    f0 = func(x0);
    f1 = func(x1);
    f2 = func(x2);
    info.runs = 3;
    fa = f0;

    max_iter = 100;

    for iter = 1:max_iter
        x3 = (f1 * f2) / ((f0 - f1) * (f0 - f2)) * x0 + ...
             (f0 * f2) / ((f1 - f0) * (f1 - f2)) * x1 + ...
             (f0 * f1) / ((f2 - f0) * (f2 - f1)) * x2;
        if ~(a <= x3 && x3 <= b)
            x3 = (a + b) / 2;
        end

        f3 = func(x3);
        info.runs = info.runs + 1;

        if abs(b - a) <= root_tol || abs(f3) <= func_tol
            root = x3;
            info.flag = 0;
            return;
        end
        
        if fa * f3 < 0
            b = x3;
        else
            a = x3;
            fa = f3;
        end

        x0 = x1;
        x1 = x2;
        x2 = x3;
        f0 = f1;
        f1 = f2;
        f2 = f3;

    end

    root = NaN;
    return;

end