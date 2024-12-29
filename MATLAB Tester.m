% Define the functions to find the root for
func1 = @(x) x .* exp(-x) - 2 * x + 1;
func2 = @(x) x .* cos(x) - 2 * x.^2 + 3 * x - 1;
func3 = @(x) x.^3 - 7 * x.^2 + 14 * x - 6;
func4 = @(x) sqrt(x) - cos(x);
func5 = @(x) 2 * x .* cos(2 * x) - (x + 1).^2;

% Place in array
funcs = {func1, func2, func3, func4, func5};
lowers = [0,1,0,0,-4];
uppers = [3,3,1,1,-2];

% Using same tolerance for all functions
tol = 1e-7;
params.root_tol = tol;
params.func_tol = tol;

% Writing to file for persistence
fileID = fopen('output.txt', 'w');

for i = 1:5
    fprintf(fileID, 'Cur Function %d\n', i)
    func = funcs{i};
    Int.a = lowers(i);
    Int.b = uppers(i);


    [root, info] = modifiedzeroin3036580613(func, Int, params);

    if info.flag == 0
        fprintf(fileID, 'Root found: %.20f\n', root);
        fprintf(fileID, 'Num Function Calls: %d\n', info.runs);
    else
        fprintf(fileID, 'Root finding failed.\n');
    end

    fprintf(fileID, '____\n');


end