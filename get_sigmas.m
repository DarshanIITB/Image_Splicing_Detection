function sigmas = get_sigmas(im)

    filter_size = 4;
    neighbourhood = 16;
    
    transform = dct_transform(im, filter_size);
    
    %% equation 6 for local noise estimation
    
    % raw moment arrays
    
    u1 = raw_moments(transform,neighbourhood);
    u2 = raw_moments(transform.^2,neighbourhood);
    u3 = raw_moments(transform.^3,neighbourhood);
    u4 = raw_moments(transform.^4,neighbourhood);
    
    % sigma_k and K_k for each pixel per channel
    sigmaksq = u2 - u1.^2;
    k = (u4 - 4*u3.*u1 + 6*u2.*u1.^2 - 3*u1.^4)./(u2.^2 - 2*u2.*u1.^2 + u1.^4)-3; 
    k = max(0,k);  % remove errors causing -ve kks
    
    %% equation 4
    a = mean(sqrt(k),3);
    b = mean(1./sigmaksq,3);
    c = mean(1./sigmaksq.^2,3);
    d = mean(sqrt(k)./sigmaksq,3);
    
    kurt = (a.*c - b.*d)./(c-b.*b);
    sigmas = (1 - a./kurt)./b; 
    
    idx = kurt<a;
    sigmas(idx) = 1./b(idx);
    idx = sigmas<0;
    sigmas(idx) = 1./b(idx);