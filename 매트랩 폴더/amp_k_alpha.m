function [aout] = amp_k_alpha(alpha,k,ain)
a_in = ain(1,:);
amped = a_in*alpha;
alpha1 = a_in;

id = find (amped < k );
alpha1(id) = amped(id);
id = find(amped > -k);
alpha1(id) = amped(id);

id = find(alpha1 > k);
alpha1(id) = k;

id = find(alpha1 < -k);
alpha1(id)= -k;

aout = alpha1;
