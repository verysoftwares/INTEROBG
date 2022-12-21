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
    local speedup=33
    if love.update==menu_update then speedup=0 end
    while t-spawn_t>=speedup do
        local i=1
        local tx,ty=0,0
        local a=spawn_t*0.4+pi/2
        local shape=shape1
        if spec.firstshape then
        a=atan2(y-(200/2-40),x-(320/2))
        shape=shape2
        end
        spec.firstshape=not spec.firstshape
        
        while i<=#shape do
            local char=sub(shape,i,i)
            if char=='x' then
                for i=0,3-1 do
                local a2=a+i*2*pi/3
                ins(bullets,{x=320/2-cos(a2)*20+cos(a2)*ty*5+cos(a2-pi/2)*tx*5,y=200/2-40-sin(a2)*20+sin(a2)*ty*5+sin(a2-pi/2)*tx*5,dx=cos(a2)*2.5,dy=sin(a2)*2.5,bt=spawn_t+speedup})
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

function stage16()
    spec.sc_t=spec.sc_t or t
    spec.pb=spec.pb or {} --persistent bullets
    spec.spawn_t2=spec.spawn_t2 or spawn_t
    local oy=0
    if love.update==menu_update then oy=-40 end
    while t-spawn_t>=3 do
        for i=0,3-1 do
        local a=(t-spec.sc_t)*0.4+i*0.2
        local a2=(t-spec.sc_t)*0.02
        ins(bullets,{x=320/2+cos(a2)*90,y=200/2+sin(a2)*90+oy,dx=cos(a),dy=sin(a),bt=spawn_t+3})
        end
        
        spawn_t=spawn_t+3
    end
    while t-spec.spawn_t2>=0 do
        local a2=(t-spec.sc_t)*0.02
        if a2<=2*pi then
        ins(bullets,{x=320/2+cos(a2)*90,y=200/2+sin(a2)*90+oy,dx=0,dy=0,bt=spec.spawn_t2})
        ins(spec.pb,bullets[#bullets])
        spec.pb[#spec.pb].r=90
        spec.pb[#spec.pb].a=a2
        end
        
        spec.spawn_t2=spec.spawn_t2+4
    end
end

-- doesn't use shared bullet update
function stage17()
    spec.bullet_formations=spec.bullet_formations or {}
    while t-spawn_t>=24 and #spec.bullet_formations<14 do
        local a=spawn_t*0.8
        ins(spec.bullet_formations,{})
        for i=0,8-1 do
        ins(bullets,{x=320/2+cos(i*(pi*2/8))*8,y=200/2+sin(i*(pi*2/8))*8,bt=spawn_t+24})
        ins(spec.bullet_formations[#spec.bullet_formations],bullets[#bullets])
        spec.bullet_formations[#spec.bullet_formations].x=320/2
        spec.bullet_formations[#spec.bullet_formations].y=200/2-40
        spec.bullet_formations[#spec.bullet_formations].dx=cos(a)*1.6
        spec.bullet_formations[#spec.bullet_formations].dy=sin(a)*1.6
        spec.bullet_formations[#spec.bullet_formations].bt=spawn_t+24
        spec.bullet_formations[#spec.bullet_formations].spawn_t=spawn_t+24
        end
        spawn_t=spawn_t+24
    end
    for j,form in ipairs(spec.bullet_formations) do
    for i,b in ipairs(form) do
        --if b.x<-6-1 or b.y<-6-1 or b.x>=320+1 or b.y>=200+1 then
        if sqrt((b.x+3-320/2)^2+(b.y+3-200/2)^2)>=90 then
            form.dx=-form.dx; form.dy=-form.dy
            break
        end
    end
    for i,b in ipairs(form) do
        b.x=b.x+form.dx*(t-b.bt); b.y=b.y+form.dy*(t-b.bt)
        b.bt=t
    end
    form.x=form.x+form.dx*(t-form.bt); form.y=form.y+form.dy*(t-form.bt)
    form.bt=t
    for j2,form2 in ipairs(spec.bullet_formations) do
        if form2~=form and t-form2.spawn_t>16 and sqrt((form2.x-form.x)^2+(form2.y-form.y)^2)<16 then
            local a=atan2(form2.y-form.y,form2.x-form.x)
            form2.dx=cos(a)*1.6; form2.dy=sin(a)*1.6
            form.dx=cos(a+pi)*1.6; form.dy=sin(a+pi)*1.6
            break
        end
    end
    end
end

function stage18()
    spec.sc_t=spec.sc_t or t
    local a=(t-spec.sc_t)*0.015
    for i,b in ipairs(spec.pb) do
        if b.r>30 then b.r=b.r-0.4*tmult end
        b.x=320/2+sin(a*0.8)*70+cos(b.a)*b.r; b.y=200/2+sin(a)*40+sin(b.a)*b.r
    end

    while t-spawn_t>=7 do
        for i=0,3-1 do
        local a=(t-spec.sc_t)*0.4+i*0.3
        local a2=(t-spec.sc_t)*0.02+pi/2
        ins(bullets,{x=320/2+cos(a2)*100+cos(i*0.4)*6,y=200/2+sin(a2)*100+sin(i*0.4)*6,dx=cos(a),dy=sin(a),bt=spawn_t+7})
        end
        
        spawn_t=spawn_t+7
    end
end

function stage19()
    spec.b2w6_a=spec.b2w6_a or {}
    spec.spawn_t2=spec.spawn_t2 or t    

    while t-spec.spawn_t2>=0 do
        ins(spec.b2w6_a,{t=-20,x=x,y=y,a=(t)*0.2,d=0})
        spec.warn_a=(t)*0.2
        spec.warn_t=t
        spec.spawn_t2=spec.spawn_t2+120
        spec.b2w6_b=false
    end
    if t-spec.warn_t>=30 and not spec.b2w6_b then spawn_t=t; spec.b2w6_b=true end
    if t-spec.warn_t>30 then
    while t-spawn_t>=2 do
    for j,swipe in ipairs(spec.b2w6_a) do
    for i=0,0 do
        ins(bullets,{x=swipe.x-cos(swipe.a)*(120-swipe.d)+cos(swipe.a+pi/2)*(i)*28,y=swipe.y-sin(swipe.a)*(120-swipe.d)+sin(swipe.a+pi/2)*(i)*28,dx=0,dy=0,bt=spawn_t+2})
        ins(swipe,bullets[#bullets])
    end
    swipe.d=swipe.d+6
    end
    spawn_t=spawn_t+2
    end
    end
    
    for j,swipe in ipairs(spec.b2w6_a) do
    for k,b in ipairs(swipe) do
        if k+60>swipe.t then break end
        if b.dx==0 and b.dy==0 then
            b.dx=cos(b.x*0.08)*0.4; b.dy=sin(b.x*0.08)*0.4
        end
    end
    swipe.t=swipe.t+tmult
    end
end

function stage20()
    while t-spawn_t>=1 do
        local a=(spawn_t)*143.402
        ins(bullets,{x=320/2-60,y=200/2-40,dx=cos(a)*1.25,dy=sin(a)*1.25,bt=spawn_t+1})
        ins(bullets,{x=320/2+60,y=200/2-40,dx=cos(-a)*1.25,dy=sin(-a)*1.25,bt=spawn_t+1})
        spawn_t=spawn_t+1
    end
end

function stage21()
    if not spec.b4w3_a then spec.b4w3_a={} end
    while t-spawn_t>=0 do
        local a=0
        while a<2*pi do
            ins(bullets,{x=320/2,y=35/2,dx=cos(a),dy=sin(a),bt=spawn_t})
            ins(spec.b4w3_a,bullets[#bullets])
            a=a+0.055
        end
        spawn_t=spawn_t+90
    end
    for i,b in ipairs(spec.b4w3_a) do
        if math.sqrt((b.x-(x+2))^2+(b.y-(y+2))^2)<=12 then
            b.dx=b.dx*0.85
            b.dy=b.dy*0.85
        end
    end
end

--[[function stage22()
    acc=acc or t*0.9
    while t-spawn_t>=1 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(acc*0.4)*0.2*8.8,dy=sin(acc*0.4)*0.2*8.8,bt=spawn_t+1})
        spawn_t=spawn_t+1
    end
    acc=acc+t*0.01
end]]

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