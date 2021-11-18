clc;
clear all;

acc = 0.00001;
tau = (3 - sqrt(5)) / 2;
ax = 0;
bx = 2;
cx = bx-ax;

fx = bx^4 - 14*bx^3 + 60*bx^2 - 70*bx;
k = 0;

fprintf('k      ax      bx     bx-ax(cx)  fx  \n');
fprintf('%3i  %3.6f %3.6f %3.6f  %3.6f \n',k, ax, bx, cx, fx);

while (bx-ax > acc)
    k = k+1;

    hax = ax + tau*(bx-ax); %h= hat
    hbx = bx - tau*(bx-ax);
    
    fax = ax^4 - 14*ax^3 + 60*ax^2 - 70*ax;
    fbx = bx^4 - 14*bx^3 + 60*bx^2 - 70*bx;
    
    fhax = hax^4 - 14*hax^3 + 60*hax^2 - 70*hax;
    fhbx = hbx^4 - 14*hbx^3 + 60*hbx^2 - 70*hbx;
    
    if ( fhax < fhbx )
        br = 1;
    elseif ( fhax > fhbx )
        br = 2;
    else
        br = 3;
    end
    
    switch br
        case 1
            if ( fax > fhax )
                bx = hbx;
            else
                bx = hax;
            end
        case 2
            if (fbx > fhbx)
                ax = hax;
            else
                ax = hbx;
            end
        case 3
            ax = hax;
            bx = hbx;
    end
    
    ffx = bx^4 - 14*bx^3 + 60*bx^2 - 70*bx;
    cx = bx-ax;
    fprintf('%3i  %3.6f %3.6f %3.6f %3.6f \n', k, ax, bx, cx, ffx);
end
            
        
        
    
