% !! You do not need to understand this code to do the lab !!
% Due to the manipulations required by the recording software, there is
% usually at the beginning and at the end of the data, time intervals where
% the robot is motionless. This function determines the start and stop
% indices of the meaningful part of the data, allowing to ignore these two
% phases.
% Author: G. Garcia

function [nbLoops,t,qL,qR,sensorReadings] = PreprocessData(...
    data, dots2rad, dumbFactor, subSamplingFactor )

% Skip motionless initial part if any
nbSamples = size(data,1) ;
i = 1 ;
while (i<nbSamples) && (data(i,1)-data(i+1,1)==0) && (data(i,2)-data(i+1,2)==0)
    i = i+1 ;
end
startIndex = i ;

% Skip motionless final part if any
i = nbSamples ;
while (i>1) && (data(i,1)-data(i-1,1)==0) && (data(i,2)-data(i-1,2)==0)
    i = i-1 ;
end
stopIndex = i ;

% Extract relevant data by removing motionless parts).

data = oneOfN( data(startIndex:stopIndex,:) , subSamplingFactor ) ;

qL = round(data(:,1)/dumbFactor)*dots2rad ;      % left wheel position in radians
qR = round(data(:,2)/dumbFactor)*dots2rad ;      % right wheel position in radians 
t  = data(:,4)-data(1,4)                  ;      % time instants of each period.
sensorReadings = data(:,3)                ;      % Raw sensor data
nbLoops = numel(t) ;

return
