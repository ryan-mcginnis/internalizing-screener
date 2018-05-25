function pd = get_error_pd(truth,predicted)
    C = confusionmat(truth,predicted);
    Nts = sum(sum(C));
    ets = Nts - sum(diag(C));
    pd = makedist('Beta','a',ets+1,'b',Nts-ets+1);
end