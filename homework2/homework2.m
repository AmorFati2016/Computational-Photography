

path = 'C:\Users\Amor\Desktop\assgn2\data\face.mp4';
[videoInfo,video_frames_double] = initials(path);

%convert each of the frames to the YIQ color space
video_Frames_YIQ = convertYIQ(video_frames_double, videoInfo);

% create the laplace pyramid
filterSize = 5;
video_laplacianPyramid = buildVideoLaplacianPyramid(video_Frames_YIQ,videoInfo,filterSize);

% 
video_band_filtered  = lowPassFilter(video_laplacianPyramid,videoInfo);



%% amplify


%% reconstruction
out = temp{pyrH};
for i=pyrH-1:-1:1
    out  = temp{i} + imresize(out,[size(temp{i},1),size(temp{i},2)],'bilinear');
end

imshow(out);
    







