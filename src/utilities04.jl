# for v0.4

function ss2float{T<:AbstractString}(ss::Array{Array{T,1},1} )
    b = zeros(length(ss),length(ss[1]))
    
    for r in 1:size(b,1)
        for c in 1:size(b,2)
            if ~isempty(ss[r][c])
                b[r,c] = float(ss[r][c])
            else
                b[r,c] = NaN
            end
        end
    end
    
    return b
end
