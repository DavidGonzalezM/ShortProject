function DisplayConfusionMatrix(confMat)

confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
labels = ['0','1'];
colHeadings = arrayfun(@(x)sprintf('%d',x),0:1,'UniformOutput',false);
format = repmat('%-9s',1,11);
header = sprintf(format,'0 = Eye 1 = No Eye  |',colHeadings{:});
fprintf('\n%s\n%s\n',header,repmat('-',size(header)));
for idx = 1:2
    fprintf('%-9s',   ['                   ' labels(idx) '|']);
    fprintf('%-9.2f', confMat(idx,:));
    fprintf('\n')
end
