function [ noeyes ] = generateDoubleNoEyes( eyes )
% Given the coords of 2 eyes, generate the coords of 18 no-eyes
    yMin = max(eyes(2), eyes(4));
    noeyes = zeros(1,18);
    for i=1:2:18
        condition = false;
        x = round(rand * 300) + 21;
        while ~condition
            y = round(rand * 400);
            if y > yMin & y < 360
                condition = true;
            end
        end
        noeyes(i) = x;
        noeyes(i+1) = y;
    end

end