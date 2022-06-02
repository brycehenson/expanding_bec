function lambda=tf_expand_scaling_trap_off_modv1_cigar_approx(omega_tzero,t)
% do a simple first order expansion

omega_tight=mean(omega_tzero(1:2));
lambda=nan(numel(t),3);


tight_ratio=(omega_tzero/omega_tight);
lambda(:,1)= tight_ratio(1) .* ...
                sqrt( 1 + (omega_tight.*t).^2 );
lambda(:,2)= tight_ratio(2) * ...
                sqrt( 1 + (omega_tight.*t).^2 );
lambda(:,3)= 1+tight_ratio(3).^2 .* ...
               ( (omega_tight.*t).*atan(omega_tight.*t) -...
                  log(sqrt(1 + (omega_tight.*t).^2)) );


end