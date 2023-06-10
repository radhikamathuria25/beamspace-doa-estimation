function x = get_snapshot(N, D, AoA_theta, num_snapshots,var_mat)
    S = 1/sqrt(2).*(randn(D,num_snapshots) + 1j*randn(D,num_snapshots));
    Z = 1/sqrt(2)*(randn(num_snapshots,N) + 1j*randn(num_snapshots,N));
    n = 0:N-1;
    V = exp(1j*(n' - (N-1)/2)*pi*cos(rad2deg(AoA_theta)));
    x = V*S + Z';
end 