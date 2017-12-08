function [ noeyes ] = generateNoEyes( eyes )
% Given the coords of 2 eyes, generate the coords of 18 no-eyes
    x1 = eyes(1)-20;
    x2 = eyes(1)+20;
    x3 = eyes(3)-20;
    x4 = eyes(3)+20;
    y1 = eyes(2)-10;
    y2 = eyes(2)+10;
    y3 = eyes(4)-10;
    y4 = eyes(4)+10;
    noeyes = zeros(1,36);
    for i=1:2:36
        condition = false;
        x = 0;
        y = 0;
        while ~condition
            x = round(rand * 400);
            y = round(rand * 400);
             if x>20 && x<380 && y>10 && y<390
                 condition = true;
             end
            if x>x1 && x<x2 && y>y1 && y<y2
                condition = false;
            end
            if x>x3 && x<x4 && y>y3 && y<y4
                condition = false;
            end
        end
        noeyes(i) = x;
        noeyes(i+1) = y;
    end

end

