function F_2 = eightPointAlgorithm(F,q1, q2)
    % Computes the fundamental matrix F from two sets of corresponding points q1 and q2.
    % The fundamental matrix F satisfies the epipolar constraint q2'*F*q1 = 0.
    % The fundamental matrix F is defined up to a scale.
    % The fundamental matrix F is a 3x3 matrix of rank 2.
    % The fundamental matrix F is computed using the 8-point algorithm.
    % The fundamental matrix F is computed using the normalized 8-point algorithm.
    % The fundamental matrix F is computed using the normalized 8-point algorithm and the SVD.
    %
    % input:
    % q1 2 x n matrix of non-homogeneous 2D coordinates in image 1
    % q2 2 x n matrix of non-homogeneous 2D coordinates in image 2
    % output:
    % F_2 3x3 fundamental matrix
    % e1 2x1 epipole in image 1
    % e2 2x1 epipole in image 2
    %

    % check the number of points
    if size(q1,2) < 8
        error('At least 8 points are required to compute the fundamental matrix');
    end

    % check the number of points
    if size(q1,2) ~= size(q2,2)
        error('The number of points in the two images is not the same');
    end

    % check the dimensionality of the points
    if size(q1,1) ~= 2 || size(q2,1) ~= 2
        error('The points are not 2D');
    end

    % normalize the points
    T1 = Get2DNormalizationTransform(q1);
    T2 = Get2DNormalizationTransform(q2);
    q1 = T1 * [q1 ; ones(1,size(q1,2))];
    q2 = T2 * [q2 ; ones(1,size(q2,2))];
    
%     % SWAP - not sure why
%     aa = q1
%     q1 = q2
%     q2 = aa
    
    
    % construct the matrix A
    A = zeros(size(q1,2),9);
    for i = 1:size(q1,2)
        %               (x'x            x'y         x'          y'x             y'y         y'      x       y     1)f = 0
%       A(i,:) = [q1(1,i)*q2(1,i) q1(1,i)*q2(2,i) q1(1,i) q1(2,i)*q2(1,i) q1(2,i)*q2(2,i) q1(2,i) q2(1,i) q2(2,i) 1];
        A(i,:) = [q2(1,i)*q1(1,i) q2(1,i)*q1(2,i) q2(1,i) q2(2,i)*q1(1,i) q2(2,i)*q1(2,i) q2(2,i) q1(1,i) q1(2,i) 1];
    end

    % compute the SVD of A
    [~,~,R] = svd(A);
    X = R(:,end);
    f = reshape(X,3,3)';

    % compute the SVD of f
    [Q,D,R] = svd(f);
    D(3,3) = 0;
    F_2 = Q*D*R';
    
    % Denormalize the fundamental matrix
    F_2 = T2' * F_2 * T1;
    % normalize the fundamental matrix that the last element is 1
    F_2 = F_2/F_2(3,3)
    F
    
end

    
