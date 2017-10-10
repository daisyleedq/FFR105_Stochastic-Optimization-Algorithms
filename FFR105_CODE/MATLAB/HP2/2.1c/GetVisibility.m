function visibility = GetVisibility(cityLocation)
    
    if nargin == 0
        cityLocation = [0 0; 1 0.5; 2 3; 10 1; 3 7; 2 5];
    end
    
    nCity=length(cityLocation);
    visibility=zeros(nCity,nCity);
    for i=1:nCity
        for j=i+1:nCity
            cityI=cityLocation(i,:);
            cityJ=cityLocation(j,:);
            dij=CartesianDistance(cityI,cityJ);
            visibilityTmp = 1/dij;
            visibility(i,j) = visibilityTmp;
            visibility(j,i) = visibilityTmp;
        end
    end
    
end