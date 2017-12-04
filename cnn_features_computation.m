function FindFeatures100( name )
clc;
name
cd C:\matconvnet-master\
addpath matlab
addpath matlab\simplenn\
run  matlab/vl_setupnn
temp = 'E:\food-101\images\';
myFolder =  strcat(temp,name);
net = load('imagenet-vgg-verydeep-16.mat');
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
filePattern = fullfile(myFolder, '*.jpg');
count = 1;
features = zeros(1000);
theFiles = dir(filePattern);
for k = 1 : 1000
baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
   count=count+1;
  count
  baseFileName
  im = imread(fullFileName);
  im_ = single(im) ; % note: 0-255 range
  im_ = imresize(im_, net.normalization.imageSize(1:2));
  im_ = im_ - net.normalization.averageImage ;
  res = vl_simplenn(net, im_);
 
  x_ = res(end-2).x;
  for i = 1 : 4096
      features(k,i) = x_(i);
  end
  %imshow(imageArray);  % Display image
  %drawnow; % Force display to update immediately.
end
features = features';
temp = 'D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\Features1000ImagesImageNetVgg16\';
temp2 =  strcat(temp,name);
saveDir = strcat(temp2,'.mat');
save(saveDir,'features');
cd D://MS' CS'/thesis/kDEKCPKBR/feature' selection from food101 dataset'/
