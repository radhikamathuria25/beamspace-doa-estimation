function esprit_roots = esprit_element_space(eig_vecs, N, D)
    Es = eig_vecs(:,N-D+1:end);
    E1 = Es(1:N-1,:);
    E2 = Es(2:N,:);
    phi = pinv(E1)*E2;
    [~,D1] = eig(phi);
    esprit_roots = diag(D1);
end 