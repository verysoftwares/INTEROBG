-- bullet spawning logic

spec={}

-- doesn't use shared bullet update
function stage1()
    for i=#bullets,1,-1 do
        bullets[i].x=160+bullets[i][1]*cos(t*0.004*8.8+pi/2)
        bullets[i].y=100+bullets[i][1]*sin(t*0.004*8.8+pi/2)
    end
end

function stage2()
    while t-spawn_t>=3 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(spawn_t*0.4)*0.2*8.8,dy=sin(spawn_t*0.4)*0.2*8.8,bt=spawn_t+3})
        spawn_t=spawn_t+3
    end
end

function stage3()
    local acc=3+sin(t*0.04)*2.5
    while t-spawn_t>=acc do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(spawn_t*0.4)*0.2*8.8,dy=sin(spawn_t*0.4)*0.2*8.8,bt=spawn_t+acc})
        spawn_t=spawn_t+acc
    end
end

function stage4()
    while t-spawn_t>=3 do
        ins(bullets,{x=320/2+cos(spawn_t*0.09)*34,y=200/2-40+sin(spawn_t*0.12)*12,dx=cos(spawn_t*0.07)*0.1*8.8,dy=sin(spawn_t*0.09)*0.1*8.8,bt=spawn_t+3})
        spawn_t=spawn_t+3
    end
end

function stage5()
    while t-spawn_t>=2 do
        ins(bullets,{x=320/2+cos(spawn_t*0.02)*34,y=200/2-40+sin(spawn_t*0.03)*12,dx=cos(spawn_t*0.22)*0.1*8.8,dy=sin(spawn_t*0.35)*0.1*8.8,bt=spawn_t+2})
        spawn_t=spawn_t+2
    end
end

function stage6()
    while t-spawn_t>=12 do
        for i=0,10-1 do
        ins(bullets,{x=320/2+cos(spawn_t*0.3)*34,y=200/2-40+sin(spawn_t*0.2)*12,dx=cos(i*2*math.pi/10)*0.1*8.8,dy=sin(i*2*math.pi/10)*0.1*8.8,bt=spawn_t+12})
        end
        spawn_t=spawn_t+12
    end
end

function stage7()
    while t-spawn_t>=3 do
        local acc=151.8
        local sep=4
        for i=0,1-1 do
        ins(bullets,{x=320/2-40,y=200/2-40,dx=cos(spawn_t*0.41*acc+i*sep)*0.15*8.8,dy=sin(spawn_t*0.41*acc+i*sep)*0.15*8.8,bt=spawn_t+3})
        end
        acc=-acc
        for i=0,1-1 do
        ins(bullets,{x=320/2+40,y=200/2-40,dx=-cos(spawn_t*0.41*acc-i*sep)*0.15*8.8,dy=-sin(spawn_t*0.41*acc-i*sep)*0.15*8.8,bt=spawn_t+3})
        end
        spawn_t=spawn_t+3
    end
end

function stage8()
    while t-spawn_t>=0 do
        local acc=14.1
        local sphere=24
        local xpos=sin(spawn_t*0.01)*40
        for i=0,sphere-1 do
        ins(bullets,{x=320/2-xpos,y=200/2-40,dx=cos(spawn_t*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,dy=sin(spawn_t*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,bt=spawn_t+48})
        end
        for i=0,sphere-1 do
        ins(bullets,{x=320/2+xpos,y=200/2-40,dx=cos(spawn_t*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,dy=sin(spawn_t*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,bt=spawn_t+48})
        end
        spawn_t=spawn_t+48
    end
end

function stage9()
    while t-spawn_t>=3 do
        local acc=13.8
        local sep=4.2
        for i=0,2-1 do
        ins(bullets,{x=320/2-40,y=200/2-40,dx=cos(spawn_t*0.41*acc+i*sep)*0.15*8.8,dy=sin(spawn_t*0.41*acc+i*sep)*0.15*8.8,bt=spawn_t+3})
        end
        acc=-acc
        for i=0,2-1 do
        ins(bullets,{x=320/2+40,y=200/2-40,dx=-cos(spawn_t*0.41*acc-i*sep)*0.15*8.8,dy=-sin(spawn_t*0.41*acc-i*sep)*0.15*8.8,bt=spawn_t+3})
        end
        spawn_t=spawn_t+3
    end
end

function stage10()
    while t-spawn_t>=3 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(spawn_t*131.1)*0.1*8.8,dy=sin(spawn_t*131.1)*0.1*8.8,bt=spawn_t+3})
        if spawn_t%48<12 then
        local a=atan2(y-bullets[#bullets].y,x-bullets[#bullets].x)
        bullets[#bullets].dx=cos(a)*0.2*8.8
        bullets[#bullets].dy=sin(a)*0.2*8.8
        end
        spawn_t=spawn_t+3
    end
end

function stage11()
    while t-spawn_t>=3 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(spawn_t*5.12)*0.2*8.8,dy=sin(spawn_t*5.12)*0.2*8.8,bt=spawn_t+3})
        if spawn_t%48<24 then
        ins(bullets,{x=320/2-40+cos(spawn_t*0.12)*34,y=200/2-40,bt=spawn_t+3})
        local a=atan2(y-bullets[#bullets].y,x-bullets[#bullets].x)
        bullets[#bullets].dx=cos(a)*0.2*8.8
        bullets[#bullets].dy=sin(a)*0.2*8.8
        else
        ins(bullets,{x=320/2+40+cos(spawn_t*0.12)*34,y=200/2-40,bt=spawn_t+3})
        local a=atan2(y-bullets[#bullets].y,x-bullets[#bullets].x)
        bullets[#bullets].dx=cos(a)*0.2*8.8
        bullets[#bullets].dy=sin(a)*0.2*8.8
        end
        spawn_t=spawn_t+3
    end
end

function stage12()
    if not spec.homer then
        spec.homer={x=320/2,y=200/2-40,bt=spawn_t}
        ins(bullets,spec.homer)
    end
    
    while t-spawn_t>=1 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(spawn_t*5.16)*0.12*8.8,dy=sin(spawn_t*5.16)*0.12*8.8,bt=spawn_t+1})
        spawn_t=spawn_t+1
    end

    local a=atan2(y-spec.homer.y,x-spec.homer.x)
    spec.homer.dx=cos(a)*0.06*8.8
    spec.homer.dy=sin(a)*0.06*8.8
end

function all_grazed()
    if #bullets==0 then return false end
    for i,b in ipairs(bullets) do
        if not b.grazed then return false end
    end
    return true
end

require '3d'

-- doesn't use shared bullet update
function stage13()
    if not spec.cube then init_tris() end
    cubespin(math.min((t-spawn_t)*1.25-210,-67))
    table.sort(bullets,function(a,b) return a.pt.z2>b.pt.z2 end)
end

local shape1=[[
  xxxx
 xxxxxx
xxx  xxx
xx    xx
     xxx
    xxx
   xxx
   xx
   xx

   xx
   xx
]]
local shape2=[[
 xx
xxxx
xxxx
xxxx
xxxx
xxxx
 xx
 xx
 xx

 xx
 xx
]]

function stage14()
    while t-spawn_t>=0 do
        local i=1
        local tx,ty=0,0
        local a=spawn_t*0.4+pi/2
        local shape=shape1
        if t%66<33 then
        a=atan2(y-(200/2-40),x-(320/2))
        shape=shape2
        end
        
        while i<=#shape do
            local char=sub(shape,i,i)
            if char=='x' then
                for i=0,3-1 do
                local a2=a+i*2*pi/3
                ins(bullets,{x=320/2-cos(a2)*20+cos(a2)*ty*5+cos(a2-pi/2)*tx*5,y=200/2-40-sin(a2)*20+sin(a2)*ty*5+sin(a2-pi/2)*tx*5,dx=cos(a2)*2.5,dy=sin(a2)*2.5,bt=spawn_t})
                end
            end
            tx=tx+1
            if char=='\n' then
                tx=0; ty=ty+1
            end
            i=i+1
        end
        spawn_t=spawn_t+33
    end
end

function stage15()
    while t-spawn_t>=0 do
        for k=0,3-1 do
        local a2=spawn_t*0.2+k*pi/4
        for j=0,4-1 do
        local ox,oy
        ox=-cos(a2+pi/2+pi/2*j)*20
        oy=-sin(a2+pi/2+pi/2*j)*20
        for i=0,8-1 do
            local a,d
            ins(bullets,{x=320/2-ox-90+k*90-cos(a2+pi/2*j)*20+i*5*cos(a2+pi/2*j),y=200/2-20-oy-sin(a2+pi/2*j)*20+i*5*sin(a2+pi/2*j),dx=0,dy=-1,bt=spawn_t})
            d=sqrt((bullets[#bullets].y-(200/2-20))^2+(bullets[#bullets].x-(320/2-90+k*90))^2)
            a=atan2(bullets[#bullets].y-(200/2-20),bullets[#bullets].x-(320/2-90+k*90))
            bullets[#bullets].dx=cos(a)*d*0.032; bullets[#bullets].dy=sin(a)*d*0.032
        end
        end
        end
        spawn_t=spawn_t+99
    end
end

-- victory screen
-- shows fireworks if you made a high score
function stage25()
    if score>hiscores[circuit] then
        while t-spawn_t>=12 do
            for i=0,20-1 do
            ins(bullets,{safe=true,x=320/2+cos(spawn_t*0.3)*34,y=200/2-40+sin(spawn_t*0.2)*12,dx=cos(i*2*math.pi/20)*0.1*8.8,dy=sin(i*2*math.pi/20)*0.1*8.8,bt=spawn_t+12})
            end
            spawn_t=spawn_t+12
        end
    end
end