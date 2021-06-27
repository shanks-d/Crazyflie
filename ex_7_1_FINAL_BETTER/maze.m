
% This file contains parameters and calculations needed for running
% MatLab with rotorS ROS package for interfacing with a position controlled
% drone

function [route, route_optimized, start, end_, hoop1, hoop2] = maze()

%% Input the map
load('maze.txt')
wall = maze;

% Define the map size
max_x = wall(length(wall) - 2, 1);
max_y = wall(length(wall) - 2, 2);
max_z = wall(length(wall) - 2, 3);
map = zeros(max_x, max_y, max_z);

% Input the obstacles into the map
for i = 1:(length(wall) - 3)
    map = gen_square3d([wall(i, 1) wall(i, 1) + 1;...
                        wall(i, 2) wall(i, 2) + 1;...
                        wall(i, 3) wall(i, 3) + 1], map);
    
end

%% Start and Goal positions
% E = [1 1 1];
% F = [2 1 1];
% G = [3 1 1];
% H = [4 1 1];
% 
% A = [1 5 1];
% B = [2 5 1];
% C = [3 5 1];
% D = [4 5 1];

start = wall(length(wall) - 1, :);
end_ = wall(length(wall), :);

%% Path planning
route_Astar = Astar_3d(map, start, end_);

% Connect all the waypoints along one direction
route_Astar_optimized = optimize_route(route_Astar);

%% Draw the map and route of Astar
% Draw a figure to show the map and process
figure('Name','Astar')
% Mark the start with green
scatter3(start(1)+0.5, start(2)+0.5, start(3)+0.5, ...
         500, [0,1,0],'filled')
hold on

% Mark the end with red
scatter3(end_(1)+0.5, end_(2)+0.5, end_(3)+0.5, ...
         500, [1,0,0], 'filled')
hold on

% Draw the obstacles
for i = 1:(length(wall) - 3)
    map = gen_square3d([wall(i, 1) wall(i, 1) + 1;...
                        wall(i, 2) wall(i, 2) + 1;...
                        wall(i, 3) wall(i, 3) + 1], map, 1);
    
end

% Set the axes
axis([1 max_x+1 1 max_y+1 1 max_z+1])
% Make the grid lines more visible
ax = gca;
ax.GridAlpha = 1.0;
grid on
set(gca, 'xtick', [0:1:max_x])
set(gca, 'ytick', [0:1:max_y])
set(gca, 'ztick', [0:1:max_z])

% Draw the route
route_ = route_Astar_optimized;

for i = 2:length(route_)
    plot3([route_(i-1,1)+0.5,route_(i,1)+0.5], ...
          [route_(i-1,2)+0.5,route_(i,2)+0.5], ...
          [route_(i-1,3)+0.5,route_(i,3)+0.5], ...
          'color',[0,0,0],'linewidth',5)
    hold on
end
hold off

%% Scale the route
total_height = 2.05;
wall_height = 0.6;
ground_offset = total_height - 3 * wall_height;
wall_center = ground_offset + wall_height / 2;

% Actual world
r_hat_min = [0.3 0.5 wall_center];
r_hat_max = [2.3 2.6 (total_height - wall_height / 2)];

% Matlab world
r_max = [max_x max_y max_z];
r_min = [1 1 1];

% Scaling parameters
scale = (r_hat_max - r_hat_min)./ (r_max - r_min);
offset = r_hat_min - scale.*r_min;

% Scale the route
route_scaled = route_Astar.*scale + offset;
route_optimized_scaled = route_Astar_optimized.*scale + offset;
start = start.*scale + offset;
end_ = end_.*scale + offset;

% To land the drone at the goal position
route = [route_scaled; [route_scaled(end,1),route_scaled(end,2),0.2]];
route = [route; [route(end,1),route(end,2),-1]];

route_optimized = [route_optimized_scaled; [route_optimized_scaled(end,1),route_optimized_scaled(end,2),0.2]];
route_optimized = [route_optimized; [route_optimized(end,1),route_optimized(end,2),-1]];

%% Gather hoop coordinates
k = 1;
hoop1 = [0 0 0];
while k < length(route_optimized)
    step = route_optimized(k+1,:) - route_optimized(k,:);
    if abs(step(2)) ~= 0
        if hoop1 == [0 0 0]
            hoop1 = route_optimized(k+2,:);
            k = k + 3;
        else
            hoop2 = route_optimized(k+2,:);
            break
        end
    end
    k = k + 1;
end

% Draw the route again
figure
route_ = route_optimized;
scatter3(route_(1,1), route_(1,2), route_(1,3),'g','filled')
hold on
for i = 2:length(route_)-1
    scatter3(route_(i,1), route_(i,2), route_(i,3),'b','filled')
    plot3([route_(i-1,1),route_(i,1)], ...
          [route_(i-1,2),route_(i,2)], ...
          [route_(i-1,3),route_(i,3)], ...
          'color',[0,0,0],'linewidth',1)
end
scatter3(route_(end-1,1), route_(end-1,2), route_(end-1,3),'r','filled')
% scatter3(hoop1(1), hoop1(2), hoop1(3),'m','filled')
% scatter3(hoop2(1), hoop2(2), hoop2(3),'m','filled')
xlabel('x'); ylabel('y'); zlabel('z');
xlim([0,r_hat_max(1)]); ylim([0,r_hat_max(2)]); zlim([0,r_hat_max(3)]);
hold off

figure
route_ = route;
scatter3(route_(1,1), route_(1,2), route_(1,3),'g','filled')
hold on
for i = 2:length(route_)-1
    scatter3(route_(i,1), route_(i,2), route_(i,3),'b','filled')
    plot3([route_(i-1,1),route_(i,1)], ...
          [route_(i-1,2),route_(i,2)], ...
          [route_(i-1,3),route_(i,3)], ...
          'color',[0,0,0],'linewidth',1)
end
scatter3(route_(end-1,1), route_(end-1,2), route_(end-1,3),'r','filled')
xlabel('x'); ylabel('y'); zlabel('z');
xlim([0,r_hat_max(1)]); ylim([0,r_hat_max(2)]); zlim([0,r_hat_max(3)]);
hold off

end