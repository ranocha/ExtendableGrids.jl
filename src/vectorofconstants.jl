"""
$(TYPEDEF)

Vector with constant value
"""
struct VectorOfConstants{T} <: AbstractVector{T}
    val::T
    len::Int64
end
VectorOfConstants(v::T,len::Tl) where {T,Tl<:Integer}=VectorOfConstants{T}(v,Int64(len))

Base.IndexStyle(::Type{<:VectorOfConstants}) = IndexLinear()


"""
$(TYPEDSIGNATURES)

Length
"""
Base.length(v::VectorOfConstants)=v.len

"""
$(TYPEDSIGNATURES)

Size
"""
Base.size(v::VectorOfConstants)=(v.len,)

"""
$(TYPEDSIGNATURES)

Access
"""
function Base.getindex(v::VectorOfConstants{T},i)::T where{T}
    v.val
end

function Base.getindex(v::VectorOfConstants{T},i)::T where{T}
    v.val
end

"""
$(TYPEDSIGNATURES)

Iterator
"""
Base.iterate(v::VectorOfConstants)  = (v.val,1)
"""
$(TYPEDSIGNATURES)

Iterator
"""
Base.iterate(v::VectorOfConstants,state) =  state>=v.len ? nothing : (v.val, state+1)

"""
$(TYPEDSIGNATURES)

Shortcut for unique
"""
Base.unique(v::VectorOfConstants)=[v.val]






