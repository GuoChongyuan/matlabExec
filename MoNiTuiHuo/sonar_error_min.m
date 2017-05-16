function min_sum = sonar_error_min(trans_coordinate,return_coordinate,target_coordinate,...
                                   trans_to_target_length,trans_to_return_length,transto_target_trangle,return_to_target_trangle)   %计算路径误差的最小值

tmpTransToTargetDiffLen = sqrt((target_coordinate.x - trans_coordinate.x)^2 + (target_coordinate.y - trans_coordinate.y)^2) - trans_to_target_length;
tmpReturnToTargetDiffLen = sqrt((return_coordinate.x - target_coordinate.x )^2 + (return_coordinate.y - target_coordinate.y)^2) - (trans_to_return_length -  trans_to_target_length);
tmpTransToTargetDiffTra = atan((target_coordinate.y - trans_coordinate.y)./(target_coordinate.x - trans_coordinate.x)) - transto_target_trangle;
tmpReturnToTargetDiffTra = atan((target_coordinate.y - return_coordinate.y)./(target_coordinate.x  - return_coordinate.x)) - return_to_target_trangle;

min_sum = tmpTransToTargetDiffLen^2 + tmpReturnToTargetDiffLen^2 + tmpTransToTargetDiffTra^2 + tmpReturnToTargetDiffTra^2;

