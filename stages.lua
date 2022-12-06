-- bullet spawning logic

spec={}

function stage1()
    -- stage 1 doesn't use shared bullet update
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

function stage15()
    while t-spawn_t>=16 do
        local a2=spawn_t*0.2
        for j=0,4-1 do
        local ox,oy
        ox=-cos(a2+pi/2+pi/2*j)*20
        oy=-sin(a2+pi/2+pi/2*j)*20
        for i=0,8-1 do
            local a,d
            ins(bullets,{x=320/2-ox-cos(a2+pi/2*j)*20+i*5*cos(a2+pi/2*j),y=200/2-20-oy-sin(a2+pi/2*j)*20+i*5*sin(a2+pi/2*j),dx=0,dy=-1,bt=spawn_t+16})
            d=sqrt((bullets[#bullets].y-(200/2-20))^2+(bullets[#bullets].x-(320/2))^2)
            a=atan2(bullets[#bullets].y-(200/2-20),bullets[#bullets].x-(320/2))
            bullets[#bullets].dx=cos(a)*d*0.04; bullets[#bullets].dy=sin(a)*d*0.04
        end
        end
        spawn_t=spawn_t+16
    end
end

-- victory screen
-- shows fireworks if you made a high score
function stage25()
    if score>hiscores[circuit] then
        while t-spawn_t>=12 do
            for i=0,20-1 do
            ins(bullets,{safe=true,x=320/2+cos(spawn_t*0.3)*34,y=200/2-40+sin(spawn_t*0.2)*12,dx=cos(i*2*math.pi/20)*0.1*8.8,dy=sin(i*2*math.pi/20)*0.1*8.8,bt=spawn_t})
            end
            spawn_t=spawn_t+12
        end
    end
end