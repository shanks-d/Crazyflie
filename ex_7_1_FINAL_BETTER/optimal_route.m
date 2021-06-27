function oTraj = optimal_route(ts, knots, velocity, start, hoop1, hoop2, end_, make_plots)
% 1. Prameter setting
dim = 3;
pntDensity = 3; % how many points per time 
objWeights = [0 1 1];  % 1 2 3 th order derivative
oTraj = OptimTrajGen(knots,pntDensity,dim);


% 2. Pin 
% 2.1 FixPin
Xs = [[start(1) start(2) 0.2];
      hoop1;
      hoop2;
      [end_(1) end_(2) 0.2]]'; % waypoints

Xdot = [ 0 0 0;
         0 1 0; 
         0 1 0;
         0 0 0]'.*velocity; % initial velocity

Xddot = [ 0;
          0; 
          0]; % initial acceleration

% Order 0 pin (waypoints)
for m = 1:size(Xs,2)
    pin = struct('t',ts(m),'d',0,'X',Xs(:,m));
    oTraj.addPin(pin);
end   
% Order 1 pin 
for m = 1:size(Xdot,2)
    pin = struct('t',ts(m),'d',1,'X',Xdot(:,m));
    oTraj.addPin(pin);
end
% Order 2 pin 
pin = struct('t',ts(end),'d',2,'X',Xddot);
oTraj.addPin(pin);

% 3. Solve 
oTraj.setDerivativeObj(objWeights); % set the objective function for penalizing the derivatives 
tic
oTraj.solve;
toc
%%  4. Plot 
if make_plots
    figh3 = figure(3); clf
    figh4 = figure(4); clf
    titleStr2 = [' minimzed derivatives order: ', num2str(find(objWeights > 0))];
    sgtitle(titleStr2)
    set(figh3,'Position',[193 294 1473 610]);
    plotOrder = 3; % Until 3rd order derivatives 
    oTraj.showTraj(plotOrder,figh3) % plot element-wise trajectory 
    oTraj.showPath(figh4)
end
end