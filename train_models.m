function [labelsTestLog,scoresTestLog,selectedFeats] = train_models(features_pre,features_startle,features_post,labels,N)

    subjects = unique(features_pre(:,1)); %guaranteed to have same subjects as startle and post
    labelsTestLog = zeros(size(labels,1),3);
    scoresTestLog = zeros(size(labels,1),3);
    selectedFeats = zeros(N*length(subjects),3);
    for sub_ind = 1:length(subjects)
        % Partition train and test data
        ind = features_pre(:,1)==subjects(sub_ind);
        for j=1:3
            switch j
                case 1
                    dataTrain = features_pre(~ind,2:end);
                    labelsTrain = labels(~ind);
                    dataTest = features_pre(ind,2:end);
                case 2
                    dataTrain = features_startle(~ind,2:end);
                    labelsTrain = labels(~ind);
                    dataTest = features_startle(ind,2:end);
                case 3
                    dataTrain = features_post(~ind,2:end);
                    labelsTrain = labels(~ind);
                    dataTest = features_post(ind,2:end);
            end

            % Convert training features to z-scores 
            [dataTrain,mu,sigma]=zscore(dataTrain); %convert features to zscores

            % Rank training features using DB index
            db_rank = db_2class(dataTrain,labelsTrain);
            selectedFeats(sub_ind*N-(N-1):sub_ind*N,j) = db_rank(1:N);

            % Reduce dimensionality of training data by taking first N db-ranked features
            dataTrain = dataTrain(:,db_rank(1:N));

            % Convert test data to zscores and reduce dimensionality using info from training data
            dataTest = get_zscore(dataTest(:,db_rank(1:N)),mu(:,db_rank(1:N)),sigma(:,db_rank(1:N)));    

            % Train model
            mdl_log = fitclinear(dataTrain,labelsTrain,'Learner','logistic');

            % Predict on test data   
            [pred_label, pred_score] = predict(mdl_log,dataTest); 
            labelsTestLog(ind,j) = pred_label;
            scoresTestLog(ind,j) = pred_score(1,2); %probability of having diagnosis
        end

        fprintf(1,'Tested model on subject %u, %u/%u\n',subjects(sub_ind),sub_ind,length(subjects));
    end
end