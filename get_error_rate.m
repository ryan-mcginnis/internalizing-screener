function err = get_error_rate(truth,predicted)
    C = confusionmat(truth,predicted);
    Nts = sum(sum(C));
    ets = Nts - sum(diag(C));
    err = ets/Nts;
end