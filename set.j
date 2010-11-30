struct Set{T}
    items::Array{T,1}

    Set() = new(Array(Any,0))
    Set{T}(T::Type) = new(Array(T,0))
end

has(set::Set, x) = any([ isequal(x,y) | y=set.items ])

function add(set::Set, x)
    if !has(set,x)
        items = clone(set.items, length(set.items)+1)
        for i = 1:length(set.items)
            items[i] = set.items[i]
        end
        items[end] = x
        set.items = items
    end
    set
end

add(set::Set, xs...) = (for x = xs; add(set, x); end; set)

function del(set::Set, x)
    if has(set,x)
        items = clone(set.items, length(set.items)-1)
        j = 1
        for i = 1:length(set.items)
            if !isequal(set.items[i],x)
                items[j] = set.items[i]
                j += 1
            end
        end
        set.items = items
    end
    set
end

del(set::Set, xs...) = (for x = xs; del(set, x); end; set)
