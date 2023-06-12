% part 1: epipolar geometry:
% In this part we will evaluate the basic matrix in two ways:
%   - by calculation directly from given projection matrices.
%   - and with the help of matching points.
% In addition, we will calculate the epipoles and show epipolar lines.
% All this for synthetic data.
function F = epipolarGeometry(p1, p2)

    % Calculate the F matrix, the fundamental matrix, by Algebraic development.
    C1 = null(p1);
    C1 = C1(1:4)/C1(4);

    e1 = p2*C1;
    % skew symmetric matrix
    e = [0 -e1(3) e1(2); e1(3) 0 -e1(1); -e1(2) e1(1) 0];

    % fundamental matrix:
    F = e * p2 * pinv(p1);
    % normalize the fundamental matrix that the last element will be 1:
    F = F/F(3,3)

    % print the rank of the fundamental matrix:
    disp("The rank of the fundamental matrix is: " + rank(F));

    % Calculate the epipoles:
    % -> by projection of the second camera center on the first image plane and vice versa.
    % e1 is the epipole of the first image.
    C1 = null(p1);
    C1 = C1(1:4)/C1(4);
    e1_byProjection = p2 * C1;
    e1_byProjection = e1_byProjection(1:2)/e1_byProjection(3)
    % e2 is the epipole of the second image.
    C2 = null(p2);
    C2 = C2(1:4)/C2(4);
    e2_byProjection = p1 * C2;
    e2_byProjection = e2_byProjection(1:2)/e2_byProjection(3)

    % -> by the null space the right and left fundamental matrix.
    e1_byNullSpace = null(F');
    e1_byNullSpace = e1_byNullSpace(1:2)/e1_byNullSpace(3)
    e2_byNullSpace = null(F);
    e2_byNullSpace = e2_byNullSpace(1:2)/e2_byNullSpace(3)
end