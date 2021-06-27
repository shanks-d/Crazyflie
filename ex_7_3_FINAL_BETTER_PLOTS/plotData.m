function y = plotData(Pos, refPos)
indices = Pos.Time > 10 & Pos.Time < 47;
figure(1)
plot(Pos.Time,Pos.Data(:,1))
hold on
plot(Pos.Time,Pos.Data(:,2))
plot(Pos.Time,Pos.Data(:,3))

plot(Pos.Time,squeeze(refPos.Data(1,1,:)))
plot(Pos.Time,squeeze(refPos.Data(2,1,:)))
plot(Pos.Time,squeeze(refPos.Data(3,1,:)))
legend('X','Y','Z','Setpoint X','Setpoint Y','Setpoint Z')
hold off

figure(2)
error = Pos.Data - squeeze(refPos.Data(:,1,:))';
plot(Pos.Time,error(:,1))
hold on
plot(Pos.Time,error(:,2))
plot(Pos.Time,error(:,3))
legend('Error in X','Error in Y','Error in Z')
hold off

figure(3)
plot3(Pos.Data(indices,1),Pos.Data(indices,2),Pos.Data(indices,3))
hold on
plot3(squeeze(refPos.Data(1,1,indices)),squeeze(refPos.Data(2,1,indices)),squeeze(refPos.Data(3,1,indices)))
hold off
xlabel('x'); ylabel('y'); zlabel('z');

figure(4)
plot(Pos.Data(indices,1),Pos.Data(indices,2))
hold on
plot(squeeze(refPos.Data(1,1,indices)),squeeze(refPos.Data(2,1,indices)))
hold off
xlabel('x'); ylabel('y');
legend('Trajectory','Reference')