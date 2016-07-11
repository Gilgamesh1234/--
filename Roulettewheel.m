function index = Roulettewheel(potbarr,sel)



if any(isinf(potbarr))==1
    index = datasample(1:length(potbarr),sel,'Replace',false,'Weights',ones(1,length(potbarr)));
else 
k=3;
potmin = min(potbarr);
potmax = max(potbarr);

for i = 1 : length(potbarr)
   A(i) = (potmax-potbarr(i))+(potmax-potmin)/(k-1);
      
end
A = A/sum(A);
    index = datasample(1:length(A),sel,'Replace',false,'Weights',A);
end
end
  
    
    
    
    
    
    
    
    