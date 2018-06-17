function mtre = TRE(S,M)
tre = sqrt(sum((M - S).*(M - S),2));
mtre=mean(tre);