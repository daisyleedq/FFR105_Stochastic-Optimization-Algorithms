function [isPathDistinct] = IsPathDistinct(paths,path)
    %     tmpPathsStr = [pathsStr[0]]
    %     pathsStr = pathsStr[1:]
    %
    %     while pathsStr:
    %         t = pathsStr[0]
    %         pathsStr = pathsStr[1:]
    %         tt = t + t
    %         isCycling = False
    %         for tp in tmpPathsStr:
    %             if tt.count(tp) != 0 or tt[::-1].count(tp) != 0:
    %                 isCycling = True
    %         if not isCycling:
    %             tmpPathsStr.append(t)
    %
    %     pathsStr = tmpPathsStr
    %
    %     return pathsStr
    
    if nargin == 0
        clc
        clear all
        paths = [1 2 3 4; 1 2 4 3; 1 3 2 4];
        path = [1 4 3 2];
        
        
    end
    
 
    isPathDistinct = true;
    
    n = size(paths,1);
    m = size(paths,2);
    tmp = zeros(m*2);
    
    for i=1:n
        p = paths(i,:);
        tmp = [p p];
        tmpFlip = flip(tmp);
        isCycling = sum(strfind(tmp,path));
        isCyclingFlip = sum(strfind(tmpFlip,path));
        if (isCycling || isCyclingFlip)
            isPathDistinct = false;
            break
        end
    end
    
    
    
    
end