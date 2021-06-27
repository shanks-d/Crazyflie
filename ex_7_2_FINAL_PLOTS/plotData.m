function y = plotData(Pos, refPos)
figure(1)
plot(Pos.Time,Pos.Data(:,1))
hold on
plot(Pos.Time,Pos.Data(:,2))
plot(Pos.Time,Pos.Data(:,3))

plot(refPos.Time,refPos.Data(:,1))
plot(refPos.Time,refPos.Data(:,2))
plot(refPos.Time,refPos.Data(:,3))
legend('X','Y','Z','Setpoint X','Setpoint Y','Setpoint Z')
hold off

figure(2)
error = Pos.Data - refPos.Data;
plot(Pos.Time,error(:,1))
hold on
plot(Pos.Time,error(:,2))
plot(Pos.Time,error(:,3))
legend('Error in X','Error in Y','Error in Z')
xlabel('Time'); ylabel('Error');
hold off

% Task 1
% indices = Pos.Time > 17 & Pos.Time < 29;
% time = Pos.Time(indices1)-17;

% Task 2
indices = Pos.Time > 40.5;
time = Pos.Time(indices)-40.5;

figure(3)
plot(Pos.Data(indices,1),Pos.Data(indices,2))
hold on
scatter(0,-2,'filled','r')
hold off
xlabel('X'); ylabel('Y');
legend('Observed','Reference')

figure(4)
subplot(3,1,1)
plot(time,Pos.Data(indices,1))
hold on
plot(time,refPos.Data(indices,1))
hold off
xlabel('Time'); ylabel('X');
ylim([min(min(Pos.Data(indices,1)),min(refPos.Data(indices,1)))-0.2, max(max(Pos.Data(indices,1)),max(refPos.Data(indices,1)))+0.2])
legend('Observed','Reference')

subplot(3,1,2)
plot(time,Pos.Data(indices,2))
hold on
plot(time,refPos.Data(indices,2))
hold off
xlabel('Time'); ylabel('Y');
ylim([min(min(Pos.Data(indices,2)),min(refPos.Data(indices,2)))-0.02, max(max(Pos.Data(indices,2)),max(refPos.Data(indices,2)))+0.02])
legend('Observed','Reference')

subplot(3,1,3)
plot(time,Pos.Data(indices,3))
hold on
plot(time,refPos.Data(indices,3))
hold off
xlabel('Time'); ylabel('Z');
legend('Observed','Reference')

figure(5)
error = Pos.Data - refPos.Data;
plot(time,error(indices,1))
hold on
plot(time,error(indices,2))
plot(time,error(indices,3))
legend('Error in X','Error in Y','Error in Z')
xlabel('Time'); ylabel('Error');
hold off