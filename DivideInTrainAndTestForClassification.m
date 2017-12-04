myFolder = 'D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\Features1000ImagesImageNetVgg16\';

if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern = fullfile(myFolder, '*.mat');
theFiles = dir(filePattern);


for k = 1 : 101
    training_ = [];
    test_ = [];
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    load(fullFileName,'features');
    for i = 1 : 700
        training_ = [training_ features(:,i)];
    end
    
    for i = 701 : 1000
        test_ = [test_ features(:,i)];
    end
    
    temp = 'D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\TrainigDataVgg70\';
    temp2 = strcat(temp,theFiles(k).name);
    save(temp2,'training_');
    
    temp = 'D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\TestDataVgg30\';
    temp2 = strcat(temp,theFiles(k).name);
    save(temp2,'test_');
    
end