function t = dct_transform(im,filtersize)
    
    %take the one with most information
    im1=im(:,:,1);
    
    % Smoothen the image
    h = ones(filtersize) / filtersize^2;
    im1 = imfilter(im1, h, 'same');
    
    %Producing the matrices for DCT Transformation
    r=zeros(filtersize,1);
    c=zeros(1,filtersize);
    for a=1:filtersize
        r(a,1)=a-1;
        c(1,a)=a-1;
    end
    d=(pi*(2*r+1).*c)/(2*filtersize);
    d1=sqrt(2/filtersize)*cos(d);
    d1(:,1)=d1(:,1)/sqrt(2);
    m = zeros(filtersize,filtersize,filtersize*filtersize);
    for i=1:filtersize*filtersize
       m(:,:,i)=transpose(d1(:,1+((i-1-rem(i-1,filtersize))/filtersize))).*d1(:,1+rem(i-1,filtersize));
    end
    
    %Find the transformations
    size_=size(im1);
    t=zeros(size_(1),size_(2),filtersize*filtersize-1);
    for i=1:filtersize*filtersize-1
        t(:,:,i)=conv2(im1,m(:,:,i+1),'same');
    end
    % for some reason matlab's dct transform doesn't work
    % t = dct2(im1);
end