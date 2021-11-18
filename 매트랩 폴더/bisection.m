clc;
clear all;

acc = 0.00001;
ax = 0;
bx = 2;
cx = (bx+ax)/2;
dx = bx-ax;

dfcx = 4*cx^3 - 42*cx^2 + 120*cx - 70;
k = 0;

fprintf('k      ax      bx     cx      dfcx     dx \n');
fprintf('%3i  %3.6f %3.6f %3.6f  %3.6f \n',k, ax, bx, cx, dfcx, dx);

while (dx > acc)
    k = k+1;

    if ( dfcx < 0 )
        br = 1;
    elseif ( dfcx > 0 )
        br = 2;
    else
        br = 3;
    end
    
    switch br
        case 1
           ax = cx;
        case 2
          bx = cx;
        case 3
           return;
    end
    
    
    cx = (bx+ax)/2;
    dx = bx-ax;
    dfcx = 4*cx^3 - 42*cx^2 + 120*cx - 70;
   fprintf('%3i  %3.6f %3.6f %3.6f %3.6f %3.6 \n ', k, ax, bx, cx, dfcx ,dx);
end
            