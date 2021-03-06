% [ r, g, b] = read_colorchecker_gm()
% -----------------------------------
%
% returns a 4x6 matrix with sRGB linear  
% values of the Greatg-Macbeth color checker
% 
% function uses L*a*b* data under D50 illumination
% published by Gretag-Macbeth in 2005 
%  (according to
%  http://www.babelcolor.com/main_level/ColorChecker.htm )
%
% data obtained from  
% Danny Pascale: "RGB coordinates of the Macbeth ColorChecker",
% page 6
% (available from same webpage)
%
% the function performs chromatic adaptation from D50 to D65 (sRGB
% standard illum.) and a conversion from L*a*b* to linear sRGB values
% 
%  (c) 200x - 2011; x \in {9,10}, Ivo Ihrke
%  Universitaet des Saarlandes / MPI Informatik
%

function [ r, g, b] = read_colorchecker_gm();

%L a* b* data CIE D50 illumination for the Gretag Macbeth color
%checker

L =       ...
[ 37.986, ...
 65.711,  ...
 49.927,  ...
 43.139,  ...
 55.112,  ...
 70.719,  ...
 62.661,  ...
 40.020,  ...
 51.124,  ...
 30.325,  ...
 72.532,  ...
 71.941,  ...
 28.778,  ...
 55.261,  ...
 42.101,  ...
 81.733,  ...
 51.935,  ...
 51.038,  ...
 96.539,  ...
 81.257,  ...
 66.766,  ...
 50.867,  ...
 35.656,  ...
 20.461 ];


a = ...
[ 13.555, ...
18.130	, ...
-4.880	, ...
-13.095	, ...
8.844	, ...
-33.397	, ...
36.067	, ...
10.410	, ...
48.239	, ...
22.976	, ...
-23.709	, ...
19.363	, ...
14.179	, ...
-38.342	, ...
53.378	, ...
4.039	, ...
49.986	, ...
-28.631	, ...
-0.425	, ...
-0.638	, ...
-0.734	, ...
-0.153	, ...
-0.421	, ...
-0.079  ];


b = ...
[ 14.059,... 
17.810	,...
-21.925	,...
21.905	,...
-25.399	,...
-0.199	,...
57.096	,...
-45.964	,...
16.248	,...
-21.587	,...
57.255	,...
67.857	,...
-50.297	,...
31.370	,...
28.190	,...
79.819	,...
-14.574	,...
-28.638	,...
1.186	,...
-0.335	,...
-0.504	,...
-0.270	,...
-1.231	,...
-0.973  ];

L = reshape(L,6,4)';
a = reshape(a,6,4)';
b = reshape(b,6,4)';


Lab(:, :, 1 ) =  L;
Lab(:, :, 2 ) =  a;
Lab(:, :, 3 ) =  b;


%compute XYZ
XYZ = Lab_to_XYZ ( Lab, 'D50' ); 


%compute conversion matrices
[ M_XYZ_to_RGB, illuminant ] = XYZ_to_RGB_linear( 'sRGB' );

M = chromatic_adaptation_xyz ( 'D65', illuminant, 'Bradford' );

%apply conversion matrices
XYZ = apply_color_matrix( XYZ, M );
RGB = apply_color_matrix( XYZ, M_XYZ_to_RGB );

% we want linear RGB values for our HDR measurements
%RGB = XYZ_to_sRGB( XYZ );

r = RGB(:,:,1);
g = RGB(:,:,2);
b = RGB(:,:,3);

