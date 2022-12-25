
%既に画像が作られていて動画のみ作成したいときこれを動かす

%data画像保存名・保存先
pathname.save='C:\Users\uswk0\OneDrive\デスクトップ\data\movie_out\'; 
video_name = 'out';


%動画作成用コード
workingDir = pathname.save;
imageNames = dir(fullfile(workingDir,'*.jpg'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,video_name),"MPEG-4");

%再生速度の変更(defaultの30は早すぎ)
outputVideo.FrameRate = 5;

open(outputVideo)
%writeAnimation(outputVideo)

%イメージ シーケンス内で繰り返し、各イメージを読み取り、それをビデオに書き込みます。
for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,imageNames{ii}));
   writeVideo(outputVideo,img)
end

%ビデオ ファイルを完成します。
close(outputVideo)

%最終的なビデオの表示
%リーダー オブジェクトを作成します。
shuttleMp4 = VideoReader(fullfile(workingDir,strcat(video_name,'.mp4')));

%ビデオ フレームから、MATLAB® ムービー struct を作成します。
ii = 1;
while hasFrame(shuttleMp4)
   mov(ii) = im2frame(readFrame(shuttleMp4));
   ii = ii+1;
end

%ビデオの幅および高さに基づいて現在の Figure および Axes のサイズを調整し、ムービーの最初のフレームを表示します。
figure 
imshow(mov(1).cdata, 'Border', 'tight')

%ビデオのフレーム レートでムービーを 1 回再生します。
movie(mov,1,shuttleMp4.FrameRate)