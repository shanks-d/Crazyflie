function y = plotData(pos, refPos)
indices = pos.Time < 30;
plot3(pos.Data(indices,1),pos.Data(indices,2),pos.Data(indices,3))
hold on
plot3(refPos.Data(:,1),refPos.Data(:,2),refPos.Data(:,3))
hold off
grid on
xlabel('x'); ylabel('y'); zlabel('z');
legend('Trajectory','Reference')