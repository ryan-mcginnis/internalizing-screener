function total_labels = feature_vector_script
% Build feature label vector
feat_labels = {'mean','rms','skew','kurtosis','range','max','min','std','peak2rms','cov_ht0','cov_loc_pk1','cov_ht_pk1',...
               'spk_loc_pk1','spk_loc_pk2','spk_loc_pk3','spk_loc_pk4','spk_loc_pk5','spk_loc_pk6',...
               'spk_ht_pk1','spk_ht_pk2','spk_ht_pk3','spk_ht_pk4','spk_ht_pk5','spk_ht_pk6',...
               'spw_band1','spw_band2','spw_band3','spw_band4','spw_band5'};
           
total_labels = cell(length(feat_labels)*6,1);
feat_types = {'ah','av','wh','wv','tilt','yaw'};
for i = 1:length(feat_types)
    for j = 1:length(feat_labels)
        total_labels{(i-1)*length(feat_labels)+j}=[feat_types{i},'_',feat_labels{j}];
    end
end
end
