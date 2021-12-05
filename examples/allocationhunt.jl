using ExtendableGrids



function dosomething(::Type{Triangle2D},coord,cn, icell)
    nn=size(cn,1)
    nd=size(coord,1)
    s=0.0
    for i=1:nn
        for j=1:nd
            s+=coord[j,cn[i,icell]]
        end
    end
    s
end

function tstest(grid)
    C=grid[Coordinates]
    s=sum(C)

    CN=grid[CellNodes]
    s+=sum(CN)
    ncells=size(CN,2)
    geoms=grid[CellGeometries]
    

    for icell=1:ncells
        s+=dosomething(geoms[icell],C,CN,icell)
    end
    
    #CV=grid[CellVolumes]
    #s+=sum(CV)
    s
end

function typestabilitytest(;n=20)
    X=collect(0:1/n:1)
    grid=simplexgrid(X,X)


    @code_warntype tstest(grid)
    @time tstest(grid)
end



@noinline function dosomething2(::Type{Triangle2D},x,i)
    return x[i]
end

@noinline function dosomething2(::Type{Tetrahedron3D},x,i)
    return x[i]
end
    
function typestabilitytest2(;n=100)
    geoms=rand([Triangle2D,Tetrahedron3D],n)
    x=rand(n)
    @show typeof(geoms)
    geom=geoms[1]

    s=0
    @time for i=1:n
@views       s+=dosomething2(geoms[i],x,i) 
    end
    s
end
