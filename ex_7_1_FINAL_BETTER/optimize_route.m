function [route_optimized] = optimize_route(route)
    temp_route = [route(1,:)];
    i = 1;
    while i < length(route)
        step = route(i+1,:) - route(i,:);
        if abs(step(1)) == 1
            temp_route = [temp_route; route(i,:) + [step(1)*0.5 0 0]; route(i+1,:)];
        elseif abs(step(2)) == 1
            temp_route = [temp_route; route(i,:) + [0 step(2)*0.5 0]; route(i+1,:)];
        else
            temp_route = [temp_route; route(i,:) + [0 0 step(3)*0.5]; route(i+1,:)];
        end
        i = i + 1;
    end
    route_optimized = temp_route;
end