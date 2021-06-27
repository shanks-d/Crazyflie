classdef node
    properties
        % Node which is this node's parrent
        parent
        % The position of the node
        position
        
        % The values which the node uses to calculate
        g
        h
        f
    end
    
    methods
        function h = calc_dist(obj, end_pos)
            h = sqrt((obj.position(1)-end_pos(1))^2 + ...
                     (obj.position(2)-end_pos(2))^2);
        end

        function h = calc_dist_3d(obj, end_pos)
            h = sqrt((obj.position(1)-end_pos(1))^2 + ...
                     (obj.position(2)-end_pos(2))^2 + ...
                     (obj.position(3)-end_pos(3))^2);
        end
        
        function g = calc_cost(obj, parent)
            g = sqrt((obj.position(1)-parent.position(1))^2 + ...
                     (obj.position(2)-parent.position(2))^2);
        end
        
        function g = calc_cost_3d(obj, parent)
            g = sqrt((obj.position(1)-parent.position(1))^2 + ...
                     (obj.position(2)-parent.position(2))^2 + ...
                     (obj.position(3)-parent.position(3))^3);
        end
    end
end