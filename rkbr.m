% 
% %% -----------------   Load Data

% seen_X = load('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\featuresTrainVgg4096_80,000.mat');
% seen_X =  seen_X.featuresTrainVgg80x1000x4096;
% unseen_X = load('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\featuresTrainVgg4096_21,000.mat');
% unseen_X = unseen_X.featuresTrainVgg21x1000x4096;
% Attributes_c  = load('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\Attributes103x101000_with_stem.mat'); 
% Attributes_c = Attributes_c.Xn;
% predicate_matrix_c = load('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\Attributes101x103_with_stem.mat');
% predicate_matrix_c = predicate_matrix_c.Cn;
% label = load('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\Labels1x101000.mat');
% label = label.labels;
% 
% %X = [seen_X, unseen_X]; % overfeat features.
% X = load('D:\MS CS\Thesis\KDEKCPKBR\Feature selection from food101 dataset\Dataset\featuresTrainVgg4096_101,000.mat');
% X = X.featuresTrainVgg101x1000x4096;
% 
% 
% %% Code to make 90 classes for train and 11 as test
% 
% 
% %% For Binary 
% % [qq ww] = size(Attributes_c);
% % for qqq = 1 : qq
% %     for www = 1 : ww
% %     if Attributes_c(qqq,www) > -0.02
% %         Attributes_c(qqq,www) = 1;
% %     end
% %     if Attributes_c(qqq,www) < -0.02
% %         Attributes_c(qqq,www)  = 0;
% %     end
% %     end
% % end
% % 
% % [qq ww] = size(predicate_matrix_c);
% % for qqq = 1 : qq
% %     for www = 1 : ww
% %     if predicate_matrix_c(qqq,www) > -0.02
% %         predicate_matrix_c(qqq,www) = 1;
% %     end
% %     if predicate_matrix_c(qqq,www) < -0.02
% %         predicate_matrix_c(qqq,www)  = 0;
% %     end
% %     end
% % end
% 
% %%
% 
% 
% Y = double(Attributes_c);
% YY = double(predicate_matrix_c'); 
% %Y = tempY;
% %YY = tempYY;
% 
% %Y = double(Attributes_word2vecz);
% %YY = double(word2vecz_matrix'); 
% 
% %Y(Y==0) = -1;
% %YY(YY==0) = -1;
% Y = bsxfun(@times,Y,1./sqrt(sum(Y.^2,1)));
% YY = bsxfun(@times,YY,1./sqrt(sum(YY.^2,1)));
% 
% % Train and Test set first 40 train, rest test
% %%%Xtrain = X(:,1:find(label == 91,1)-1);
% %%%Xtest = X(:,find(label == 91,1):end);
% %Xtrain = seen_X;
% %Xtest = unseen_X;
% 
% % % % % AllMeans = repmat(0,1,71);
% % % % % 
% % % % % for iiii = 1 : 71 
% % % % % 
% % % % % clear Xtrain
% % % % % clear Xtest
% % % % % clear Cx
% % % % % clear Cxx
% % % % % clear Cyx
% % % % % clear EX
% % % % % clear Ltest
% % % % % clear Ltrain
% % % % % clear Ytest
% % % % % clear Ytrain
% % % % % clear d
% % % % % clear lambda
% % % % % clear m_Xtest
% % % % % clear m_Xtrain
% % % % % 
% % % % % 
% % % % % startx = startxArr(iiii);
% % % % % endx = endxArr(iiii);
% % % % % sstartx = sstartxArr(iiii);
% % % % % eendx = eendxArr(iiii);
% % % % % 
% % % % %  
% % % % %  Xtrain = X(:,[1:startx endx+1:end]);
% % % % %  Xtest = X(:,startx+1:endx);
% % % % %  YYtrain = YY(:,[1:sstartx eendx+1:end]);
% % % % %  YYtest = YY(:,sstartx+1:eendx);
% % % % %  Ytrain = Y(:,[1:startx endx+1:end]);
% % % % %  Ytest = Y(:,startx+1:endx);
% % % % %  Ltrain = label(:,[1:startx endx+1:end]);
% % % % %  Ltest = label(:,startx+1:endx);
% 
% Xtrain = X(:,1:90000);
% Xtest = X(:,90000+1:101000);
% 
% 
% 
% Ytrain = Y(:,1:find(label == 91,1)-1);
% Ytest = Y(:,find(label == 91,1):end);
% YYtrain = YY(:,1:90);
% YYtest = YY(:,91:end);
% 
% 
% 
% 
% Ltrain = label(:,1:find(label==91,1)-1);
% Ltest = label(:,find(label==91,1):end);
% 
% dim1 = size(X,1);
% dim2 = size(Y,1);
% n = size(Xtrain,2);
% 
% %% -----------------   Set parameters
% nevects = 300;
% en = 1;
% %X_model ='D:/MS CS/Thesis/KDE, KCP & KBR/data/models/eigX_overfeat.mat'; %'C:/data/models/eigX_overfeat.mat';
% %X_model = './models/eigX_overfeat.mat';
% %classifier_model = './models/model_overfeat_reduce.mat';
% 
% 
% %% -----------------    Load feature points model
% %if(~exist(X_model))
% 
% m_Xtrain = Xtrain;
% m_Xtest = Xtest;
% 
% m_Ytrain = Ytrain;
% m_Ytest = Ytest;
% m_YYtrain = YYtrain;
% m_YYtest = YYtest;
% 
% m_Ltrain = Ltrain;
% m_Ltest = Ltest;
% 
% 
% ii = 1;
% jj = 1;
% %for eigValsX = 200:100:1000
% %for eigValsY = 20:5:70
% eigValsX = 300;
% eigValsY = 65;
% Xtrain = m_Xtrain;
% Xtest = m_Xtest;
% 
% Ytrain = m_Ytrain;
% Ytest = m_Ytest;
% YYtrain = m_YYtrain;
% YYtest = m_YYtest;
% 
% Ltrain = m_Ltrain;
% Ltest = m_Ltest;   

if jj==1
    if ii==1
Cx = Xtrain*Xtrain';
    end
end
[EX,DX]=eigs(Cx,eigValsX);
DX = diag(DX);
 %   save(X_model,'EX','DX');
%else
 %   load(X_model);
%end
EX = EX(:,1:eigValsX);
DX = DX(1:eigValsX);
Xtrain = EX'*Xtrain;
Xtest = EX'*Xtest;

if jj==1
    if ii==1
Cy = YYtrain*YYtrain';
    end
end

[EY,DY]=eigs(Cy,eigValsY);
DY = diag(DY);
Ytrain = EY'*Ytrain;
YYtrain = EY'*YYtrain;
Ytest = EY'*Ytest;
YYtest = EY'*YYtest;

dim1 = size(Xtrain,1);
dim2 = size(Ytrain,1);
%
%W = Ytrain* Xtrain' *inv(Xtrain*Xtrain' + en.*eye(nevects));
lambda = Ytrain'*inv(YYtrain*YYtrain'+ en.*eye(dim2))*YYtest*ones(11,1)./11;
Cxx = Xtrain.*repmat(lambda',dim1,1)*Xtrain';
%Cyx = Ytrain.*repmat(lambda',dim2,1)*Xtrain';
Cyx = inv(YYtrain*YYtrain'+ en.*eye(dim2))*Ytrain*Xtrain';
W = Cyx *inv(Cxx^2 + en.*eye(dim1))*Cxx;
%% ------------------      Classifier model
% if(~exist(classifier_model))
%     model = train(label',sparse(X),'-s 6','col');
%     save(classifier_model, 'model');
% else
%     load(classifier_model);
% end
% [la,ac,pr] = predict(ones(size(Xtest,2),1), sparse(Xtest), model, '-b 1', 'col');
Yt = W * Xtest;
d = pdist2(Yt',YYtest','euclidean'); % distance

%% Accuracy Calculation

[~, idx] = sort(d,2,'ascend');
k = 1;
val = any(idx(:,1:k) == repmat(Ltest'-90 ,1,k),2);
fprintf('\n');
fprintf('StartX = %.1f\n',90);
for i =1:11
	fprintf('%d. %.1f, ',i, 100.*sum(val((Ltest-90)==i))./length(find((Ltest-90)==i)));
end
fprintf('\n');
%eigValsX
%eigValsY
fprintf('Acc = %.1f\n',100.*sum(val)./size(Xtest,2));
%%AllMeans = [AllMeans 100.*sum(val)./size(Xtest,2)]
%accuracy_list(ii,jj)= 100.*sum(val)./size(Xtest,2);
%jj=jj+1;
%end
%ii=ii+1;
%end


%end





