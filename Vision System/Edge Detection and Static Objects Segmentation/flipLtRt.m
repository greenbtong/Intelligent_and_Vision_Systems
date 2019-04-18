function newIm = flipLtRt(im)
% newIm is impage im flipped from left to right

[nr,nc,np]= size(im);    % dimensions of im
newIm= zeros(nr,nc,np);  % initialize newIm with zeros
newIm= uint8(newIm);     % Matlab uses unsigned 8-bit int for color values


for r= 1:nr
    for c= 1:nc
        for p= 1:np
            newIm(r,c,p)= im(r,nc-c+1,p);
        end
    end
end

