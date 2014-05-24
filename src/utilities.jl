# need better dispatch in arg

function ss2float(ss::Array{Any})

# the rows is simply the length of the array of arrays 
# the cols are elements in each array

b = zeros(length(ss),length(ss[1]))

for r in 1:size(b,1)
    for c in 1:size(b,2)
    if ~isempty(ss[r][c])
        b[r,c] = parsefloat(ss[r][c])
    else
        b[r,c] = NaN
    end
    end
end

b
end
