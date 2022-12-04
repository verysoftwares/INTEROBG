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
    while t-lastspawn>=3 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*0.4)*0.2*8.8,dy=sin(lastspawn*0.4)*0.2*8.8,bt=lastspawn})
        lastspawn=lastspawn+3
    end
end

function stage3()
    local acc=3+sin(t*0.04)*2.5
    while t-lastspawn>=acc do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*0.4)*0.2*8.8,dy=sin(lastspawn*0.4)*0.2*8.8,bt=lastspawn})
        lastspawn=lastspawn+acc
    end
end

function stage4()
    while t-lastspawn>=3 do
        ins(bullets,{x=320/2+cos(lastspawn*0.09)*34,y=200/2-40+sin(lastspawn*0.12)*12,dx=cos(lastspawn*0.07)*0.1*8.8,dy=sin(lastspawn*0.09)*0.1*8.8,bt=lastspawn})
        lastspawn=lastspawn+3
    end
end

function stage5()
    while t-lastspawn>=2 do
        ins(bullets,{x=320/2+cos(lastspawn*0.02)*34,y=200/2-40+sin(lastspawn*0.03)*12,dx=cos(lastspawn*0.22)*0.1*8.8,dy=sin(lastspawn*0.35)*0.1*8.8,bt=lastspawn})
        lastspawn=lastspawn+2
    end
end

function stage6()
    while t-lastspawn>=12 do
        for i=0,10-1 do
        ins(bullets,{x=320/2+cos(lastspawn*0.3)*34,y=200/2-40+sin(lastspawn*0.2)*12,dx=cos(i*2*math.pi/10)*0.1*8.8,dy=sin(i*2*math.pi/10)*0.1*8.8,bt=lastspawn})
        end
        lastspawn=lastspawn+12
    end
end

function stage7()
    while t-lastspawn>=3 do
        local acc=151.8
        local sep=4
        for i=0,1-1 do
        ins(bullets,{x=320/2-40,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*sep)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*sep)*0.15*8.8,bt=lastspawn})
        end
        acc=-acc
        for i=0,1-1 do
        ins(bullets,{x=320/2+40,y=200/2-40,dx=-cos(lastspawn*0.41*acc-i*sep)*0.15*8.8,dy=-sin(lastspawn*0.41*acc-i*sep)*0.15*8.8,bt=lastspawn})
        end
        lastspawn=lastspawn+3
    end
end

function stage8()
    while t-lastspawn>=0 do
        local acc=14.1
        local sphere=24
        local xpos=sin(lastspawn*0.01)*40
        for i=0,sphere-1 do
        ins(bullets,{x=320/2-xpos,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,bt=lastspawn})
        end
        for i=0,sphere-1 do
        ins(bullets,{x=320/2+xpos,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,bt=lastspawn})
        end
        lastspawn=lastspawn+48
    end
end

function stage9()
    while t-lastspawn>=3 do
        local acc=13.8
        local sep=4.2
        for i=0,2-1 do
        ins(bullets,{x=320/2-40,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*sep)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*sep)*0.15*8.8,bt=lastspawn})
        end
        acc=-acc
        for i=0,2-1 do
        ins(bullets,{x=320/2+40,y=200/2-40,dx=-cos(lastspawn*0.41*acc-i*sep)*0.15*8.8,dy=-sin(lastspawn*0.41*acc-i*sep)*0.15*8.8,bt=lastspawn})
        end
        lastspawn=lastspawn+3
    end
end

function stage10()
    while t-lastspawn>=3 do
        --[[if lastspawn%48<24 then
        ins(bullets,{x=320/2-40+cos(lastspawn*0.12)*34,y=200/2-40,bt=lastspawn})
        else
        ins(bullets,{x=320/2+40-cos(lastspawn*0.12)*34,y=200/2-40,bt=lastspawn})
        end]]
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*131.1)*0.1*8.8,dy=sin(lastspawn*131.1)*0.1*8.8,bt=lastspawn})
        if lastspawn%48<12 then
        local a=math.atan2(y-bullets[#bullets].y,x-bullets[#bullets].x)
        bullets[#bullets].dx=cos(a)*0.2*8.8
        bullets[#bullets].dy=sin(a)*0.2*8.8
        end
        lastspawn=lastspawn+3
    end
end

function stage11()
    while t-lastspawn>=3 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*5.12)*0.2*8.8,dy=sin(lastspawn*5.12)*0.2*8.8,bt=lastspawn})
        if lastspawn%48<24 then
        ins(bullets,{x=320/2-40+cos(lastspawn*0.12)*34,y=200/2-40,bt=lastspawn})
        local a=math.atan2(y-bullets[#bullets].y,x-bullets[#bullets].x)
        bullets[#bullets].dx=cos(a)*0.2*8.8
        bullets[#bullets].dy=sin(a)*0.2*8.8
        else
        ins(bullets,{x=320/2+40+cos(lastspawn*0.12)*34,y=200/2-40,bt=lastspawn})
        local a=math.atan2(y-bullets[#bullets].y,x-bullets[#bullets].x)
        bullets[#bullets].dx=cos(a)*0.2*8.8
        bullets[#bullets].dy=sin(a)*0.2*8.8
        end
        lastspawn=lastspawn+3
    end
end

function stage12()
    if not spec.homer then
        spec.homer={x=320/2,y=200/2-40,bt=lastspawn}
        ins(bullets,spec.homer)
    end
    
    while t-lastspawn>=1 do
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*5.16)*0.12*8.8,dy=sin(lastspawn*5.16)*0.12*8.8,bt=lastspawn})
        lastspawn=lastspawn+1
    end

    local a=math.atan2(y-spec.homer.y,x-spec.homer.x)
    spec.homer.dx=cos(a)*0.06*8.8
    spec.homer.dy=sin(a)*0.06*8.8
end

function stage25()
    if score>hiscores[circuit] then
        while t-lastspawn>=12 do
            for i=0,20-1 do
            ins(bullets,{safe=true,x=320/2+cos(lastspawn*0.3)*34,y=200/2-40+sin(lastspawn*0.2)*12,dx=cos(i*2*math.pi/20)*0.1*8.8,dy=sin(i*2*math.pi/20)*0.1*8.8,bt=lastspawn})
            end
            lastspawn=lastspawn+12
        end
    end
end