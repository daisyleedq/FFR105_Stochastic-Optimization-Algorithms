function [pheromoneLevels] = InitializePheromoneLevels(nCity,tau0)
    
    if nargin == 0
       nCity = 3;
       tau0 = 0.5;
    end
    
    
  pheromoneLevels=zeros(nCity,nCity) + tau0;

end