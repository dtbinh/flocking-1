function res = fv(k, v, solx, u, N, d)% fx:R*Rd(N+1)*Rd(N+1) -> Rd(N+1)

res = S(v, N, d) + M(solx(:, :, k), N, d) + E(solx(:, :, k), v, N, d) + L(solx(:, :, k), N, d) + u(N+2:2*(N+1), :, k);

end