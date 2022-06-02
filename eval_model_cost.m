function cost=eval_model_cost(batch_size,adj_param)
%trap_freq_bounds=[1,1e3]*2*pi;
%test_trap_freqs=rand_interval(trap_freq_bounds,[batch_size,3]);

trap_freq_bounds=[10,1e3]*2*pi;

main_aspect_ratio=rand_interval([4,50],[batch_size,1]);
diff_aspet_ratio=rand_interval([0.6,1.4],[batch_size,1]);
tight_freq=rand_interval(trap_freq_bounds,[batch_size,1]);
test_trap_freqs=nan(batch_size,3);
test_trap_freqs(:,1)=tight_freq;
test_trap_freqs(:,2)=tight_freq.*diff_aspet_ratio;
test_trap_freqs(:,3)=tight_freq./main_aspect_ratio;

mean_frac_errs=nan(1,batch_size);
for ii=1:batch_size
    this_trap_freq=test_trap_freqs(ii,:);
    
    % this_trap_freq=(2*pi)*[500,400,200]';
    tmax=100/min(this_trap_freq);
    [lambda_end,lambda_num_series]=tf_expand_scaling_trap_off_num(this_trap_freq,tmax);
    anal_lambda_values=tf_expand_scaling_trap_off_modv3_cigar_approx(this_trap_freq,lambda_num_series.time,adj_param);
    frac_lambda_err=frac_diff(anal_lambda_values,lambda_num_series.lambda);
%     stfig('error ratio');
%     clf
%     plot(lambda_num_series.time,frac_lambda_err,'-')
%     legend('$\Delta\lambda_x$','$\Delta\lambda_y$','$\Delta\lambda_z$','Location','northwest')
    
    % we integerate becasue the numerical slover does not always space points uniformly
    % we then divide by the range of times to turn this into an average fractional erro
    int_frac_err=trapz(lambda_num_series.time,abs(frac_lambda_err));
    avg_frac_err=(1/range(lambda_num_series.time)).*int_frac_err;
    avg_frac_err=abs(avg_frac_err);
    mean_frac_errs(ii)=rms(avg_frac_err);
end
cost=mean(mean_frac_errs);



end