function [acc,spec,sens] = get_performance_metrics(truth,predicted)
    C = confusionmat(truth,predicted);
    acc = sum(diag(C)) / sum(sum(C));
    spec = C(1,1) / sum(C(1,:)); %true negative (noINTdx) / total negative
    sens = C(2,2) / sum(C(2,:)); %true positive (INTdx) / total positive
end