-- bullet spawning logic

function stage1()
    -- stage 1 doesn't use shared bullet update
    for i=#bullets,1,-1 do
        bullets[i].x=160+bullets[i][1]*cos(t*0.004*8.8+pi/2)
        bullets[i].y=100+bullets[i][1]*sin(t*0.004*8.8+pi/2)
    end
end

function stage2()
    while t-lastspawn>=3 do
        lastspawn=lastspawn+3
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*0.4)*0.2*8.8,dy=sin(lastspawn*0.4)*0.2*8.8,bt=lastspawn})
    end
end

function stage3()
    local acc=3+sin(t*0.04)*2.5
    while t-lastspawn>=acc do
        lastspawn=lastspawn+acc
        ins(bullets,{x=320/2,y=200/2-40,dx=cos(lastspawn*0.4)*0.2*8.8,dy=sin(lastspawn*0.4)*0.2*8.8,bt=lastspawn})
    end
end

function stage4()
    while t-lastspawn>=3 do
        lastspawn=lastspawn+3
        ins(bullets,{x=320/2+cos(lastspawn*0.09)*34,y=200/2-40+sin(lastspawn*0.12)*12,dx=cos(lastspawn*0.07)*0.1*8.8,dy=sin(lastspawn*0.09)*0.1*8.8,bt=lastspawn})
    end
end

function stage5()
    while t-lastspawn>=2 do
        lastspawn=lastspawn+2
        ins(bullets,{x=320/2+cos(lastspawn*0.02)*34,y=200/2-40+sin(lastspawn*0.03)*12,dx=cos(lastspawn*0.22)*0.1*8.8,dy=sin(lastspawn*0.35)*0.1*8.8,bt=lastspawn})
    end
end

function stage6()
    while t-lastspawn>=12 do
        lastspawn=lastspawn+12
        for i=0,10-1 do
        ins(bullets,{x=320/2+cos(lastspawn*0.3)*34,y=200/2-40+sin(lastspawn*0.2)*12,dx=cos(i*2*math.pi/10)*0.1*8.8,dy=sin(i*2*math.pi/10)*0.1*8.8,bt=lastspawn})
        end
    end
end

function stage7()
    while t-lastspawn>=3 do
        lastspawn=lastspawn+3
        local acc=151.8
        local sep=4
        for i=0,1-1 do
        ins(bullets,{x=320/2-40,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*sep)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*sep)*0.15*8.8,bt=lastspawn})
        end
        acc=-acc
        for i=0,1-1 do
        ins(bullets,{x=320/2+40,y=200/2-40,dx=-cos(lastspawn*0.41*acc-i*sep)*0.15*8.8,dy=-sin(lastspawn*0.41*acc-i*sep)*0.15*8.8,bt=lastspawn})
        end
    end
end

function stage8()
    while t-lastspawn>=0 do
        lastspawn=lastspawn+48
        local acc=14.1
        local sphere=24
        local xpos=sin(lastspawn*0.01)*40
        for i=0,sphere-1 do
        ins(bullets,{x=320/2-xpos,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,bt=lastspawn})
        end
        for i=0,sphere-1 do
        ins(bullets,{x=320/2+xpos,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*2*math.pi/sphere)*0.15*8.8,bt=lastspawn})
        end
    end
end

function stage9()
    while t-lastspawn>=3 do
        lastspawn=lastspawn+3
        local acc=13.8
        local sep=4.2
        for i=0,2-1 do
        ins(bullets,{x=320/2-40,y=200/2-40,dx=cos(lastspawn*0.41*acc+i*sep)*0.15*8.8,dy=sin(lastspawn*0.41*acc+i*sep)*0.15*8.8,bt=lastspawn})
        end
        acc=-acc
        for i=0,2-1 do
        ins(bullets,{x=320/2+40,y=200/2-40,dx=-cos(lastspawn*0.41*acc-i*sep)*0.15*8.8,dy=-sin(lastspawn*0.41*acc-i*sep)*0.15*8.8,bt=lastspawn})
        end
    end
end

function stage25()
    if score>hiscores[circuit] then
        while t-lastspawn>=12 do
            lastspawn=lastspawn+12
            for i=0,20-1 do
            ins(bullets,{safe=true,x=320/2+cos(lastspawn*0.3)*34,y=200/2-40+sin(lastspawn*0.2)*12,dx=cos(i*2*math.pi/20)*0.1*8.8,dy=sin(i*2*math.pi/20)*0.1*8.8,bt=lastspawn})
            end
        end
    end
end