function epipolarLines(p1, p2, q1, q2, Xo)
    % q1 is the points in the first image. 2x10 matrix.
    % q2 is the points in the second image. 2x10 matrix.
    % p1 and p2 are the projection matrices for camera 1 and camera 2, respectively.
    % Xo is the 3D points 3x10 matrix.

    % Display the two-dimensional data in one figure split into 2.
    % q1: the projection points to the right camera on the right side of the screen,
    % q2: the projection points to the left camera on the left side of the screen.
    % Each side is 400x400, and the axis is 0-400. Grid on.
    
    % color vector for the epipolar lines 10 different colors in valid color names.
    color = ["#FF0000", "#00FF00", "#0000FF", "#00FFFF", "#FF00FF", "#FFFF00", 	"#A2142F", "#D95319", "#7E2F8E", "#77AC30"];


    figure(1);
    subplot(1,2,2);
    plot(q1(1,:), q1(2,:), 'b*');
    title('q1 - right camera');
    axis([0 400 0 400]);
    grid on;
    subplot(1,2,1);
    plot(q2(1,:), q2(2,:), 'r*');
    title('q2 - left camera');
    axis([0 400 0 400]);
    grid on;

    % pause and wait for the user to press a key.
    pause;
    
    % Print the index number in the same color as the line on the original point.
    for i = 1:10
        subplot(1,2,2);
        hold on;
        text(q1(1,i), q1(2,i)+10, num2str(i), 'Color', color(i), 'FontSize', 10, 'HorizontalAlignment', 'center');
        hold off;
                

        subplot(1,2,1);
        hold on;
        text(q2(1,i), q2(2,i)+10, num2str(i), 'Color', color(i), 'FontSize', 10, 'HorizontalAlignment', 'center');
        hold off; 
    end
    
    % pause and wait for the user to press a key.
    pause;
        
    % for each point in q1, calculate the epipolar line l2 in camera 2 and draw it on the left side.
    for i = 1:10
        % calculate the epipolar line l2 in camera 2.
        X = pinv(p1) * [q1(:,i); 1];
        x2 = p2 * X;
        c1 = null(p1);
        c1 = c1(1:4)/c1(4);
        e2 = p2 * c1;
        % skew symmetric matrix
        e2 = [0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];
        l2 = e2 * x2;
        % add the line on the left side.
        subplot(1,2,1);
        hold on;
        x = -1400:1400;
        y = (-l2(3) - l2(1)*x)/l2(2);
        plot(x, y, 'Color', color(i));
        hold off;
    end

    % pause and wait for the user to press a key.
    pause;

    % closw figure 1 and open figure 1 again.
    close(figure(1));
    figure(1);
    subplot(1,2,2);
    plot(q1(1,:), q1(2,:), 'b*');
    title('q1 - right camera');
    axis([0 400 0 400]);
    grid on;
    subplot(1,2,1);
    plot(q2(1,:), q2(2,:), 'r*');
    title('q2 - left camera');
    axis([0 400 0 400]);
    grid on;
    
    % Print the index number in the same color as the line on the original point.
    for i = 1:10
        subplot(1,2,2);
        hold on;
        text(q1(1,i), q1(2,i)+10, num2str(i), 'Color', color(i), 'FontSize', 10, 'HorizontalAlignment', 'center');
        hold off;
                

        subplot(1,2,1);
        hold on;
        text(q2(1,i), q2(2,i)+10, num2str(i), 'Color', color(i), 'FontSize', 10, 'HorizontalAlignment', 'center');
        hold off; 
    end
    
    
    % pause and wait for the user to press a key.
    pause;
    
    
    % for each point in q2, calculate the epipolar line l1 in camera 1 and draw it on the right side.
    for i = 1:10
        % calculate the epipolar line l1 in camera 1.
        X = pinv(p2) * [q2(:,i); 1];
        x1 = p1 * X;
        c2 = null(p2);
        c2 = c2(1:4)/c2(4);
        e1 = p1 * c2;
        % skew symmetric matrix
        e1 = [0 -e1(3) e1(2); e1(3) 0 -e1(1); -e1(2) e1(1) 0];
        l1 = e1 * x1;
        % add the line on the right side.
        subplot(1,2,2);
        hold on;
        x = -1400:1400;
        y = (-l1(3) - l1(1)*x)/l1(2);
        plot(x, y, 'Color', color(i));
        hold off;
    end

    % pause and wait for the user to press a key.
    pause;

    for i = 1:10
        % calculate the epipolar line l2 in camera 2.
        X = pinv(p1) * [q1(:,i); 1];
        x2 = p2 * X;
        c1 = null(p1);
        c1 = c1(1:4)/c1(4);
        e2 = p2 * c1;
        % skew symmetric matrix
        e2 = [0 -e2(3) e2(2); e2(3) 0 -e2(1); -e2(2) e2(1) 0];
        l2 = e2 * x2;
        % add the line on the left side.
        subplot(1,2,1);
        hold on;
        x = -1400:1400;
        y = (-l2(3) - l2(1)*x)/l2(2);
        plot(x, y, 'Color', color(i));
        hold off;
    end


end
