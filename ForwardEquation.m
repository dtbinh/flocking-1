function [solx, solv] = ForwardEquation(x0, v0, u, N, d, n,  h, t)

solx(:, :, 1) = x0;
solv(:, :, 1) = v0;


for k=1:n-1
    solx(:, :, k+1) = solx(:, :, k) + h*fx(k, solv, u, N);
    solv(:, :, k+1) = solv(:, :, k) + h*fv(k, solv(:, :, k), solx, u, N, d);
end


end

