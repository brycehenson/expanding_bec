function lambda=tf_expand_scaling_trap_off_simple_cigar_approx(omega_tzero,t)

omega_tight=mean(omega_tzero(1:2));
omega_weak=omega_tzero(3);

lambda_tight=sqrt(1 + (omega_tight*t).^2);
lambda_weak=1 + (omega_weak/omega_tight).^2 * ...
                    ( (omega_tight*t).*atan(omega_tight.*t) - log(sqrt(1 + (omega_tight.*t).^2)) );

lambda=nan(numel(t),3);
lambda(:,1)=lambda_tight;
lambda(:,2)=lambda_tight;
lambda(:,3)=lambda_weak;

end