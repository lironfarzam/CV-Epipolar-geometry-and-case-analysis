% CV-Epipolar-geometry-and-case-analysis
%
% Authors:
%
%       Liron Farzam, 315415588.
%       Liron Hatabi, 315711242.
function camera3()
    
    % load the data:
        stam = load('p1p2.mat');
        % p1 is the projection matrix of the first camera.
        p1 = stam.p1;
        % p2 is the projection matrix of the second camera.
        p2 = stam.p2;
        
        disp("Part 1: Epipolar Geometry");
        F = epipolarGeometry(p1,p2);
        
        % pause and wait for the user to press a key.
        pause;
    
        % load the points:
        stam1 = load('data.mat');
        % q1 is the points in the first image. 2x10 matrix.
        q1 = stam1.q1;
        % q2 is the points in the second image. 2x10 matrix.
        q2 = stam1.q2;
        %Xo is the 3D points. 3x10 matrix.
        Xo = stam1.Xo;
        
        disp("Part 2: Epipolar Lines");
        epipolarLines(p1,p2,q1, q2,Xo)
        
        % pause and wait for the user to press a key.
        pause;
        
        disp("Part 3: 8 point algorithm");
        F_2 = eightPointAlgorithm(F , q1, q2);
        
end