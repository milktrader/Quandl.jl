# for v0.4

#function ss2float{T<:String}(ss::Array{Array{T,1},1} )

# vals has this signature
# 100-element Array{Any,1}:
# SubString{ASCIIString}["102.54","104.14","101.64","104.03","40887168.0"]

#function ss2float(ss::Array{Any,1})
function ss2float(ss)

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
