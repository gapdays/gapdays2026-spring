module GAPDays

#
# Import stuff we want to use or add methods to
#
import Oscar: AbstractAlgebra, GAP, GAPWrap
import Oscar: GapObj, parent, parent_type, elem_type, gens, gen, @req, order, check_parent
import Base: *, ==

# Declare our types
#
# Note: in real life, this is probably too limited. Better might be a type
# hierarchy like this:
#    TransformationSemigroup <: GAPSemigroup <: Semigroup <: AbstractAlgebra.Set
# 
struct GAPSemigroup <: AbstractAlgebra.Set
  X::GapObj
  
  function GAPSemigroup(X::GapObj)
    @req GAP.Globals.IsSemigroup(X) "X must be a semigroup"
    return new(X)
  end
end

struct GAPSemigroupElem <: AbstractAlgebra.SetElem
  parent::GAPSemigroup
  X::GapObj
  # TODO: add a constructor that verifies that X is a semigroup element of GapObj(parent)
  # TODO: possibly also add a `check::Bool=true` keyword argument that disable this
  # kind of check should it be expensive
end

# provide accessor functions
GAP.@install GapObj(obj::GAPSemigroup) = obj.X
GAP.@install GapObj(obj::GAPSemigroupElem) = obj.X
parent(x::GAPSemigroupElem) = x.parent

# model the relation between the two types
elem_type(::Type{GAPSemigroup}) = GAPSemigroupElem
parent_type(::Type{GAPSemigroupElem}) = GAPSemigroup

# printing
Base.show(io::IO, x::GAPSemigroup) = print(io, String(GAPWrap.StringViewObj(GapObj(x))))
Base.show(io::IO, x::GAPSemigroupElem) = print(io, String(GAPWrap.StringViewObj(GapObj(x))))

# Helpful constructor
function full_transformation_semigroup(n::Int)
  @req n > 0 "the argument must be a positive integer"
  return GAPSemigroup(GAP.Globals.FullTransformationSemigroup(n))
end

gens(S::GAPSemigroup) = [GAPSemigroupElem(S,x) for x in GAP.Globals.GeneratorsOfSemigroup(GapObj(S))]
gen(S::GAPSemigroup, i::Int) = GAPSemigroupElem(S, GAP.Globals.GeneratorsOfSemigroup(GapObj(S))[i])

order(S::GAPSemigroup) = GAP.Globals.Size(GapObj(S))

function Base.:*(x::GAPSemigroupElem, y::GAPSemigroupElem)
  check_parent(x, y) 
  return GAPSemigroupElem(parent(x), GapObj(x) * GapObj(y))
end

Base.:(==)(x::GAPSemigroupElem, y::GAPSemigroupElem) = parent(x) == parent(y) && GapObj(x) == GapObj(y)

# whenever we implement == we also must implement Base.hash
# here I am lazy and defined a trivial hash function
Base.hash(x::GAPSemigroupElem, h::UInt) = hash(GAPSemigroupElem, h)

export full_transformation_semigroup

end # of module


#=
# Some basic usage examples:

julia> using Oscar

julia> include("semigroups.jl")

julia> using .GAPDays

julia> S = GAPDays.full_transformation_semigroup(3)
<full transformation monoid of degree 3>

julia> order(S)
27

julia> gens(S)
4-element Vector{Main.GAPDays.GAPSemigroupElem}:
 IdentityTransformation
 Transformation( [ 2, 3, 1 ] )
 Transformation( [ 2, 1 ] )
 Transformation( [ 1, 2, 1 ] )

julia> S[1]
IdentityTransformation

julia> S[1] * S[2]
Transformation( [ 2, 3, 1 ] )

julia> S[1] * S[1] == S[1]
true

=#

