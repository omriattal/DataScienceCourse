function alpha = softsvmrbf(lambda, sigma, Xtrain, Ytrain)
    [m,~] = size(Xtrain);
    gram_matrix = calc_gaussian_gram_matrix(sigma,Xtrain);
    
    H = zeros(2*m,2*m);
    H(1:m,1:m) = gram_matrix;
    H = 2*lambda*H;
    
    u = zeros(2*m,1);
    u(m+1:2*m) = 1/m;
    
    YG = Ytrain.*gram_matrix;
    A = zeros(2*m, 2*m);
    A(1:m, m+1:2*m) = eye(m);
    A(m+1:2*m, m+1:2*m) = eye(m);
    A(m+1:2*m, 1:m) = YG;
    A = (-1) * A;
    
    v = zeros(2*m,1);
    v(m+1:2*m) = 1;
    v = (-1) * v;
    
    z = quadprog(H,u,A,v);
    alpha = z(1:m);
end
