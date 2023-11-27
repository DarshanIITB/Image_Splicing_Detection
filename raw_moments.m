function [I] = raw_moments(X,d) 
    [nrows,ncols,K] = size(X);

	wind = 2*d+1;
	I = zeros(nrows+wind,ncols+wind,K');
	I(d+1:nrows+d,d+1:ncols+d,:) = X;

	% creating integral images and getting raw moments
	I = cumsum(cumsum(I,1),2);
	I = I(wind:nrows+wind-1, wind:ncols+wind-1, :)-I(1:nrows, wind:ncols+wind-1, :)-I(wind:nrows+wind-1, 1:ncols, :)+I(1:nrows, 1:ncols, :);
	I = I/(wind*wind);

end