-- originally from 'photos into photos'
-- repurposed to '3BUTTERF.EXE'
tan=math.tan

sw=128+90+120
sh=128+90+120

function point(x,y,z)
        return {x=x,y=y,z=z}
end

function mat4x4()
        return {{0,0,0,0},
                {0,0,0,0},
                {0,0,0,0},
                {0,0,0,0},
            }
end

function init_tris()
    spec.cube={}

    for i=0.1,0.9,0.2 do
        ins(spec.cube,point(i,0,0))
        ins(spec.cube,point(0,i,0))
        ins(spec.cube,point(0,0,i))
        ins(spec.cube,point(i,0,1))
        ins(spec.cube,point(0,i,1))
        ins(spec.cube,point(0,1,i))
        ins(spec.cube,point(i,1,0))
        ins(spec.cube,point(1,i,0))
        ins(spec.cube,point(1,0,i))
        ins(spec.cube,point(i,1,1))
        ins(spec.cube,point(1,i,1))
        ins(spec.cube,point(1,1,i))
    end

    for i,pt in ipairs(spec.cube) do
        pt.z=pt.z-0.5
        pt.x=pt.x-0.5
        pt.y=pt.y-0.5
        ins(bullets,{})
        pt.host=bullets[#bullets]
    end

    --projection matrix
    projmat = mat4x4()
    --rendering limits
    local near=0.1        --near..
    local far=1000        --far..
                          --..wherever you are
    local fov=90
    local aspect=sh/sw
    local fovrad=1/tan(fov*0.5 / 180*pi)
    
    projmat[1][1]=aspect*fovrad
    projmat[2][2]=fovrad
    projmat[3][3]=far/(far-near)
    projmat[4][3]=(-far*near)/(far-near)
    projmat[3][4]=1
    projmat[4][4]=0
end

function cubespin(ty)
    a=(t-spawn_t)*0.7 / 180*pi
    --rotation matrices
    matrotZ=mat4x4()
    matrotZ[1][1]=cos(a)*tmult
    matrotZ[1][2]=sin(a)*tmult
    matrotZ[2][1]=-sin(a)*tmult
    matrotZ[2][2]=cos(a)*tmult
    matrotZ[3][3]=tmult
    matrotZ[4][4]=tmult
    
    matrotX=mat4x4()
    matrotX[1][1]=tmult
    matrotX[2][2]=cos(a*0.5)*tmult
    matrotX[2][3]=sin(a*0.5)*tmult
    matrotX[3][2]=-sin(a*0.5)*tmult
    matrotX[3][3]=cos(a*0.5)*tmult
    matrotX[4][4]=tmult
    
    for i,pt in ipairs(spec.cube) do
        --projecting from 3D space to 2D space
        --making x,y meaningful in pt_project
        
        local pt_rotZ=point()
        vec_mat_mult(pt,pt_rotZ,matrotZ)

        local pt_rotZX=point()
        vec_mat_mult(pt_rotZ,pt_rotZX,matrotX)

        pt_rotZX.z=pt_rotZX.z+1.8
        
        local pt_project=point()
        vec_mat_mult(pt_rotZX,pt_project,projmat)
        
        --scale from -1..1 to screen size
            --to 0..2
            pt_project.x=pt_project.x+1; pt_project.y=pt_project.y+1
            --to 0..1 and sw,sh
            pt_project.x=pt_project.x*0.5*sw;            
            pt_project.y=pt_project.y*0.5*sh+ty;
                
        --rasterize
            pt.host.x=pt_project.x
            pt.host.y=pt_project.y
    end
end

--input vector, output/result vector, matrix
function vec_mat_mult(i, o, m)
        o.x = i.x*m[1][1] + i.y*m[2][1] + i.z*m[3][1] + m[4][1]
        o.y = i.x*m[1][2] + i.y*m[2][2] + i.z*m[3][2] + m[4][2]
        o.z = i.x*m[1][3] + i.y*m[2][3] + i.z*m[3][3] + m[4][3]
        w = i.x*m[1][4] + i.y*m[2][4] + i.z*m[3][4] + m[4][4]

        if not (w==0) then o.x=o.x/w; o.y=o.y/w; o.z=o.z/w end
end

function emptytriangle()
        return {{},{},{}}
end

function wireframe_tri(x1,y1,x2,y2,x3,y3,c)
        local len=math.sqrt((x2-x1)^2+(y2-y1)^2)
        local a=math.atan2(y2-y1,x2-x1)
        local drawn=false
        for i,b in ipairs(bullets) do
                if b.l1==x2 and b.l2==y2 and b.l3==x1 and b.l4==y1 then
                  drawn=true; break
                end
        end
        
        if not drawn then
        for step=0,len,18 do
                local id=34
                if step%18<12 then id=36 end
                ins(bullets,{l1=x1,l2=y1,l3=x2,l4=y2,x=x1+cos(a)*step,y=y1+sin(a)*step,dx=0,dy=0,id=id,bt=spawn_t})
        end
        end
        
        local len=math.sqrt((x3-x2)^2+(y3-y2)^2)
        local a=math.atan2(y3-y2,x3-x2)
        local drawn=false
        for i,b in ipairs(bullets) do
                if b.l1==x3 and b.l2==y3 and b.l3==x2 and b.l4==y2 then
                  drawn=true; break
                end
        end
        
        if not drawn then
        for step=0,len,18 do
                local id=34
                if step%18<12 then id=36 end
                ins(bullets,{l1=x2,l2=y2,l3=x3,l4=y3,x=x2+cos(a)*step,y=y2+sin(a)*step,dx=0,dy=0,id=id,bt=spawn_t})
        end
        end
        --line(x1,y1,x2,y2,c)
        --line(x2,y2,x3,y3,c)
        --line(x3,y3,x1,y1,c)
end