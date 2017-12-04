myFolder = 'D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\Features1000ImagesImageNetVgg16\All\';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern = fullfile(myFolder, '*.mat');
theFiles = dir(filePattern);


 featuresTrainVgg101x1000x4096 = [];
 %groupsVggAll = [];
for k = 1 : size(theFiles)
   direc = strcat(myFolder,theFiles(k).name); 
   %load(direc,'training_');
   myFile = load(direc);
   featuresTrainVgg101x1000x4096 = [featuresTrainVgg101x1000x4096 myFile.features];
   %groupsVggAll = [groupsVggAll;repmat(k,70,1)]; 
end
save('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\featuresTrainVgg4096_101,000','featuresTrainVgg101x1000x4096');
%save('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\groupsVggAll', 'groupsVggAll');