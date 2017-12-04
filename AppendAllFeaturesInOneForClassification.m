myFolder = 'D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\TrainigDataVgg70\';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern = fullfile(myFolder, '*.mat');
theFiles = dir(filePattern);


 featuresTrainVgg70 = [];
 groupsVggAll = [];
for k = 1 : size(theFiles)
   direc = strcat(myFolder,theFiles(k).name); 
   load(direc,'training_');
   featuresTrainVgg70 = [featuresTrainVgg70 training_];
   groupsVggAll = [groupsVggAll;repmat(k,70,1)]; 
end
save('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\featuresTrainVgg70', 'featuresTrainVgg70');
save('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\groupsVggAll', 'groupsVggAll');